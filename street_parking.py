#------------------------------------------------------------------------------#
#   Parking lane analysis with OSM data                                        #
#------------------------------------------------------------------------------#
#   OSM data processing for QGIS/PyGIS to generate street parking data.        #
#   Run this Overpass query -> https://overpass-turbo.eu/s/1q1g                #
#   and save the result at 'data/input.geojson' (or another directory, if      #
#   specified otherwise in the directory variable) before running this script. #
#                                                                              #
#   > version/date: 2023-01-31                                                 #
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
#   V a r i a b l e s   a n d   S e t t i n g s                                #
#------------------------------------------------------------------------------#

from qgis.core import *
from os.path import exists
import os, processing, math, time

#working directory, see https://stackoverflow.com/a/65543293/729221
from console.console import _console
dir = _console.console.tabEditorWidget.currentWidget().path.replace("street_parking.py","")
dir_input = dir + 'data/input.geojson'
dir_output = dir + 'data/output/'

#coordinate reference system
#Attention: EPSG:25833 (ETRS89 / UTM zone 33N) is used here – other CRS may be necessary at other locations.
#A metric CRS is necessary to calculate with metre units and distances.
crs_from = "EPSG:4326"
crs_to = "EPSG:25833"
transform_context = QgsCoordinateTransformContext()
transform_context.addCoordinateOperation(QgsCoordinateReferenceSystem(crs_from), QgsCoordinateReferenceSystem(crs_to), "")
coordinateTransformContext=QgsProject.instance().transformContext()
save_options = QgsVectorFileWriter.SaveVectorOptions()
save_options.driverName = 'GeoJSON'
save_options.ct = QgsCoordinateTransform(QgsCoordinateReferenceSystem(crs_from), QgsCoordinateReferenceSystem(crs_to), coordinateTransformContext)

#default width of streets (if not specified more precisely on the data object)
width_minor_street = 11
width_primary_street = 17
width_secondary_street = 15
width_tertiary_street = 13
width_service = 4
width_driveway = 2.5

#default width of parking lanes (if not specified more precisely on the data object)
width_para = 2   #parallel parking -----
width_diag = 4.5 #diagonal parking /////
width_perp = 5   #perpendicular p. |||||

#parking space length / distance per vehicle depending on parking direction
#TODO: Attention: In some calculation steps that use field calculator formulas, these values are currently still hardcoded – if needed, the formulas would have to be generated as a string using these variables
car_dist_para = 5.2     #parallel parking
car_dist_diag = 3.1     #diagonal parking (angle: 60 gon = 54°)
car_dist_perp = 2.5     #perpendicular parking
car_length = 4.4        #average motor car length (a single car, without manoeuvring distance)
car_width = 1.8         #average motor car width

bus_dist_para = 12      #parallel parking
bus_dist_diag = 5       #diagonal parking
bus_dist_perp = 4       #perpendicular parking
bus_length = 12         #average bus length
bus_width = 2.5         #average bus width
hgv_articulated_length = 16 #average length of semi-trailer trucks – currently not in use

area_parking_place = 12 #square meters per parking space on separately mapped parking areas - for calculating capacities of parking areas without capacity and orientation attributes

#buffers/radii kept free at certain objects (meter)
buffer_driveway           = 4   #4   //free space at driveways
buffer_traffic_signals    = 10  #10  //in front of traffic lights
buffer_crossing_primary   = 4.5 #4.5 //on traffic signal and zebra crossings
buffer_crossing_marked    = 2   #2   //on other marked crossings
buffer_crossing_protected = 3   #3   //on crossings protected by buffer markings, kerb extensions etc.
buffer_bus_stop           = 15  #15  //at bus stops
buffer_bus_stop_range     = 2   #2   //Distance where segments with parking lanes are searched for cutting at bus stops (must always be >= than "buffer_bus_stop")
buffer_turning_circle     = 10  #10  //at turning circles
buffer_turning_loop       = 15  #15  //at turning loops

process_parking_obstacles   = True # If True, parking segments are cutted where lane installations and obstacles are located (on lane bicycle parking, parkletts, street furniture marked as obstacles...)
process_separate_parking    = True # If True, separately mapped street parking areas and nodes are included and converted into lines that fit as closely as possible
process_separate_area_width = True # If True, width and missing orientation values of separately mapped parking areas are derived from the geometry (high computing costs).
create_point_chain          = True # If True, an extra layer with points for each individual vehicle will be created from the parking lanes

#list of highway tags that belong to the regular road network
is_road_list = ['primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'unclassified', 'living_street', 'pedestrian', 'road']

#list of attributes kept for the street layer
#Note: Certain width specifications are also processed (fillBaseAttributes()), but they should not be specified here.
#"error_output" is a new attribute to collect errors and inconsistencies
street_key_list = [
'id',
'highway',
'name',
#'access',
'oneway',
'width_proc',
'width_proc:effective',
'surface',
'parking:left',
'parking:right',
'parking:left:orientation',
'parking:right:orientation',
'parking:left:width',
'parking:right:width',
'parking:left:width:carriageway',
'parking:right:width:carriageway',
'parking:left:offset',
'parking:right:offset',
'parking_source',
'error_output'
]

#List of attributes from highway processing that are transfered to the initial highway parking layers.
#All parking:left*/right*/both*-tags are also stored.
#Note: In prepareLayers(), specifications are prefixed with "highway:" to clarify the attribute as a road property.
parking_processing_key_list = [
'id',
'highway',
'name',
'access',
'vehicle',
'motor_vehicle',
'surface',
'oneway',
'width_proc',
'width_proc:effective',
'parking_source',
'error_output'
]

#attributes for the final parking layer
parking_attribute_list = [
'id',
'side',
'highway',
'highway:name',
#'highway:access',
'highway:oneway',
'parking',
'orientation',
'capacity',
'source:capacity',
'surface',
'markings',
'markings:type',
'width',
'condition_class',
'vehicle_designated',
'vehicle_excluded',
'zone',
'parking_source',
'error_output'
]



#------------------------------------------------------------------------------#
#   V a r i a b l e s   E n d                                                  #
#------------------------------------------------------------------------------#



def clearAttributes(layer, attributes):
#-------------------------------------------------------------------------------
# Deletes unnecessary attributes.
#-------------------------------------------------------------------------------
# > layer: The layer to be cleaned up.
# > attributes: List of attributes that should be kept.
#-------------------------------------------------------------------------------
    attr_count = len(layer.attributeList())
    delete_list = []
    for id in range(0, attr_count):
        if not layer.attributeDisplayName(id) in attributes:
            delete_list.append(layer.attributeDisplayName(id))
    layer = processing.run('qgis:deletecolumn', { 'INPUT' : layer, 'COLUMN' : delete_list, 'OUTPUT': 'memory:'})['OUTPUT']
    return(layer)



def prepareLayers():
#-------------------------------------------------------------------------------
# Read input file, process and interpolate street and parking lane data
# and provide separate layers for further processing:
# (1) street layer (esp. for rendering),
# (2) service way layer (esp. for processing of driveways)
# (3) street parking (left side of the road)
# (4) street parking (right side of the road)
# (5) point layer for crossing processing etc.
# (6) polygon layer for processing of separately mapped street parking
# (7) line layer for processing parking obstacles
#-------------------------------------------------------------------------------
    print(time.strftime('%H:%M:%S', time.localtime()), 'Read data...')
    if not exists(dir_input):
        print(time.strftime('%H:%M:%S', time.localtime()), '[!] Error: Found no valid input at "' + dir_input + '".')
        return False
    layer_lines = QgsVectorLayer(dir_input + '|geometrytype=LineString', 'input line data', 'ogr')
    layer_points = QgsVectorLayer(dir_input + '|geometrytype=Point', 'input point data', 'ogr')
    if(process_separate_parking or process_parking_obstacles):
        layer_polygons = QgsVectorLayer(dir_input + '|geometrytype=Polygon', 'input polygon data', 'ogr')
    else:
        layer_polygons = NULL

    print(time.strftime('%H:%M:%S', time.localtime()), 'Reproject layers...')
    layer_lines = processing.run('native:reprojectlayer', { 'INPUT' : layer_lines, 'TARGET_CRS' : QgsCoordinateReferenceSystem(crs_to), 'OUTPUT': 'memory:'})['OUTPUT']
    layer_points = processing.run('native:reprojectlayer', { 'INPUT' : layer_points, 'TARGET_CRS' : QgsCoordinateReferenceSystem(crs_to), 'OUTPUT': 'memory:'})['OUTPUT']
    if layer_polygons is not NULL:
        layer_polygons = processing.run('native:reprojectlayer', { 'INPUT' : layer_polygons, 'TARGET_CRS' : QgsCoordinateReferenceSystem(crs_to), 'OUTPUT': 'memory:'})['OUTPUT']

    #Straßen- und Parkstreifenattribute vorbereiten
    print(time.strftime('%H:%M:%S', time.localtime()), 'Prepare street data...')
    layer_lines = fillBaseAttributes(layer_lines)
    layer_street = clearAttributes(layer_lines, street_key_list)
    expr_street = expr_service = ''
    expr_connect = 0
    for cat in is_road_list:
        if expr_connect:
            expr_street += ' OR '
            expr_service += ' AND '
        else:
            expr_connect = 1
        expr_street += '"highway" IS \'' + cat + '\''
        expr_service += '"highway" IS NOT NULL AND "highway" IS NOT \'' + cat + '\''
    layer_service = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_street, 'EXPRESSION' : expr_service, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_street = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_street, 'EXPRESSION' : expr_street, 'OUTPUT': 'memory:'})['OUTPUT']

    QgsProject.instance().addMapLayer(layer_street, False)
    group_streets.insertChildNode(0, QgsLayerTreeLayer(layer_street))
    QgsProject.instance().addMapLayer(layer_service, False)
    group_streets.insertChildNode(0, QgsLayerTreeLayer(layer_service))

    #Parkstreifen separat vorbereiten
    print(time.strftime('%H:%M:%S', time.localtime()), 'Clean street parking attributes...')
    attr_list = []
    for id in range(0, len(layer_lines.attributeList())):
        attr_name = layer_lines.attributeDisplayName(id)
        if attr_name in parking_processing_key_list or 'parking:left' in attr_name or 'parking:right' in attr_name or 'parking:both' in attr_name:
            attr_list.append(attr_name)
    layer_parking_lanes = clearAttributes(layer_lines, attr_list)

    #exclude service ways without parking information
    print(time.strftime('%H:%M:%S', time.localtime()), 'Split parking lane sides...')
    expr_both = expr_street + ' OR ((' + expr_service + ') AND ("parking:left" IS NOT NULL OR "parking:right" IS NOT NULL OR "parking:left:orientation" IS NOT NULL OR "parking:right:orientation" IS NOT NULL))'
    layer_parking_lanes = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lanes, 'EXPRESSION' : expr_both, 'OUTPUT': 'memory:'})['OUTPUT']

    #keep some street attributes in new attributes with prefix
    QgsProject.instance().addMapLayer(layer_parking_lanes, False)
    with edit(layer_parking_lanes):
        for attr in parking_processing_key_list:
            if attr != 'id' and attr != 'highway' and attr != 'parking_source' and attr != 'error_output':
                layer_parking_lanes.renameAttribute(layer_parking_lanes.fields().indexOf(attr), 'highway:' + attr)

    #split up left and right street parking layer
    expr_left = expr_street + ' OR ((' + expr_service + ') AND ("parking:left" IS NOT NULL OR "parking:left:orientation" IS NOT NULL))'
    expr_right = expr_street + ' OR ((' + expr_service + ') AND ("parking:right" IS NOT NULL OR "parking:right:orientation" IS NOT NULL))'
    layer_parking_left = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lanes, 'EXPRESSION' : expr_left, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_right = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lanes, 'EXPRESSION' : expr_right, 'OUTPUT': 'memory:'})['OUTPUT']

    #prepare street parking attributes
    layer_parking_left = prepareParkingLane(layer_parking_left, 'left', True)
    layer_parking_right = prepareParkingLane(layer_parking_right, 'right', True)

    return([layer_street, layer_service, layer_parking_left, layer_parking_right, layer_points, layer_polygons, layer_lines])



def fillBaseAttributes(layer):
#-------------------------------------------------------------------------------
# Get base attributes for streets like width information and
# get left and right parking lane attributes.
#-------------------------------------------------------------------------------
# > layer: layer with street and parking lane information.
#-------------------------------------------------------------------------------
    layer.startEditing()

    #Breiten- und Parkstreifenattribute anlegen, falls diese nicht existieren
    for attr in street_key_list:
        if layer.fields().indexOf(attr) == -1:
            layer.dataProvider().addAttributes([QgsField(attr, QVariant.String)])
    layer.updateFields()

    id_width = layer.fields().indexOf('width_proc')
    id_width_effective = layer.fields().indexOf('width_proc:effective')
    id_parking_left = layer.fields().indexOf('parking:left')
    id_parking_right = layer.fields().indexOf('parking:right')
    id_parking_left_orientation = layer.fields().indexOf('parking:left:orientation')
    id_parking_right_orientation = layer.fields().indexOf('parking:right:orientation')
    id_parking_left_width = layer.fields().indexOf('parking:left:width')
    id_parking_right_width = layer.fields().indexOf('parking:right:width')
    id_parking_left_width_carriageway = layer.fields().indexOf('parking:left:width:carriageway')
    id_parking_right_width_carriageway = layer.fields().indexOf('parking:right:width:carriageway')
    id_parking_left_offset = layer.fields().indexOf('parking:left:offset')
    id_parking_right_offset = layer.fields().indexOf('parking:right:offset')
    id_parking_source = layer.fields().indexOf('parking_source')
    id_error = layer.fields().indexOf('error_output')

    if layer.fields().indexOf('parking:both') + layer.fields().indexOf('parking:both:orientation') + id_parking_left + id_parking_left_orientation + id_parking_right + id_parking_right_orientation == -6:
        print(time.strftime('%H:%M:%S', time.localtime()), 'NOTE: Input dataset ("' + dir_input + '") does not contain street parking information ("parking:left/right/both")!')

    #Basisattribute ermitteln
    id_width = layer.fields().indexOf('width_proc')
    wd = layer.fields().indexOf('width')
    wd_car = layer.fields().indexOf('width:carriageway')
    wd_est = layer.fields().indexOf('est_width')
    constr = layer.fields().indexOf('construction')
    for feature in layer.getFeatures():
        error = ''

        #Parkposition ermitteln (auf der Fahrbahn, auf dem Gehweg, in Parkbucht etc.)
        parking_left = feature.attribute('parking:left')
        parking_right = feature.attribute('parking:right')
        parking_source = 'highway_side'
        if layer.fields().indexOf('parking:both') != -1:
            parking_both = feature.attribute('parking:both')
            if parking_both != NULL:
                if parking_left == NULL:
                    parking_left = parking_both
                    parking_source = 'highway_both'
                    layer.changeAttributeValue(feature.id(), id_parking_left, parking_both)
                else:
                    error += '[p01l] Attribute "parking:left" und "parking:both" gleichzeitig vorhanden. '
                if parking_right == NULL:
                    parking_right = parking_both
                    parking_source = 'highway_both'
                    layer.changeAttributeValue(feature.id(), id_parking_right, parking_both)
                else:
                    error += '[p01r] Attribute "parking:right" und "parking:both" gleichzeitig vorhanden. '
            else:
                if (not parking_left or not parking_right) and feature.attribute('highway') in is_road_list:
                    error += '[no_p] Parkstreifeninformation nicht für alle Seite vorhanden. '
        else:
            if (not parking_left or not parking_right) and feature.attribute('highway') in is_road_list:
                error += '[no_p] Parkstreifeninformation nicht für alle Seite vorhanden. '

        #Parkausrichtung ermitteln (längs, schräg, quer)
        parking_left_orientation = feature.attribute('parking:left:orientation')
        parking_right_orientation = feature.attribute('parking:right:orientation')
        if layer.fields().indexOf('parking:both:orientation') != -1:
            parking_both_orientation = feature.attribute('parking:both:orientation')
            if parking_both_orientation != NULL:
                if parking_left_orientation == NULL:
                    parking_left_orientation = parking_both_orientation
                    layer.changeAttributeValue(feature.id(), id_parking_left_orientation, parking_both_orientation)
                else:
                    error += '[p02l] Attribute "parking:left:orientation" und "parking:both:orientation" gleichzeitig vorhanden. '
                if parking_right_orientation == NULL:
                    parking_right_orientation = parking_both_orientation
                    layer.changeAttributeValue(feature.id(), id_parking_right_orientation, parking_both_orientation)
                else:
                    error += '[p02r] Attribute "parking:right:orientation" und "parking:both:orientation" gleichzeitig vorhanden. '
            else:
                if ((parking_left and parking_left not in ['no', 'separate'] and not parking_left_orientation) or (parking_right and parking_right not in ['no', 'separate'] and not parking_right_orientation)) and feature.attribute('highway') in is_road_list:
                    error += '[no_po] Parkstreifenausrichtung nicht für alle Seite vorhanden. '
        else:
            if ((parking_left and parking_left not in ['no', 'separate'] and not parking_left_orientation) or (parking_right and parking_right not in ['no', 'separate'] and not parking_right_orientation)) and feature.attribute('highway') in is_road_list:
                error += '[no_po] Parkstreifenausrichtung nicht für alle Seite vorhanden. '

        parking_left_width = 0; parking_right_width = 0
        if parking_left_orientation or parking_right_orientation:
            #Parkstreifenbreite ermitteln
            if layer.fields().indexOf('parking:left:width') != -1:
                parking_left_width = feature.attribute('parking:left:width')
            if layer.fields().indexOf('parking:right:width') != -1:
                parking_right_width = feature.attribute('parking:right:width')
            if layer.fields().indexOf('parking:both:width') != -1:
                parking_both_width = feature.attribute('parking:both:width')
                if parking_both_width != NULL:
                    if parking_left_width == NULL:
                        parking_left_width = parking_both_width
                        layer.changeAttributeValue(feature.id(), id_parking_left_width, parking_both_width)
                    else:
                        error += '[p03l] Attribute "parking:left:width" und "parking:both:width" gleichzeitig vorhanden. '
                    if parking_right_width == NULL:
                        parking_right_width = parking_both_width
                        layer.changeAttributeValue(feature.id(), id_parking_right_width, parking_both_width)
                    else:
                        error += '[p03r] Attribute "parking:right:width" und "parking:both:width" gleichzeitig vorhanden. '
            #Parkstreifenbreite aus Parkrichtung abschätzen, wenn nicht genauer angegeben
            if parking_left_width == NULL:
                parking_left_width = 0
                if parking_left_orientation == 'parallel':
                    parking_left_width = width_para
                if parking_left_orientation == 'diagonal':
                    parking_left_width = width_diag
                if parking_left_orientation == 'perpendicular':
                    parking_left_width = width_perp

            if parking_right_width == NULL:
                parking_right_width = 0
                if parking_right_orientation == 'parallel':
                    parking_right_width = width_para
                if parking_right_orientation == 'diagonal':
                    parking_right_width = width_diag
                if parking_right_orientation == 'perpendicular':
                    parking_right_width = width_perp

            layer.changeAttributeValue(feature.id(), id_parking_left_width, parking_left_width)
            layer.changeAttributeValue(feature.id(), id_parking_right_width, parking_right_width)

        #Fahrbahnbreite ermitteln
        width = NULL
        #Mögliche vorhandene Breitenattribute prüfen: width:carriageway, width, est_width
        if wd_car != -1:
            width = feature.attribute('width:carriageway')
        if width == NULL and wd != -1 :
            width = feature.attribute('width')
        if width == NULL and wd_est != -1:
            width = feature.attribute('est_width')

        #Einheiten korrigieren
        if width != NULL:
            unit_list = ['cm', 'm', ' cm', ' m']
            for unit in unit_list:
                if unit in width:
                    width = width[:len(width) - len(unit)]
                    if 'cm' in unit:
                        width = width / 100

        #Ansonsten Breite aus anderen Straßenattributen abschätzen
        if width == NULL or not isfloat(width):
            highway = feature.attribute('highway')
            if highway == 'primary':
                width = width_primary_street
            if highway == 'secondary':
                width = width_secondary_street
            if highway == 'tertiary':
                width = width_tertiary_street
            if highway not in is_road_list:
                width = width_service
                if layer.fields().indexOf('service') != -1:
                    if feature.attribute('service') == 'driveway':
                        width = width_driveway
            if highway == 'construction':
                if constr:
                    construction = feature.attribute('highway')
                    if construction == 'primary':
                        width = width_primary_street
                    if construction == 'secondary':
                        width = width_secondary_street
                    if construction == 'tertiary':
                        width = width_tertiary_street
                    if construction not in is_road_list:
                        width = width_service

            if width == NULL:
                width = width_minor_street
        layer.changeAttributeValue(feature.id(), id_width, width)

        #Offset der Parkstreifen für spätere Verschiebung ermitteln (offset-Linie liegt am Bordstein)
        parking_left_width_carriageway = 0
        parking_right_width_carriageway = 0
        if parking_left_orientation in ['parallel', 'diagonal', 'perpendicular']:
            parking_left_width_carriageway = parking_left_width
            if parking_left == 'half_on_kerb':
                parking_left_width_carriageway = parking_left_width_carriageway / 2
            if parking_left in ['on_kerb', 'shoulder', 'street_side']:
                parking_left_width_carriageway = 0
        if parking_right_orientation in ['parallel', 'diagonal', 'perpendicular']:
            parking_right_width_carriageway = parking_right_width
            if parking_right == 'half_on_kerb':
                parking_right_width_carriageway = parking_right_width_carriageway / 2
            if parking_right in ['on_kerb', 'shoulder', 'street_side']:
                parking_right_width_carriageway = 0

        width_effective = float(width) - float(parking_left_width_carriageway) - float(parking_right_width_carriageway)
        parking_left_offset = (width_effective / 2) + float(parking_left_width_carriageway)
        parking_right_offset = -(width_effective / 2) - float(parking_right_width_carriageway)

        layer.changeAttributeValue(feature.id(), id_width_effective, width_effective)
        layer.changeAttributeValue(feature.id(), id_parking_left_width_carriageway, parking_left_width_carriageway)
        layer.changeAttributeValue(feature.id(), id_parking_right_width_carriageway, parking_right_width_carriageway)
        layer.changeAttributeValue(feature.id(), id_parking_left_offset, parking_left_offset)
        layer.changeAttributeValue(feature.id(), id_parking_right_offset, parking_right_offset)
        layer.changeAttributeValue(feature.id(), id_parking_source, parking_source)

        #Mögliche Fehlermeldungen in Attribut speichern
        if error == '':
            error = NULL
        layer.changeAttributeValue(feature.id(), id_error, error)

    layer.updateFields()
    layer.commitChanges()

    return(layer)



def isfloat(num):
    try:
        float(num)
        return True
    except ValueError:
        return False



def prepareParkingLane(layer, side, clean):
#-------------------------------------------------------------------------------
# Converts street parking attributes for both directions into separate,
# grouped attributes and interpret parking restrictions.
#-------------------------------------------------------------------------------
# > layer: The layer for which the street parking information is to be aggregated.
# > side:  ('left' or 'right'): Side of the street that is represented by the layer.
# > clean: (True or False): Clean up attribute table after processing?
#-------------------------------------------------------------------------------

    id_left = layer.fields().indexOf('parking:left')
    id_right = layer.fields().indexOf('parking:right')

    layer.startEditing()

    #Neue Attribute für Parkstreifeninformationen erstellen und deren ID's zur späteren Bearbeitung ermitteln
    attribute_list = parking_attribute_list
    attribute_list.append('offset')
    for attr in attribute_list:
        if layer.fields().indexOf(attr) == -1:
            layer.dataProvider().addAttributes([QgsField(attr, QVariant.String)])
    layer.updateFields()

    id_id = layer.fields().indexOf('id')
    id_side = layer.fields().indexOf('side')
    id_parking = layer.fields().indexOf('parking')
    id_orientation = layer.fields().indexOf('orientation')
    id_capacity = layer.fields().indexOf('capacity')
    id_source_capacity = layer.fields().indexOf('source:capacity')
    id_surface = layer.fields().indexOf('surface')
    id_markings = layer.fields().indexOf('markings')
    id_markings_type = layer.fields().indexOf('markings:type')
    id_width = layer.fields().indexOf('width')
    id_offset = layer.fields().indexOf('offset')
    id_condition_class = layer.fields().indexOf('condition_class')
    id_vehicle_designated = layer.fields().indexOf('vehicle_designated')
    id_vehicle_excluded = layer.fields().indexOf('vehicle_excluded')
    id_zone = layer.fields().indexOf('zone')
    id_parking_source = layer.fields().indexOf('parking_source')
    id_error = layer.fields().indexOf('error_output')

    #Straßenabschnitte einzeln durchgehen und Parkstreifeninformationen zusammenfassend auslesen
    for feature in layer.getFeatures():
        parking = NULL
        orientation = NULL
        capacity = NULL
        source_capacity = NULL
        surface = NULL
        markings = NULL
        markings_type = NULL
        width = NULL
        condition_class = NULL
        vehicle_designated = vehicle_excluded = NULL
        zone = NULL
        offset = NULL
        parking_source = NULL

        #Relevante parkstreifenseitige Fehlermeldungen übernehmen, falls vorhanden
        error = feature.attribute('error_output')
        error_new = ''
        if error != NULL:
            for i in range(1, 4):
                error_code = '[p0' + str(i) + side[:1] + ']'
                if error_code in error:
                    f_string = error[error.find(error_code):]
                    if not '[' in f_string[1:]:
                        error_new += f_string
                    else:
                        f_stop = f_string[1:].find('[') + 1
                        error_new += f_string[:f_stop]
        error = error_new

        #read base attributes for parking (reading "both" not necessary, since "fillBaseAttributes" already splitted attributes to left and right for parking, orientation and width)
        if side == 'left' and id_left != -1:
            parking = feature.attribute('parking:left')
            orientation = feature.attribute('parking:left:orientation')

        if side == 'right' and id_right != -1:
            parking = feature.attribute('parking:right')
            orientation = feature.attribute('parking:right:orientation')

        if parking not in ['lane', 'street_side', 'on_kerb', 'half_on_kerb', 'shoulder', 'separate', 'no']:
            parking = NULL
        if orientation not in ['parallel', 'diagonal', 'perpendicular']:
            orientation = NULL

        if parking in ['lane', 'street_side', 'on_kerb', 'half_on_kerb', 'shoulder'] or orientation:
            source_capacity = 'estimated'
        else:
            source_capacity = NULL
 
        offset = feature.attribute('parking:' + side + ':offset')

        #surface: get from highway, if not specified for parking lane
        surface = getSideAttribute(layer, feature, side, 'surface', 0)
        if not surface:
            highway_surface = feature.attribute('highway:surface')
            if highway_surface:
                surface = highway_surface

        #read markings
        markings = getSideAttribute(layer, feature, side, 'markings', 0)
        markings_type = getSideAttribute(layer, feature, side, 'markings:type', 0)

        #read width (reading "both" not necessary, since "fillBaseAttributes" already splitted attributes to left and right for parking, orientation and width)
        width = feature.attribute('parking:' + side + ':width')

        capacity = getSideAttribute(layer, feature, side, 'capacity', 0)
        if capacity != NULL:
            source_capacity = 'OSM'

        #Parkbeschränkungen interpretieren
        condition_class = getConditionClass(layer, feature, side)[0]
        vehicle_designated = getConditionClass(layer, feature, side)[1]
        vehicle_excluded = getConditionClass(layer, feature, side)[2]

        if condition_class == '':
            condition_class = NULL
        if layer.fields().indexOf('parking:' + side + ':zone') != -1:
            zone = getSideAttribute(layer, feature, side, 'zone', 0)

        #ermittelte Parkstreifeninformationen in die Attributtabelle des Straßenabschnitts übertragen
        layer.changeAttributeValue(feature.id(), id_side, side)
        layer.changeAttributeValue(feature.id(), id_parking, parking)
        layer.changeAttributeValue(feature.id(), id_orientation, orientation)
        layer.changeAttributeValue(feature.id(), id_capacity, capacity)
        layer.changeAttributeValue(feature.id(), id_source_capacity, source_capacity)
        layer.changeAttributeValue(feature.id(), id_surface, surface)
        layer.changeAttributeValue(feature.id(), id_markings, markings)
        layer.changeAttributeValue(feature.id(), id_markings_type, markings_type)
        layer.changeAttributeValue(feature.id(), id_width, width)
        layer.changeAttributeValue(feature.id(), id_offset, offset)
        layer.changeAttributeValue(feature.id(), id_condition_class, condition_class)
        layer.changeAttributeValue(feature.id(), id_vehicle_designated, vehicle_designated)
        layer.changeAttributeValue(feature.id(), id_vehicle_excluded, vehicle_excluded)
        layer.changeAttributeValue(feature.id(), id_zone, zone)

        #Quelle der Parkinformation speichern
        parking_source = feature.attribute('parking_source')
        if parking_source == 'highway_side':
            parking_source = 'highway_' + side
        layer.changeAttributeValue(feature.id(), id_parking_source, parking_source)

        #mögliche Fehlermeldungen dokumentieren
        if error == '':
            error = NULL
        layer.changeAttributeValue(feature.id(), id_error, error)
    layer.commitChanges()

    #Abschließend bei Bedarf nicht mehr benötigte parking-Attribute entfernen
    if clean:
        attr_list = []
        for id in range(0, len(layer.attributeList())):
            attr_name = layer.attributeDisplayName(id)
            if not 'parking:' in attr_name:
                attr_list.append(attr_name)
        layer = clearAttributes(layer, attr_list)

    return(layer)



def getConditionClass(layer, feature, side):
#-------------------------------------------------------------------------------
# Interprets parking restriction tags to create a parking condition class.
#-------------------------------------------------------------------------------
# > layer: The layer that is processed.
# > feature: The feature for which the attribute is to be read.
# > side: The side for which the attribute is to be read (left/right or separate for separately mapped parking areas).
#-------------------------------------------------------------------------------
# > returns:
#   [1] A condition class string with one or more of the following condition classes:
#       free | mixed | residents | paid | time_limited | loading | charging | disabled | disabled_private | taxi | car_sharing | vehicle_restriction | access_restriction | no_parking | no_standing | no_stopping
#   [2] A string containing designated vehicle classes (e.g. motorcar or bus only)
#   [3] A string containing excluded vehicle classes (e.g. no hgv)
#-------------------------------------------------------------------------------

    fee = getSideAttribute(layer, feature, side, 'fee', 1)
    fee_conditional = getSideAttribute(layer, feature, side, 'fee:conditional', 1)
    access = getSideAttribute(layer, feature, side, 'access', 1)
    #if no specific access is given for the parking lane, check whether there is an access restriction for the entire street
    if not access:
        highway_access = NULL
        if layer.fields().indexOf('highway:motor_vehicle') != -1:
            highway_access = feature.attribute('highway:motor_vehicle')
        if not highway_access and layer.fields().indexOf('highway:vehicle') != -1:
            highway_access = feature.attribute('highway:vehicle')
        if not highway_access and layer.fields().indexOf('highway:access') != -1:
            highway_access = feature.attribute('highway:access')
        if highway_access:
            access = highway_access
    access_conditional = getSideAttribute(layer, feature, side, 'access:conditional', 1)
    maxstay = getSideAttribute(layer, feature, side, 'maxstay', 1)
    maxstay_conditional = getSideAttribute(layer, feature, side, 'maxstay:conditional', 1)
    restriction = getSideAttribute(layer, feature, side, 'restriction', 1)
    restriction_conditional = getSideAttribute(layer, feature, side, 'restriction:conditional', 1)

    zone = getSideAttribute(layer, feature, side, 'zone', 1)

    vehicle_class_list=['motorcar', 'disabled', 'bus', 'taxi', 'psv', 'hgv', 'goods', 'car_sharing', 'emergency', 'motorhome']
    access_restriction_class_list=['disabled', 'taxi', 'psv', 'car_sharing', 'emergency']

    #vehicle restrictions
    vehicle_designated = vehicle_excluded = NULL
    vehicle_none_restriction = []
    for vehicle_class in vehicle_class_list:
        vehicle = getSideAttribute(layer, feature, side, vehicle_class, 1)
        vehicle_conditional = getSideAttribute(layer, feature, side, vehicle_class + ':conditional', 1)
        restriction_vehicle = getSideAttribute(layer, feature, side, 'restriction:' + vehicle_class, 1)
        restriction_vehicle_conditional = getSideAttribute(layer, feature, side, 'restriction:' + vehicle_class + ':conditional', 1)

        if restriction_vehicle == 'none' or 'none' in restriction_vehicle_conditional:
            vehicle_none_restriction.append(vehicle_class)

        if vehicle == 'designated' or vehicle == 'yes' or restriction_vehicle == 'none':
            if vehicle_designated == NULL:
                vehicle_designated = vehicle_class
            else:
                vehicle_designated += ';' + vehicle_class
        if vehicle == 'no':
            if vehicle_excluded == NULL:
                vehicle_excluded = vehicle_class
            else:
                vehicle_excluded += ';' + vehicle_class

        cond_designated = getSubCondition(vehicle_conditional, ['designated', 'yes'], 0)
        if cond_designated:
            vehicle_designated = addConditionClass(vehicle_designated, vehicle_class, cond_designated)
        cond_exception = getSubCondition(restriction_vehicle_conditional, 'none', 0)
        if cond_exception:
            vehicle_designated = addConditionClass(vehicle_designated, vehicle_class, restriction_vehicle_conditional)
        cond_no = getSubCondition(vehicle_conditional, 'no', 0)
        if cond_no:
            vehicle_excluded = addConditionClass(vehicle_excluded, vehicle_class, cond_no)

    condition_class = ''

    #mixed parking: fee and residential zone
    fee_cond = getSubCondition(fee_conditional, 'yes', 1)
    no_fee_cond = getSubCondition(fee_conditional, 'no', 1)
    if (fee == 'yes' or fee_cond) and zone != '' and zone != 'no' and zone != 'none':
        condition_class = addConditionClass(condition_class, 'mixed', fee_cond)

    #residential parking only: private access and residential zone
    private_cond = getSubCondition(access_conditional, 'private', 1)
    if (access == 'private' or private_cond) and zone != '' and zone != 'no' and zone != 'none':
        condition_class = addConditionClass(condition_class, 'residents', private_cond)

    #paid public parking: fee, no access restrictions, no residential zone
    if (fee == 'yes' or fee_cond) and (access == 'yes' or access == '') and (zone == '' or zone == 'no' or zone == 'none'):
        condition_class = addConditionClass(condition_class, 'paid', fee_cond)

    #free parking (unmanaged parking: no fee or maxstay, no residential zone)
    if (fee == '' or fee == 'no' or no_fee_cond) and maxstay in ['', 'no', 'none'] and (access in ['', 'yes', 'destination', 'designated', 'permissive'] or listItemIn(['motorcar', 'bus', 'hgv', 'goods', 'motorhome'], vehicle_designated) or listItemIn(['motorcar', 'bus', 'hgv', 'goods', 'motorhome'], vehicle_none_restriction)) and zone in ['', 'no', 'none'] and (restriction in ['', 'no', 'none'] or listItemIn(['motorcar', 'bus', 'hgv', 'goods', 'motorhome'], vehicle_none_restriction)):
        if condition_class != 'mixed' and condition_class != 'residents' and condition_class != 'paid':
            condition_class = addConditionClass(condition_class, 'free', '')

    #loading zone
    loading_cond = getSubCondition(restriction_conditional, 'loading_only', 1)
    if restriction == 'loading_only' or loading_cond:
        condition_class = addConditionClass(condition_class, 'loading', loading_cond)

    #charging
    charging_cond = getSubCondition(restriction_conditional, 'charging_only', 1)
    if restriction == 'charging_only' or charging_cond:
        condition_class = addConditionClass(condition_class, 'charging', charging_cond)

    #private disabled parking
    disabled_conditional = getSideAttribute(layer, feature, side, 'disabled:conditional', 1)
    private_disabled_conditional = getSubCondition(disabled_conditional, 'private', 1)
    if (access == 'no' and getSideAttribute(layer, feature, side, 'disabled', 1) == 'private') or ('no' in access_conditional and private_disabled_conditional):
        condition_class = addConditionClass(condition_class, 'disabled_private', private_disabled_conditional)

    #time limited parking: maxstay
    if maxstay_conditional != '':
        maxstay_interval = getSubCondition(maxstay_conditional, '', 1)
        condition_class = addConditionClass(condition_class, 'time_limited', maxstay_interval)
    else:
        if (maxstay != '' and maxstay != 'no' and maxstay != 'none'):
            condition_class = addConditionClass(condition_class, 'time_limited', '')

    #vehicle_restriction and
    #public disabled, taxi or car sharing: use designated vehicles
    if vehicle_designated and (access == 'no' or 'no' in access_conditional or vehicle_none_restriction):
        vehicle_cond = getSubCondition(vehicle_designated, vehicle, 1)
        #disabled, taxi and car_sharing have their own class
        for vehicle in ['disabled', 'taxi', 'car_sharing']:
            if vehicle in vehicle_designated:
                condition_class = addConditionClass(condition_class, vehicle, vehicle_cond)
        #"vehicle_restriction" is just for some "public" vehicle categories like motorcar, bus or goods
        if not listItemIn(access_restriction_class_list, vehicle_designated):
            condition_class = addConditionClass(condition_class, 'vehicle_restriction', vehicle_cond)

    #access restriction
    #only for access restricted(e.g. private/customer), but not residential parking or parking for special vehicles like emergency vehicles
    access_cond = getSubCondition(access_conditional, '', 1)
    if ((access not in ['', 'yes', 'destination', 'designated', 'permissive'] or access_cond) and not listItemIn(['disabled', 'taxi', 'car_sharing', 'disabled_private', 'residents', 'vehicle_restriction', 'loading', 'charging'], condition_class)):
        condition_class = addConditionClass(condition_class, 'access_restriction', access_cond)

    #temporary no parking
    no_parking_cond = getSubCondition(restriction_conditional, 'no_parking', 1)
    if ('no_parking' in restriction or no_parking_cond) and len(vehicle_none_restriction) < 1:
        condition_class = addConditionClass(condition_class, 'no_parking', no_parking_cond)

    #temporary no standing
    no_standing_cond = getSubCondition(restriction_conditional, 'no_standing', 1)
    if ('no_standing' in restriction or no_standing_cond) and len(vehicle_none_restriction) < 1:
        condition_class = addConditionClass(condition_class, 'no_standing', no_standing_cond)

    #temporary no stopping
    no_stopping_cond = getSubCondition(restriction_conditional, 'no_stopping', 1)
    if ('no_stopping' in restriction or no_stopping_cond) and len(vehicle_none_restriction) < 1:
        condition_class = addConditionClass(condition_class, 'no_stopping', no_stopping_cond)

    #TODO other restrictions (e.g. height or weight restrictions)

    return(condition_class, vehicle_designated, vehicle_excluded)



def listItemIn(list, checkstring):
#-------------------------------------------------------------------------------
# Checks whether on of the strings given in a list is part of a given string
#-------------------------------------------------------------------------------
    if not list or not checkstring:
        return(False)
    for item in list:
        if item in checkstring:
            return(True)
    return(False)



def getSideAttribute(layer, feature, side, key, stringsafe):
#-------------------------------------------------------------------------------
# Reads the value of a specific parking attribute of a feature for a side
# (e.g. "access" in "parking:left/right/both:access").
#-------------------------------------------------------------------------------
# > layer: The layer that is processed.
# > feature: The feature for which the attribute is to be read.
# > side: The side for which the attribute is to be read (left/right or separate for separately mapped parking areas).
# > key: The key that will be read.
# > stringsafe: Return an empty string instead of NULL, if output is NULL.
#-------------------------------------------------------------------------------

    value = NULL

    #for parking attributes tagged on the highway centerline:
    if side != 'separate':
        if layer.fields().indexOf('parking:' + side + ':' + key) != -1:
            value = feature.attribute('parking:' + side + ':' + key)
        if value == NULL and layer.fields().indexOf('parking:both:' + key) != -1:
            value = feature.attribute('parking:both:' + key)

    #for separately mapped parking areas:
    else:
        if layer.fields().indexOf(key) != -1:
            value = feature.attribute(key)

    if stringsafe and value == NULL:
        value = ''
    return value



def getSubCondition(conditions, values, stringsafe):
#-------------------------------------------------------------------------------
# Search for a value in a conditional string and returns the condition(s) for this value.
#-------------------------------------------------------------------------------
# > conditions: Conditional string (e.g. "no @ (Mo-Tu); yes @ We").
# > values: a single value (string) or a list of values to look for (e.g. "yes" or ["designated", "yes"]).
# > stringsafe: Return an empty string instead of NULL, if output is NULL.
#-------------------------------------------------------------------------------
# > returns the conditon (e.g. "We") or -1, if the value can't be found.
#-------------------------------------------------------------------------------
    cond = ''
    if not values or values == '': #if values are empty, return all conditions
        for i in range(len(conditions.split(' @ '))):
            if not i:
                continue
            if conditions.split(' @ ')[i][0] != '(': #if there are no brackets:
                substr = conditions.split(' @ ')[i].split(';', 1)[0] #take the string after the value until there is a semikolon delimiter
            else:
                substr = conditions.split(' @ ')[i].split(')', 1)[0].split('(', 1)[1] #take the string until the closing bracket and remove the opening bracket
            if cond == '': #add substr to maxstay interval output
                cond = substr
            else:
                cond += ', ' + substr
    else:
        if type(values) != list:
            values = [values]
        count = 0
        for value in values:
            if conditions.find(value) != -1:
                count += 1
        if not count:
            if stringsafe:
                return('')
            else:
                return NULL
        for value in values:
            for i in range(len(conditions.split(value + ' @ '))):
                if not i:
                    continue #first substring is the part before the first value - we don't need it
                if conditions.split(value + ' @ ')[i][0] != '(': #if there are no brackets:
                    substr = conditions.split(value + ' @ ')[i].split(';', 1)[0] #take the string after the value until there is a semikolon delimiter
                else: #if condition is in brackets:
                    substr = conditions.split(value + ' @ ')[i].split(')', 1)[0].split('(', 1)[1] #take the string until the closing bracket and remove the opening bracket
                if cond == '': #add substr to condition output
                    cond = substr
                else:
                    cond += ', ' + substr
    if cond == '':
        if stringsafe:
            return('')
        else:
            return NULL
    return('(' + cond + ')') #return condition(s) in brackets



def addConditionClass(condition_class, new_condition_class, condition):
#-------------------------------------------------------------------------------
# Adds a parking condition class to the parking condition class string.
#-------------------------------------------------------------------------------
# > condition_class: An already existing condition class string that will be expanded.
# > new_condition_class: The condition class, that will be added ('class').
# > condition: A condition that will be added ('class @ condition')
#-------------------------------------------------------------------------------
    if condition and condition != '':
        condition = ' @ ' + condition
    if condition_class == NULL or condition_class == '':
        return(new_condition_class + condition)
    else:
        return(condition_class + '; ' + new_condition_class + condition)



def getIntersections(layer, method):
#-------------------------------------------------------------------------------
#   ---(Funktion derzeit ungenutzt)---
#-------------------------------------------------------------------------------
# Ermittelt Straßenkreuzungen.
#-------------------------------------------------------------------------------
# > layer: Der Layer, für den die Kreuzungen ermittelt werden sollen.
# > method: ('full', 'fast') Die Berechnungsmethode, mit der
# vorgegangen wird.
#   > 'full': Ermittelt alle Schnittpunkte des Straßenlayers mit
#     sich selbst, an denen mehr als zwei Segmente zusammentreffen.
#     Vollständige, aber rechenaufwendige Methode.
#   > 'fast': Wesentlich schnellere Variante, bei der mit einem
#     nach Straßennamen aufgelösten Straßenlayer gerechnet wird.
#     In Einzelfällen können hierbei jedoch Kreuzungen fehlen,
#     wenn die sich kreuzenden Straßen den selben Namen tragen.
#-------------------------------------------------------------------------------

    if method != 'fast':
        # Straßen in Einzelteile zerlegen, um die Anzahl abgehender Wege sicher für jede Kreuzung ermitteln zu können
        expl_street = processing.run('native:explodelines', {'INPUT' : layer, 'OUTPUT': 'memory:'})['OUTPUT']

        # Kreuzungspunkte inklusive zahlreicher Pseudo-Nodes ermitteln
        intersections = processing.run('native:lineintersections', {'INPUT' : expl_street, 'INTERSECT' : expl_street, 'OUTPUT': dir_output + 'buffer_points/intersections.geojson'})['OUTPUT']

        intersections = QgsProject.instance().addMapLayer(QgsVectorLayer(dir_output + 'buffer_points/intersections.geojson', 'Straßenkreuzungen', 'ogr'))
        intersections.startEditing()

        # Variable für Breitenangabe der Kreuzung bereithalten
        intersections.dataProvider().addAttributes([QgsField('intersection_width', QVariant.String)])
        intersections.updateFields()
        id_width = intersections.fields().indexOf('intersection_width')

        for feature in intersections.getFeatures():
            # Punkte einzeln durchgehen und identische Punkte auswählen
            intersections.removeSelection()
            intersections.select(feature.id())
            processing.run('native:selectbylocation', {'INPUT' : intersections, 'INTERSECT' : QgsProcessingFeatureSourceDefinition(dir_output + 'buffer_points/intersections.geojson', selectedFeaturesOnly=True, featureLimit=-1, geometryCheck=QgsFeatureRequest.GeometryAbortOnInvalid), 'PREDICATE' : [3]})

            # Befinden sich nur 2 Punkte an einem Ort: Pseudo-Node löschen
            if intersections.selectedFeatureCount() < 3:
                intersections.deleteSelectedFeatures()
                continue

            # Ansonsten Kreuzungsbreite ermitteln und Mehrfachpunkte löschen
            width = 0
            del_features = []
            for sel_feature in intersections.selectedFeatures():
                feat_width = sel_feature.attribute('width_proc')
                if float(feat_width) > width:
                    width = float(feat_width)
            intersections.deselect(feature.id())
            intersections.deleteSelectedFeatures()

            intersections.changeAttributeValue(feature.id(), id_width, width)
    else:
        # schnelle, aber ungenaue Variante: Straßenlayer nach "name" auflösen und Schnittpunkte ermitteln
        layer_diss = processing.run('native:dissolve', {'FIELD' : ['name'], 'INPUT': layer, 'OUTPUT': 'memory:'})['OUTPUT']
        intersections = processing.run('native:lineintersections', {'INPUT' : layer_diss, 'INTERSECT' : layer_diss, 'OUTPUT': 'memory:'})['OUTPUT']
        intersections = processing.run('native:deleteduplicategeometries', { 'INPUT' : intersections, 'OUTPUT': 'memory:'})['OUTPUT']

        QgsProject.instance().addMapLayer(intersections)
        intersections.startEditing()

        # Breitenangabe für Kreuzung ermitteln
        intersections.dataProvider().addAttributes([QgsField('intersection_width', QVariant.String)])
        intersections.updateFields()
        id_width = intersections.fields().indexOf('intersection_width')
        for feature in intersections.getFeatures():
            width = max([float(feature.attribute('width_proc')), float(feature.attribute('width_proc_2'))])
            intersections.changeAttributeValue(feature.id(), id_width, width)

    intersections.commitChanges()
    return(intersections)



def getKerbIntersections(layer):
#-------------------------------------------------------------------------------
# Determines the intersection points of kerbs in junction areas.
#-------------------------------------------------------------------------------
# > layer: The layer for which the intersections are to be determined.
#-------------------------------------------------------------------------------

    #Zunächst kurze Unterbrechungen an Kreuzungen erzeugen, um fehlerhafte Schnittpunkte (bei leichten Kurven) nach Versatz zu vermeiden
    layer_diss_streets = layer
    #layer_diss_streets = processing.run('native:dissolve', {'FIELD' : ['name','parking:left:offset','parking:right:offset'], 'INPUT': layer, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_streets_intersect = processing.run('native:lineintersections', {'INPUT' : layer_diss_streets, 'INTERSECT' : layer_diss_streets, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_streets_intersect_buffer = processing.run('native:buffer', {'DISTANCE' : 0.1, 'INPUT' : layer_streets_intersect, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_streets_diff = processing.run('native:difference', {'INPUT' : layer_diss_streets, 'OVERLAY' : layer_streets_intersect_buffer, 'OUTPUT': 'memory:'})['OUTPUT']

    #Bordsteinlinien durch Versatz simulieren
    layer_kerb_left = processing.run('native:offsetline', {'INPUT': layer_streets_diff, 'DISTANCE' : QgsProperty.fromExpression('"parking:left:offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
    layer_kerb_right = processing.run('native:offsetline', {'INPUT': layer_streets_diff, 'DISTANCE' : QgsProperty.fromExpression('"parking:right:offset"'), 'OUTPUT': 'memory:'})['OUTPUT']

    #QgsProject.instance().addMapLayer(layer_kerb_left)
    #QgsProject.instance().addMapLayer(layer_kerb_right)

    #Schnittpunkte aller Linien bestimmen
    layer_streets_intersect1 = processing.run('native:lineintersections', {'INPUT' : layer_kerb_left, 'INTERSECT' : layer_kerb_right, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_streets_intersect2 = processing.run('native:lineintersections', {'INPUT' : layer_kerb_left, 'INTERSECT' : layer_kerb_left, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_streets_intersect3 = processing.run('native:lineintersections', {'INPUT' : layer_kerb_right, 'INTERSECT' : layer_kerb_right, 'OUTPUT': 'memory:'})['OUTPUT']

    layer_streets_intersect = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_streets_intersect1,layer_streets_intersect2,layer_streets_intersect3], 'OUTPUT': 'memory:'})['OUTPUT']

    QgsProject.instance().addMapLayer(layer_streets_intersect, False)
    group_buffer.insertChildNode(0, QgsLayerTreeLayer(layer_streets_intersect))
    layer_streets_intersect.setName('kerb intersection points')
    layer_streets_intersect.loadNamedStyle(dir + 'styles/kerb_intersections.qml')

    return(layer_streets_intersect)



def bufferIntersection(layer_parking, layer_intersect, buffer, buffer_name, intersects):
#-------------------------------------------------------------------------------
# Remove parts from parking lanes if a way (road, driveway,...) joins/cross.
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_intersect: The layer with intersecting ways.
# > buffer: Expression/formula to determine the radius to be kept free
# > buffer_name: If specified, the created buffer will be
#   added to the map with this name.
# > intersects (optional): If a point layer is given here,
#   it will be buffered instead of the intersections
#   from the first two layers.
#-------------------------------------------------------------------------------

    if not intersects:
        intersects = processing.run('native:lineintersections', {'INPUT' : layer_parking, 'INTERSECT' : layer_intersect, 'OUTPUT': 'memory:'})['OUTPUT']
    intersects_buffer = processing.run('native:buffer', {'DISTANCE' : QgsProperty.fromExpression(buffer), 'INPUT' : intersects, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : intersects_buffer, 'OUTPUT': 'memory:'})['OUTPUT']

    if buffer_name:
        QgsProject.instance().addMapLayer(intersects_buffer, False)
        group_buffer.insertChildNode(0, QgsLayerTreeLayer(intersects_buffer))
        intersects_buffer.loadNamedStyle(dir + 'styles/buffer_dashed.qml')
        intersects_buffer.setName(buffer_name)

    return(layer_parking)



def bufferCrossing(layer_parking, layer_points, side):
#-------------------------------------------------------------------------------
# Removes parts from street parking layer in the area of esp. crossings where
# the roadway is kept clear for crossing pedestrian traffic.
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_points: Layer with point data for crossings, traffic lights, etc.
# > side: The affected side of the street (left, right or both)
#-------------------------------------------------------------------------------
# Buffer radii:
#    highway = traffic_signals                   -> 10 m
#        traffic_signals:direction=forward: remove on right side only
#        traffic_signals:direction=backward: remove on left side only
#        !traffic_signals:direction: remove on both sides
#    crossing = marked                           -> 2 m
#    crossing = zebra OR crossing_ref = zebra    -> 4.5 m (4 m for zebra and 5 m in front according to german law)
#    crossing:buffer_marking                     -> 3 m
#        both: remove on both sides
#        left/right remove on one side only
#    crossing:kerb_extension                     -> 3 m
#        both: remove on both sides
#        left/right remove on one side only
#-------------------------------------------------------------------------------

    #Übergänge nach gemeinsamen Kriterien/Radien auswählen und Teilpuffer (mit Radius x) ziehen:
    #Vor Lichtzeichenanlagen/Ampeln 10 Meter Halteverbot (StVO) - beidseitig berücksichtigen, wenn Ampel nicht fahrtrichtungsabhängig erfasst ist
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"highway\" = \'traffic_signals\' AND \"traffic_signals:direction\" IS NOT \'forward\' AND \"traffic_signals:direction\" IS NOT \'backward\''})
    buffer01 = processing.run('native:buffer', {'DISTANCE' : buffer_traffic_signals, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']
    #...oder nur von einer Seite abziehen, wenn die Ampel fahrtrichtungsabhängig erfasst ist
    if side == 'left':
        processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"highway\" = \'traffic_signals\' AND \"traffic_signals:direction\" = \'backward\''})
    if side == 'right':
        processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"highway\" = \'traffic_signals\' AND \"traffic_signals:direction\" = \'forward\''})
    buffer_s01 = processing.run('native:buffer', {'DISTANCE' : buffer_traffic_signals, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']

    #An Gehwegvorstreckungen oder markierten Übergangs-Sperrflächen: 3 Meter
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"crossing:kerb_extension\" = \'both\' OR \"crossing:buffer_marking\" = \'both\' OR \"crossing:buffer_protection\" = \'both\''})
    buffer02 = processing.run('native:buffer', {'DISTANCE' : buffer_crossing_protected, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']
    #...oder nur von einer Seite abziehen, falls nur einseitig vorhanden
    if side == 'left':
        processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"crossing:kerb_extension\" = \'left\' OR \"crossing:buffer_marking\" = \'left\' OR \"crossing:buffer_protection\" = \'left\''})
    if side == 'right':
        processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"crossing:kerb_extension\" = \'right\' OR \"crossing:buffer_marking\" = \'right\' OR \"crossing:buffer_protection\" = \'right\''})
    buffer_s02 = processing.run('native:buffer', {'DISTANCE' : buffer_crossing_protected, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']

    #An Fußgängerüberwegen/Zebrastreifen: 4,5 Meter (4 Meter Zebrastreifenbreite sowie laut StVO 5 Meter Parkverbot davor)
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"crossing\" = \'zebra\' OR \"crossing_ref\" = \'zebra\' OR \"crossing\" = \'traffic_signals\''})
    buffer03 = processing.run('native:buffer', {'DISTANCE' : buffer_crossing_primary, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']

    #An sonstigen markierten Überwegen: 2 Meter
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"crossing\" = \'marked\''})
    buffer04 = processing.run('native:buffer', {'DISTANCE' : buffer_crossing_marked, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']

    #verschiedene Teilpuffer zusammenführen und von Parkstreifen abziehen
    buffer = processing.run('native:mergevectorlayers', {'LAYERS' : [buffer01,buffer02,buffer03,buffer04], 'OUTPUT': 'memory:'})['OUTPUT']
    buffer_s = processing.run('native:mergevectorlayers', {'LAYERS' : [buffer_s01,buffer_s02], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : buffer, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : buffer_s, 'OUTPUT': 'memory:'})['OUTPUT']

    #Puffer anzeigen
    if side == 'left':
        QgsProject.instance().addMapLayer(buffer, False)
        group_buffer.insertChildNode(0, QgsLayerTreeLayer(buffer))
        buffer.loadNamedStyle(dir + 'styles/buffer_dashed.qml')
        buffer.setName('pedestrian crossings')

        QgsProject.instance().addMapLayer(buffer_s, False)
        group_buffer.insertChildNode(0, QgsLayerTreeLayer(buffer_s))
        buffer_s.loadNamedStyle(dir + 'styles/buffer_dashed_left.qml')
        buffer_s.setName('crossings/traffic signals (left)')
    if side == 'right':
        QgsProject.instance().addMapLayer(buffer_s, False)
        group_buffer.insertChildNode(0, QgsLayerTreeLayer(buffer_s))
        buffer_s.loadNamedStyle(dir + 'styles/buffer_dashed_right.qml')
        buffer_s.setName('crossings/traffic signals (right)')

    return(layer_parking)



def bufferTurningCircles(layer_parking, layer_points, side):
#-------------------------------------------------------------------------------
# Removes parts from street parking layer at turning circles and loops.
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_points: Layer with point data for turning circles and loops.
# > side: The affected side of the street (left, right or both)
#-------------------------------------------------------------------------------

    #generate buffers for circles and loops
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"highway\" = \'turning_circle\''})
    buffer01 = processing.run('native:buffer', {'DISTANCE' : buffer_turning_circle, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_points, 'EXPRESSION' : '\"highway\" = \'turning_loop\''})
    buffer02 = processing.run('native:buffer', {'DISTANCE' : buffer_turning_loop, 'INPUT' : QgsProcessingFeatureSourceDefinition(layer_points.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']

    #merge buffers and cut street parking segments
    buffer = processing.run('native:mergevectorlayers', {'LAYERS' : [buffer01,buffer02], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : buffer, 'OUTPUT': 'memory:'})['OUTPUT']

    #show buffers on map
    QgsProject.instance().addMapLayer(buffer, False)
    group_buffer.insertChildNode(0, QgsLayerTreeLayer(buffer))
    buffer.loadNamedStyle(dir + 'styles/buffer_dashed.qml')
    buffer.setName('turning circles/loops')

    return(layer_parking)



def bufferBusStop(layer_parking, layer_points, layer_virtual_kerb):
#-------------------------------------------------------------------------------
# Removes parts from street  parking layers in the area of bus stops (buffer
# radius 15 meter according to german law).
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_points: Layer with bus stops (OSM nodes: highway=bus_stop).
# > layer_virtual_kerb: Snap bus stops to this geometries.
#-------------------------------------------------------------------------------

    #extract bus stops from point input
    layer_bus_stops = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_points, 'EXPRESSION' : '"highway" = \'bus_stop\'', 'OUTPUT': 'memory:'})['OUTPUT']

    #merge offset road segments with and without street parking and snap bus stops to closest line
    layer_bus_stops_snapped = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_bus_stops, 'REFERENCE_LAYER' : layer_virtual_kerb, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_bus_stops_snapped = processing.run('native:joinbynearest', {'INPUT': layer_bus_stops_snapped, 'INPUT_2' : layer_virtual_kerb, 'FIELDS_TO_COPY' : ['highway:name','side'], 'PREFIX' : 'parking:', 'MAX_DISTANCE' : buffer_bus_stop_range, 'NEIGHBORS' : 1, 'OUTPUT': 'memory:'})['OUTPUT']

    #buffer bus stops that are on or very near to road segments with street parking
    #(assume that there is no need to buffer bus stops at road segments without street parking because impact of bus stop is still mapped)
    #therefore: create small buffer for bus stops and extract all features intersecting with street parking segments
    layer_bus_stops_buffer_range = processing.run('native:buffer', {'DISTANCE' : buffer_bus_stop_range, 'INPUT' : layer_bus_stops_snapped, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_bus_stops_buffer_range_snapped = processing.run('native:extractbylocation', { 'INPUT' : layer_bus_stops_buffer_range, 'INTERSECT' : layer_parking, 'PREDICATE' : [0], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_bus_stops_buffer = processing.run('native:buffer', {'DISTANCE' : buffer_bus_stop - buffer_bus_stop_range, 'INPUT' : layer_bus_stops_buffer_range_snapped, 'OUTPUT': 'memory:'})['OUTPUT']
    QgsProject.instance().addMapLayer(layer_bus_stops_buffer, False)

    #for every single bus stop:
    for bus_stop in layer_bus_stops_buffer.getFeatures():
        layer_bus_stops_buffer.removeSelection()
        layer_bus_stops_buffer.select(bus_stop.id())
        #extract all nearby parking lanes with same street name and side tag as the road segment the bus stop was snapped to
        layer_parking_intersect = processing.run('native:extractbylocation', {'INPUT' : layer_parking, 'INTERSECT' : QgsProcessingFeatureSourceDefinition(layer_bus_stops_buffer.id(), selectedFeaturesOnly=True), 'PREDICATE' : [0,6], 'OUTPUT': 'memory:'})['OUTPUT']

        layer_parking_intersect.startEditing()
        for parking_lane in layer_parking_intersect.getFeatures():
            #cut only segments with same street name...
            if parking_lane.attribute('highway:name') != bus_stop.attribute('parking:highway:name'):
                layer_parking_intersect.deleteFeature(parking_lane.id())
                continue
            #...and on same side of the street
            if parking_lane.attribute('side') != bus_stop.attribute('parking:side'):
                layer_parking_intersect.deleteFeature(parking_lane.id())

        layer_parking_intersect.commitChanges()

        #reduce parking lanes to segments outside this bus stop buffer, cut the segments inside this bus stop buffer and merge both layers again
        processing.run('native:selectbylocation', {'INPUT' : layer_parking, 'INTERSECT' : layer_parking_intersect, 'PREDICATE' : [3]})
        with edit(layer_parking):
            layer_parking.deleteSelectedFeatures()
        layer_parking_intersect = processing.run('native:difference', {'INPUT' : layer_parking_intersect, 'OVERLAY' : QgsProcessingFeatureSourceDefinition(layer_bus_stops_buffer.id(), selectedFeaturesOnly=True), 'OUTPUT': 'memory:'})['OUTPUT']
        layer_parking = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_parking, layer_parking_intersect], 'OUTPUT': 'memory:'})['OUTPUT']

    #add all bus stops to buffer folder
    QgsProject.instance().addMapLayer(layer_bus_stops, False)
    group_buffer.insertChildNode(0, QgsLayerTreeLayer(layer_bus_stops))
    layer_bus_stops.loadNamedStyle(dir + 'styles/buffer_bus_stop.qml')
    layer_bus_stops.setName('bus stops')

    return(layer_parking)



def processObstacles(layer_parking, layer_polygons, layer_points, layer_lines, layer_snap):
#-------------------------------------------------------------------------------
# Cut street parking segments where lane installations and obstacles are located
# (on lane bicycle parking, parkletts, street furniture marked as obstacles...)
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_polygons: The polygon layer containing installations of interest (see below)
# > layer_points: The point layer containing installations of interest (see below)
# > layer_snap: Snap installations of interest to this geometries (virtual kerb lines or parking segments).
#-------------------------------------------------------------------------------
# > installations of interest:
# amenity=bicycle_parking + bicycle_parking:position=lane / street_side / kerb_extension
# amenity=motorcycle_parking + parking=lane / street_side / kerb_extension
# amenity=small_electric_vehicle_parking + small_electric_vehicle_parking:position=lane / street_side / kerb_extension
# amenity=bicycle_rental + bicycle_rental:position=lane / street_side / kerb_extension
# leisure=parklet
# amenity=loading_ramp
# leisure=outdoor_seating + outdoor_seating=parklet
# traffic_calming=kerb_extension
# area:highway=prohibited
# and all objects tagged with obstacle:parking=yes
#-------------------------------------------------------------------------------

    #sizes (diameters) for typical street furniture nodes - distance to parking vehicles is "size / 2 + 0.4" (size / 2: half diameter; 0.4: safety / manoeuvring distance)
    buffer_default          = 0.5 #default for all other objects
    buffer_street_lamp      = 0.4
    buffer_tree             = 1.5
    buffer_street_cabinet   = 1.5
    buffer_bollard          = 0.3
    buffer_advertising      = 1.4
    buffer_recycling        = 5.0
    buffer_traffic_sign     = 0.3
    buffer_bicycle_parking  = 1.6 #per stand - per capacity / 2
    buffer_sev_parking      = 5.0 #small electric vehicle parking
    buffer_parklet          = 5.0
    buffer_loading_ramp     = 2.0

    #extract installations/obstacles of interest from polygon input and convert to lines
    layer_obstacles_areas = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_polygons, 'EXPRESSION' : '("amenity" = \'bicycle_parking\' AND ("bicycle_parking:position" = \'lane\' OR "bicycle_parking:position" = \'street_side\' OR "bicycle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'motorcycle_parking\' AND ("parking" = \'lane\' OR "parking" = \'street_side\' OR "parking" = \'kerb_extension\')) OR ("amenity" = \'small_electric_vehicle_parking\' AND ("small_electric_vehicle_parking:position" = \'lane\' OR "small_electric_vehicle_parking:position" = \'street_side\' OR "small_electric_vehicle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'bicycle_rental\' AND ("bicycle_rental:position" = \'lane\' OR "bicycle_rental:position" = \'street_side\' OR "bicycle_rental:position" = \'kerb_extension\')) OR "leisure" = \'parklet\' OR ("leisure" = \'outdoor_seating\' and "outdoor_seating" = \'parklet\') OR "traffic_calming" = \'kerb_extension\' OR "obstacle:parking" = \'yes\'', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_obstacles_areas = processing.run('native:polygonstolines', { 'INPUT' : layer_obstacles_areas, 'OUTPUT': 'memory:'})['OUTPUT']
    #separately process restriction area markings (small snapping radius to not snap markings from the middle of the road)
    layer_prohibited_areas = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_polygons, 'EXPRESSION' : '"area:highway" = \'prohibited\'', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_prohibited_areas = processing.run('native:polygonstolines', { 'INPUT' : layer_prohibited_areas, 'OUTPUT': 'memory:'})['OUTPUT']
    #load line data and extract installations/obstacles of interest
    layer_obstacles_lines = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_lines, 'EXPRESSION' : '("amenity" = \'bicycle_parking\' AND ("bicycle_parking:position" = \'lane\' OR "bicycle_parking:position" = \'street_side\' OR "bicycle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'motorcycle_parking\' AND ("parking" = \'lane\' OR "parking" = \'street_side\' OR "parking" = \'kerb_extension\')) OR ("amenity" = \'small_electric_vehicle_parking\' AND ("small_electric_vehicle_parking:position" = \'lane\' OR "small_electric_vehicle_parking:position" = \'street_side\' OR "small_electric_vehicle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'bicycle_rental\' AND ("bicycle_rental:position" = \'lane\' OR "bicycle_rental:position" = \'street_side\' OR "bicycle_rental:position" = \'kerb_extension\')) OR "leisure" = \'parklet\' OR ("leisure" = \'outdoor_seating\' and "outdoor_seating" = \'parklet\') OR "traffic_calming" = \'kerb_extension\' OR "obstacle:parking" = \'yes\'', 'OUTPUT': 'memory:'})['OUTPUT']
    #snap features to nearby parking segments or virtual kerb lines
    layer_obstacles_areas = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_obstacles_areas, 'REFERENCE_LAYER' : layer_snap, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_obstacles_lines = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_obstacles_lines, 'REFERENCE_LAYER' : layer_snap, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_prohibited_areas = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_prohibited_areas, 'REFERENCE_LAYER' : layer_snap, 'TOLERANCE' : 3, 'OUTPUT': 'memory:'})['OUTPUT']
    #buffer lines with rectangular shape
    layer_obstacles_areas = processing.run('native:buffer', {'INPUT' : layer_obstacles_areas, 'DISTANCE' : 2, 'END_CAP_STYLE' : 1, 'JOIN_STYLE' : 2, 'MITER_LIMIT' : 2, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_obstacles_lines = processing.run('native:buffer', {'INPUT' : layer_obstacles_lines, 'DISTANCE' : 2, 'END_CAP_STYLE' : 1, 'JOIN_STYLE' : 2, 'MITER_LIMIT' : 2, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_prohibited_areas = processing.run('native:buffer', {'INPUT' : layer_prohibited_areas, 'DISTANCE' : 2, 'END_CAP_STYLE' : 1, 'JOIN_STYLE' : 2, 'MITER_LIMIT' : 2, 'OUTPUT': 'memory:'})['OUTPUT']
    #extract installations/obstacles of interest from point input
    layer_obstacles_points = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_points, 'EXPRESSION' : '("amenity" = \'bicycle_parking\' AND ("bicycle_parking:position" = \'lane\' OR "bicycle_parking:position" = \'street_side\' OR "bicycle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'motorcycle_parking\' AND ("parking" = \'lane\' OR "parking" = \'street_side\' OR "parking" = \'kerb_extension\')) OR ("amenity" = \'small_electric_vehicle_parking\' AND ("small_electric_vehicle_parking:position" = \'lane\' OR "small_electric_vehicle_parking:position" = \'street_side\' OR "small_electric_vehicle_parking:position" = \'kerb_extension\')) OR ("amenity" = \'bicycle_rental\' AND ("bicycle_rental:position" = \'lane\' OR "bicycle_rental:position" = \'street_side\' OR "bicycle_rental:position" = \'kerb_extension\')) OR "leisure" = \'parklet\' OR ("leisure" = \'outdoor_seating\' and "outdoor_seating" = \'parklet\') OR "obstacle:parking" = \'yes\'', 'OUTPUT': 'memory:'})['OUTPUT']
    #derive a buffer size from the type of obstacle
    layer_obstacles_points.startEditing()
    layer_obstacles_points.dataProvider().addAttributes([QgsField('parking_buffer_size', QVariant.String)])
    layer_obstacles_points.updateFields()
    id_buffer = layer_obstacles_points.fields().indexOf('parking_buffer_size')
    for feature in layer_obstacles_points.getFeatures():
        id = feature.attribute('id')
        buffer = NULL
        amenity = leisure = highway = barrier = man_made = natural = advertising = NULL
        #get type of obstacle
        if layer_obstacles_points.fields().indexOf('amenity') != -1:
            amenity = feature.attribute('amenity')
        if layer_obstacles_points.fields().indexOf('leisure') != -1:
            leisure = feature.attribute('leisure')
        if layer_obstacles_points.fields().indexOf('highway') != -1:
            highway = feature.attribute('highway')
        if layer_obstacles_points.fields().indexOf('barrier') != -1:
            barrier = feature.attribute('barrier')
        if layer_obstacles_points.fields().indexOf('man_made') != -1:
            man_made = feature.attribute('man_made')
        if layer_obstacles_points.fields().indexOf('natural') != -1:
            natural = feature.attribute('natural')
        if layer_obstacles_points.fields().indexOf('advertising') != -1:
            advertising = feature.attribute('advertising')
        #set buffer depending on type of object
        if highway == 'street_lamp':
            buffer = buffer_street_lamp
        if natural == 'tree':
            buffer = buffer_tree
        if man_made == 'street_cabinet':
            buffer = buffer_street_cabinet
        if barrier == 'bollard' or barrier == 'collision_protection':
            buffer = buffer_bollard
        if advertising:
            buffer = buffer_advertising
        if amenity == 'recycling':
            buffer = buffer_recycling
        if highway == 'traffic_sign' or barrier == 'barrier_board':
            buffer = buffer_traffic_sign
        if amenity == 'bicycle_parking':
            buffer = buffer_bicycle_parking
        if leisure == 'parklet' or leisure == 'outdoor_seating':
            buffer = buffer_parklet
        if amenity == 'loading_ramp':
            buffer = buffer_loading_ramp
        if amenity == 'bicycle_parking' or amenity == 'motorcycle_parking' or amenity == 'bicycle_rental':
            capacity = NULL
            if layer_obstacles_points.fields().indexOf('capacity') != -1:
                capacity = feature.attribute('capacity')
            if not capacity or type(capacity) != int:
                capacity = 2
            buffer = (min(capacity, 10) / 2) * buffer_bicycle_parking #limit size to capacity = 10 - better use polygons to map larger bicycle parkings!
        if amenity == 'small_electric_vehicle_parking':
            buffer = buffer_sev_parking
        if not buffer:
            buffer = buffer_default
        layer_obstacles_points.changeAttributeValue(feature.id(), id_buffer, buffer)
    layer_obstacles_points.updateFields()
    layer_obstacles_points.commitChanges()
    #snap points to parking segments
    layer_obstacles_points = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_obstacles_points, 'REFERENCE_LAYER' : layer_snap, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
    #buffer / distance to parking vehicles is "size of object / 2 + 0.4" (size of object / 2: half diameter of the object; 0.4: safety / manoeuvring distance)
    layer_obstacles_points = processing.run('native:buffer', {'DISTANCE' : QgsProperty.fromExpression('("parking_buffer_size" / 2) + 0.4'), 'INPUT' : layer_obstacles_points, 'OUTPUT': 'memory:'})['OUTPUT']
    #merge area/line and point layers
    layer_obstacles = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_obstacles_areas,layer_prohibited_areas,layer_obstacles_lines,layer_obstacles_points], 'OUTPUT': 'memory:'})['OUTPUT']
    #cut parking lanes
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : layer_obstacles, 'OUTPUT': 'memory:'})['OUTPUT']
    #add buffer to map
    QgsProject.instance().addMapLayer(layer_obstacles, False)
    group_buffer.insertChildNode(0, QgsLayerTreeLayer(layer_obstacles))
    layer_obstacles.loadNamedStyle(dir + 'styles/buffer_dashed.qml')
    layer_obstacles.setName('lane installations and obstacles')
    #return cutted parking lane layer
    return(layer_parking)



def processSeparateParkingNodes(layer_points, layer_virtual_kerb):
#-------------------------------------------------------------------------------
# Converts separately mapped street parking nodes into line segments similar
# to street parking mapped on the street center line.
#-------------------------------------------------------------------------------
# > layer_points: Layer with separately mapped parking nodes.
# > layer_virtual_kerb: "Virtual kerb" layer (highway line offset by
#   carriageway width) to snap nodes to this kerb and use their geometry
#   for the new line segments.
#-------------------------------------------------------------------------------

    street_attributes = ['side','highway','highway:name','highway:oneway']
    parking_attributes = parking_attribute_list.copy()
    for attr in street_attributes:
        if attr in parking_attributes:
            parking_attributes.remove(attr)
    
    layer = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_points, 'EXPRESSION' : '"amenity" IS \'parking\'', 'OUTPUT': 'memory:'})['OUTPUT']
    layer = harmonizeSeparateParkingAttributes(layer, 'separate_node', {})

    #snap to virtual kerb
    layer = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer, 'REFERENCE_LAYER' : layer_virtual_kerb, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
    #buffer according to capacity (use capacity = 1, if no capacity is given)
    layer = processing.run('native:buffer', {'DISTANCE' : QgsProperty.fromExpression('(if("capacity","capacity",1) * if("orientation"=\'diagonal\',3.1,if("orientation"=\'perpendicular\',2.5,5.2))) / 2'), 'INPUT' : layer, 'OUTPUT': 'memory:'})['OUTPUT']
    #intersect buffer circle and virtual kerb line
    layer = processing.run('native:intersection', { 'INPUT' : layer_virtual_kerb, 'INPUT_FIELDS' : street_attributes, 'OVERLAY' : layer, 'OVERLAY_FIELDS' : parking_attributes, 'OUTPUT': 'memory:'})['OUTPUT']

    return(layer)



def processSeparateParkingAreas(layer_parking, layer_polygons, layer_virtual_kerb):
#-------------------------------------------------------------------------------
# Converts separately mapped street parking areas into line segments similar
# to street parking mapped on the street center line.
#-------------------------------------------------------------------------------
# > layer_parking: The affected street parking layer.
# > layer_polygons: Layer with separately mapped parking areas.
# > layer_virtual_kerb: "Virtual kerb" layer (highway line offset by
#   carriageway width) to distinguish inner and outer parking area lines.
#-------------------------------------------------------------------------------

    #extract separately mapped parking areas from polygon input
    layer_parking_areas = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_polygons, 'EXPRESSION' : '"amenity" = \'parking\' AND ("parking" = \'street_side\' OR "parking" = \'lane\' OR "parking" = \'on_kerb\' OR "parking" = \'half_on_kerb\' OR "parking" = \'shoulder\')', 'OUTPUT': 'memory:'})['OUTPUT']

    #derive missing capacities from area size
    capacity_dict = {} #save capacity per id in a dict temporarily
    for feature in layer_parking_areas.getFeatures():
        capacity = NULL
        id = feature.attribute('id')
        if layer_parking_areas.fields().indexOf('capacity') != -1:
            capacity = feature.attribute('capacity')
        if layer_parking_areas.fields().indexOf('orientation') != -1:
            orientation = feature.attribute('orientation')
        if not capacity and not orientation: #capacities of areas with orientation attribute are calculated later, using to the length of the line
            capacity = math.floor(feature.geometry().area() / area_parking_place)
            capacity_dict[id] = capacity

    #convert street parking area polygons into lines
    layer_parking_lines = processing.run('native:polygonstolines', { 'INPUT' : layer_parking_areas, 'OUTPUT': 'memory:'})['OUTPUT']
    #explode both line layers in single segments and get line directions/angles for every segment
    layer_parking_lines = processing.run('native:explodelines', { 'INPUT' : layer_parking_lines, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_kerb = processing.run('native:explodelines', { 'INPUT' : layer_virtual_kerb, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_lines = processing.run('qgis:fieldcalculator', { 'INPUT': layer_parking_lines, 'FIELD_NAME': 'proc_line_angle', 'FIELD_TYPE': 0, 'FIELD_LENGTH': 6, 'FIELD_PRECISION': 3, 'NEW_FIELD': True, 'FORMULA': 'line_interpolate_angle($geometry,0)', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_kerb = processing.run('qgis:fieldcalculator', { 'INPUT': layer_kerb, 'FIELD_NAME': 'proc_line_angle', 'FIELD_TYPE': 0, 'FIELD_LENGTH': 6, 'FIELD_PRECISION': 3, 'NEW_FIELD': True, 'FORMULA': 'line_interpolate_angle($geometry,0)', 'OUTPUT': 'memory:'})['OUTPUT']
    #atopt line angle of the nearest street segment at every parking area outline segment
    layer_parking_lines = processing.run('native:joinbynearest', {'INPUT': layer_parking_lines, 'INPUT_2' : layer_kerb, 'FIELDS_TO_COPY' : ['highway','highway:name','proc_line_angle'], 'PREFIX' : 'highway:', 'MAX_DISTANCE' : 15, 'NEIGHBORS' : 1, 'OUTPUT': 'memory:'})['OUTPUT']
    #ignore line segments whose angle deviates significantly from the angle of the road to create 'inner' and 'outer' lines
    #outer line represents the virtual kerb the parking lane is located/rendered at
    #inner line is needed for interpolate the parking orientation if not mapped
    layer_parking_lines_outer = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lines, 'EXPRESSION' : 'abs("proc_line_angle" - "highway:proc_line_angle") < 25', 'OUTPUT': 'memory:'})['OUTPUT']
    #dissolve line segments with same id (= line segments of the same parking area)
    layer_parking_lines_outer = processing.run('native:dissolve', { 'FIELD' : ['id'], 'INPUT' : layer_parking_lines_outer, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_lines_outer = processing.run('native:multiparttosingleparts', { 'INPUT' : layer_parking_lines_outer, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_lines_outer = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lines_outer, 'EXPRESSION' : '$length > 1.7', 'OUTPUT': 'memory:'})['OUTPUT']

    #fill in capacity and derive width/orientation from area geometry if they aren't specified in tagging
    #This calculations are area specific. Other attributes are filled in afterwards.
    layer = layer_parking_lines_outer

    if process_separate_area_width:
        layer_parking_lines_inner = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_lines, 'EXPRESSION' : '(abs("proc_line_angle" - ("highway:proc_line_angle" - 180)) < 25 or abs("proc_line_angle" - ("highway:proc_line_angle" + 180)) < 25) and "parking:orientation" is NULL', 'OUTPUT': 'memory:'})['OUTPUT']
        width_dict = getParkingAreaWidth(layer_parking_lines_inner, layer_parking_lines_outer)

    feature_dict = {}

    for feature in layer.getFeatures():
        id = feature.attribute('id')
        w = o = c = NULL
        width = NULL
        orientation = NULL
        capacity = NULL
        if layer.fields().indexOf('width') != -1:
            width = feature.attribute('width')
        if layer.fields().indexOf('orientation') != -1:
            orientation = feature.attribute('orientation')
        if id in capacity_dict.keys():
            capacity = capacity_dict[id]
        if process_separate_area_width:
            if not width:
                if id in width_dict.keys():
                    w = width_dict[id]
        if not orientation:
            w_o = NULL
            if width:
                w_o = width
            elif w:
                w_o = w
            if w_o:
                if width_diag - 0.25 < w_o < width_diag + 0.25:
                    o = 'diagonal'
                elif w_o >= width_diag + 0.25:
                    o = 'perpendicular'
                elif w_o <= width_diag - 0.25:
                    o = 'parallel'
        if w or o or c:
            feature_dict[id] = {}
            if w:
                feature_dict[id]['width'] = round(w, 1)
            if o:
                feature_dict[id]['orientation'] = o
            if c:
                feature_dict[id]['capacity'] = c

    #harmonize parking attributes
    layer = harmonizeSeparateParkingAttributes(layer, 'separate_area', feature_dict)
    return(layer)



def harmonizeSeparateParkingAttributes(layer, source, feature_dict):
#-------------------------------------------------------------------------------
# Fill, interpret and clean up parking attributes of
# separately mapped parking areas and nodes.
#-------------------------------------------------------------------------------
# >layer: The layer with separately mapped parking features.
# >source: A source string describing what kind of features are processed.
# >feature_dict (optional): A dict with feature ids and capacities that provides pre-processed capacities for areas
#-------------------------------------------------------------------------------

    #create same attributes as in street parking layer
    layer.startEditing()
    for attr in parking_attribute_list:
        if layer.fields().indexOf(attr) == -1:
            layer.dataProvider().addAttributes([QgsField(attr, QVariant.String)])
    layer.updateFields()

    id_side = layer.fields().indexOf('side')
    id_highway = layer.fields().indexOf('highway')
    id_highway_name = layer.fields().indexOf('highway:name')
    id_orientation = layer.fields().indexOf('orientation')
    id_capacity = layer.fields().indexOf('capacity')
    id_source_capacity = layer.fields().indexOf('source:capacity')
    id_width = layer.fields().indexOf('width')
    id_condition_class = layer.fields().indexOf('condition_class')
    id_vehicle_designated = layer.fields().indexOf('vehicle_designated')
    id_vehicle_excluded = layer.fields().indexOf('vehicle_excluded')
    id_parking_source = layer.fields().indexOf('parking_source')

    #translate attributes from geometry
    for feature in layer.getFeatures():
        id = feature.attribute('id')
        highway = NULL
        highway_name = NULL
        orientation = NULL
        capacity = NULL
        width = NULL

        #highway:name
        if layer.fields().indexOf('street:name') != -1:
            highway_name = feature.attribute('street:name')
        if not highway_name and layer.fields().indexOf('highway:highway:name') != -1:
            highway_name = feature.attribute('highway:highway:name')

        if layer.fields().indexOf('capacity') != -1:
            capacity = feature.attribute('capacity')
        if capacity:
            source_capacity = 'OSM'
        else:
            source_capacity = 'estimated'

        #overwrite capacity if given in the feature dict
        if id in feature_dict.keys():
            if 'capacity' in feature_dict[id].keys():
                capacity = feature_dict[id]['capacity']

        if layer.fields().indexOf('orientation') != -1:
            orientation = feature.attribute('orientation')
        if id in feature_dict.keys(): #overwrite orientation if given in the feature dict
            if 'orientation' in feature_dict[id].keys():
                orientation = feature_dict[id]['orientation']

        #read width from feature dict or derive from orientation
        if layer.fields().indexOf('width') != -1:
            width = feature.attribute('width')
        if id in feature_dict.keys(): #overwrite width if given in the feature dict
            if 'width' in feature_dict[id].keys():
                width = feature_dict[id]['width']
        if not width:
            if orientation == 'parallel':
                width = width_para
            if orientation == 'diagonal':
                width = width_diag
            if orientation == 'perpendicular':
                width = width_perp

        #interprete parking restrictions
        condition_class = getConditionClass(layer, feature, 'separate')[0]
        vehicle_designated = getConditionClass(layer, feature, 'separate')[1]
        vehicle_excluded = getConditionClass(layer, feature, 'separate')[2]

        if condition_class == '':
            condition_class = NULL

        layer.changeAttributeValue(feature.id(), id_highway, highway)
        layer.changeAttributeValue(feature.id(), id_highway_name, highway_name)
        layer.changeAttributeValue(feature.id(), id_orientation, orientation)
        layer.changeAttributeValue(feature.id(), id_capacity, capacity)
        layer.changeAttributeValue(feature.id(), id_width, width)
        layer.changeAttributeValue(feature.id(), id_source_capacity, source_capacity)
        layer.changeAttributeValue(feature.id(), id_condition_class, condition_class)
        layer.changeAttributeValue(feature.id(), id_vehicle_designated, vehicle_designated)
        layer.changeAttributeValue(feature.id(), id_vehicle_excluded, vehicle_excluded)
        layer.changeAttributeValue(feature.id(), id_parking_source, source)

    layer.updateFields()
    layer.commitChanges()

    #delete unused attributes
    layer = clearAttributes(layer, parking_attribute_list)

    return(layer)



def getParkingAreaWidth(layer_parking_lines_inner, layer_parking_lines_outer):
#-------------------------------------------------------------------------------
# Derive the width of a parking area by measuring the distance betwenn the
# area outler lines.
#-------------------------------------------------------------------------------
# > layer_parking_lines_inner: Layer containing the inner lines (the line
#   parallel and next to the street).
# > layer_parking_lines_outer: Layer containing the outer lines (the line
#   parallel and next to the kerb).
#-------------------------------------------------------------------------------

    print(time.strftime('%H:%M:%S', time.localtime()), 'Interpolate parking area width...')
    width_dict = {}

    #dissolve line segments with same id (= line segments of the same parking area)
    layer_parking_lines_inner = processing.run('native:dissolve', { 'FIELD' : ['id'], 'INPUT' : layer_parking_lines_inner, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_lines_inner = processing.run('native:multiparttosingleparts', { 'INPUT' : layer_parking_lines_inner, 'OUTPUT': 'memory:'})['OUTPUT']
    #create a point chain along one of the lines (7 points or 5 points for shorter lines)
    layer_chain = processing.run('native:pointsalonglines', {'INPUT' : layer_parking_lines_inner, 'DISTANCE' : QgsProperty.fromExpression('if($length > 14,($length - 1) / 6,($length - 1) / 4)'), 'START_OFFSET' : 0.5, 'OUTPUT': 'memory:'})['OUTPUT']
    #snap points to nearest point of opposite line
    #TODO: snap only to line with same ID
    layer_snap_chain = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_chain, 'REFERENCE_LAYER' : layer_parking_lines_outer, 'TOLERANCE' : 10, 'OUTPUT': 'memory:'})['OUTPUT']
    #get distance for every point pair
    layer_hub_lines = processing.run('qgis:distancetonearesthublinetohub', { 'INPUT' : layer_chain, 'HUBS' : layer_snap_chain, 'FIELD' : 'id', 'UNIT' : 0, 'OUTPUT': 'memory:'})['OUTPUT']
    #get angle of hub line
    layer_hub_lines = processing.run('qgis:fieldcalculator', { 'INPUT': layer_hub_lines, 'FIELD_NAME': 'connecting_angle', 'FIELD_TYPE': 0, 'FIELD_LENGTH': 6, 'FIELD_PRECISION': 3, 'NEW_FIELD': True, 'FORMULA': 'line_interpolate_angle($geometry,0)', 'OUTPUT': 'memory:'})['OUTPUT']

    #get distance if offset angle is nearly right angular (these are points that were snapped directly to the line)
    layer_hub_lines = processing.run('qgis:fieldcalculator', { 'INPUT': layer_hub_lines, 'FIELD_NAME': 'distance', 'FIELD_TYPE': 0, 'FIELD_LENGTH': 6, 'FIELD_PRECISION': 3, 'NEW_FIELD': True, 'FORMULA': 'if(abs(abs(if("proc_line_angle" - "connecting_angle" < 0,"proc_line_angle" - "connecting_angle" + 180,"proc_line_angle" - "connecting_angle" - 180)) - 90) < 25,"HubDist",NULL)', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_hub_lines = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_hub_lines, 'EXPRESSION' : '"distance" is not NULL', 'OUTPUT': 'memory:'})['OUTPUT']

    #get median distance for each OSM-feature by it's id
    layer_hub_lines = processing.run('qgis:fieldcalculator', { 'INPUT': layer_hub_lines, 'FIELD_NAME': 'distance_median', 'FIELD_TYPE': 0, 'FIELD_LENGTH': 6, 'FIELD_PRECISION': 3, 'NEW_FIELD': True, 'FORMULA': 'median("distance",group_by:="id")', 'OUTPUT': 'memory:'})['OUTPUT']

    for hub_line in layer_hub_lines.getFeatures():
        id = hub_line.attribute('id')
        if not id in width_dict.keys():
            distance = hub_line.attribute('distance_median')
            #no or large distance? invalid value.
            if distance != 0 and (not distance or abs(distance) > 7):
                width_dict[id] = NULL
            else:
                width_dict[id] = round(distance, 3)

    return(width_dict)



def pickMissingHighwayAttributes(layer_parking, layer_virtual_kerb):
#-------------------------------------------------------------------------------
# Parking segments with missing highway attributes adopt them from nearest virtual kerb line.
#-------------------------------------------------------------------------------

    QgsProject.instance().addMapLayer(layer_parking, False)
    layer_parking.removeSelection()
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_parking, 'EXPRESSION' : '\"highway\" IS NULL or \"highway:name\" IS NULL or \"highway:oneway\" IS NULL or \"side\" IS NULL'})
    layer_parking_pick = processing.run('native:joinbynearest', {'INPUT' : QgsProcessingFeatureSourceDefinition(layer_parking.id(), selectedFeaturesOnly=True), 'INPUT_2' : layer_virtual_kerb, 'FIELDS_TO_COPY' : ['highway','highway:name','highway:oneway','side'], 'PREFIX' : 'highway_pick:', 'MAX_DISTANCE' : 15, 'NEIGHBORS' : 1, 'OUTPUT': 'memory:'})['OUTPUT']

    layer_parking.startEditing()

    id_highway = layer_parking.fields().indexOf('highway')
    id_highway_name = layer_parking.fields().indexOf('highway:name')
    id_highway_oneway = layer_parking.fields().indexOf('highway:oneway')
    id_side = layer_parking.fields().indexOf('side')

    for feature in layer_parking.getSelectedFeatures():
        highway = highway_name = highway_oneway = side = NULL
        id = feature.attribute('id')
        expr = '"id" = \'' + id + '\''
        feature_pick = layer_parking_pick.getFeatures(QgsFeatureRequest(QgsExpression(expr)))
        for pick in feature_pick:
            highway = pick.attribute('highway_pick:highway')
            highway_name = pick.attribute('highway_pick:highway:name')
            highway_oneway = pick.attribute('highway_pick:highway:oneway')
            side = pick.attribute('highway_pick:side')
            continue
        if highway:
            layer_parking.changeAttributeValue(feature.id(), id_highway, highway)
        if highway_name:
            layer_parking.changeAttributeValue(feature.id(), id_highway_name, highway_name)
        if highway_oneway:
            layer_parking.changeAttributeValue(feature.id(), id_highway_oneway, highway_oneway)
        if side:
            layer_parking.changeAttributeValue(feature.id(), id_side, side)

    layer_parking.updateFields()
    layer_parking.commitChanges()

    layer_parking.removeSelection()

    return(layer_parking)



def getCapacity(layer):
#-------------------------------------------------------------------------------
# Removes line segments from street parking layers if they are too short for
# parking (space for less than one vehicle) and adds/corrects capacity
# attributes (depending on parking orientation).
#-------------------------------------------------------------------------------
# > layer: The layer for which the segments are to be checked.
#-------------------------------------------------------------------------------

    layer.startEditing()
    id_capacity = layer.fields().indexOf('capacity')
    car_diag_width = math.sqrt(car_width * 0.5 * car_width) + math.sqrt(car_length * 0.5 * car_length)
    bus_diag_width = math.sqrt(bus_width * 0.5 * bus_width) + math.sqrt(bus_length * 0.5 * bus_length)
#Korrektur/Verbesserung: Bei Einstellwinkel 60 gon = 54 Grad: car_length * sin (36 Grad) + car_width * cos(36 Grad) = 4.04 Meter
    for feature in layer.getFeatures():
        orientation = feature.attribute('orientation')
        capacity = feature.attribute('capacity')
        vehicle = feature.attribute('vehicle_designated')
        geom = feature.geometry()
        length = geom.length()

        has_capacity = False
        if capacity != NULL:
            has_capacity = True

        #capacity of bus parking is calculated with a bigger size
        if vehicle == 'bus':
            vehicle_dist_para = bus_dist_para
            vehicle_dist_diag = bus_dist_diag
            vehicle_dist_perp = bus_dist_perp
            vehicle_length = bus_length
            vehicle_width = bus_width
            vehicle_diag_width = bus_diag_width
        else:
            vehicle_dist_para = car_dist_para
            vehicle_dist_diag = car_dist_diag
            vehicle_dist_perp = car_dist_perp
            vehicle_length = car_length
            vehicle_width = car_width
            vehicle_diag_width = car_diag_width

        if orientation == 'parallel':
            #Wenn Segment zu kurz für ein Fahrzeug: löschen
            if length < vehicle_length:
                layer.deleteFeature(feature.id())
                continue
            elif capacity == NULL:
                #Anzahl Parkplätze ergibt sich aus Segmentlänge - abzüglich eines Ragierabstands zwischen zwei Fahrzeugen, der an einem der beiden Enden des Segments nicht benötigt wird
                capacity = math.floor((length + (vehicle_dist_para - vehicle_length)) / vehicle_dist_para)
                layer.changeAttributeValue(feature.id(), id_capacity, capacity)
        elif orientation == 'diagonal':
            if length < vehicle_width:
                layer.deleteFeature(feature.id())
                continue
            elif capacity == NULL:
                capacity = math.floor((length + (vehicle_dist_diag - vehicle_diag_width)) / vehicle_dist_diag)
                layer.changeAttributeValue(feature.id(), id_capacity, capacity)
        elif orientation == 'perpendicular':
            if length < vehicle_width:
                layer.deleteFeature(feature.id())
                continue
            elif capacity == NULL:
                capacity = math.floor((length + (vehicle_dist_perp - vehicle_width)) / vehicle_dist_perp)
                layer.changeAttributeValue(feature.id(), id_capacity, capacity)

        if capacity == NULL:
            layer.changeAttributeValue(feature.id(), id_capacity, 0)

        #Schnittfehler bei Segmenten mit gegebener Stellplatzzahl korrigieren
        #(vorgegebene capacity auf Segmente aufteilen, falls sie geteilt wurden)
        if has_capacity:
            id = feature.attribute('id')

            length_sum = 0
            for other_feature in layer.getFeatures('"id" = \'' + id + '\''):
                if other_feature.attribute('side') == feature.attribute('side') and other_feature.attribute('parking_source') == feature.attribute('parking_source'):
                    other_geom = other_feature.geometry()
                    length_sum += other_geom.length()
            if length < length_sum:
                capacity_single = round((length / length_sum) * int(capacity))
                layer.changeAttributeValue(feature.id(), id_capacity, capacity_single)
                if capacity_single == 0:
                    layer.deleteFeature(feature.id())

    layer.updateFields()
    layer.commitChanges()

    #finally delete features without capacity
    layer = processing.run('qgis:extractbyexpression', { 'INPUT' : layer, 'EXPRESSION' : '"capacity" IS NOT NULL AND "capacity" > 0', 'OUTPUT': 'memory:'})['OUTPUT']

    return(layer)



#------------------------------------------------------------------------------#
#      S c r i p t   S t a r t                                                 #
#------------------------------------------------------------------------------#

#create necessary directories if not existing
need_dir = [dir_output]
for d in need_dir:
    if not os.path.exists(d):
        os.makedirs(d)

#create layer groups
group_parking = QgsProject.instance().layerTreeRoot().addGroup('parking')
group_buffer = QgsProject.instance().layerTreeRoot().addGroup('buffer')
group_buffer.setExpanded(False)
group_streets = QgsProject.instance().layerTreeRoot().addGroup('streets')
group_streets.setExpanded(False)

#prepare layers with specific data (streets, street parking, pedestrian crossings)
layers = prepareLayers()
if layers:
    layer_street = layers[0]
    layer_service = layers[1]
    layer_parking_left = layers[2]
    layer_parking_right = layers[3]
    layer_points = layers[4]
    layer_polygons = layers[5]
    layer_lines = layers[6]

    #create "virtual kerb" layer where parking lanes are located later for snapping features that affect parking
    if process_separate_parking or buffer_bus_stop or process_parking_obstacles:
        layer_virtual_kerb_left = processing.run('native:offsetline', {'INPUT': layer_parking_left, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
        layer_virtual_kerb_left = processing.run('native:reverselinedirection', {'INPUT': layer_virtual_kerb_left, 'OUTPUT': 'memory:'})['OUTPUT']
        layer_virtual_kerb_right = processing.run('native:offsetline', {'INPUT': layer_parking_right, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
        layer_virtual_kerb = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_virtual_kerb_left, layer_virtual_kerb_right], 'OUTPUT': 'memory:'})['OUTPUT']
    #QgsProject.instance().addMapLayer(layer_virtual_kerb, True)

    layer_street.setName('street network')
    layer_service.setName('service roads')
    layer_street.loadNamedStyle(dir + 'styles/street_simple.qml')
    layer_service.loadNamedStyle(dir + 'styles/street_simple.qml')

    #separate and bundle street parking attributes to a left and a right layer
    print(time.strftime('%H:%M:%S', time.localtime()), 'Processing street parking data...')

    field_list = parking_attribute_list.copy()
    field_list.remove('id')

    #connect adjoining street parking segments with same properties
    #TODO Warning: Can possibly lead to faults if two segments with opposite directions but the same properties meet.
    layer_parking_left = processing.run('native:dissolve', {'INPUT': layer_parking_left, 'FIELD' : field_list, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_right = processing.run('native:dissolve', {'INPUT': layer_parking_right, 'FIELD' : field_list, 'OUTPUT': 'memory:'})['OUTPUT']

    #calculate angles at pedestrian crossings (for rendering and spatial calculations)
    layer_vertices = processing.run('native:extractvertices', {'INPUT': layer_street, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_points = processing.run('native:joinattributesbylocation', {'INPUT': layer_points, 'JOIN' : layer_vertices, 'JOIN_FIELDS' : ['angle'], 'OUTPUT': 'memory:'})['OUTPUT']
    #also apply street width
    layer_points = processing.run('native:joinattributesbylocation', {'INPUT': layer_points, 'JOIN' : layer_street, 'JOIN_FIELDS' : ['width_proc', 'parking:right:width:carriageway', 'parking:left:width:carriageway'], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_points = QgsProject.instance().addMapLayer(layer_points, False)

    #store road segments without parking lanes separately
    layer_no_parking_left = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_left, 'EXPRESSION' : '"parking" IS \'no\' OR "parking" IS \'separate\' OR ("parking" IS NULL AND "orientation" IS NULL)', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_left = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_left, 'EXPRESSION' : '"parking" IS NOT \'no\' AND "parking" IS NOT \'separate\' AND ("parking" IS NOT NULL OR "orientation" IS NOT NULL)', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking_right = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_right, 'EXPRESSION' : '"parking" IS \'no\' OR "parking" IS \'separate\' OR ("parking" IS NULL AND "orientation" IS NULL)', 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_right = processing.run('qgis:extractbyexpression', { 'INPUT' : layer_parking_right, 'EXPRESSION' : '"parking" IS NOT \'no\' AND "parking" IS NOT \'separate\' AND ("parking" IS NOT NULL OR "orientation" IS NOT NULL)', 'OUTPUT': 'memory:'})['OUTPUT']

    #cut street parking segments in the area of pedestrian crossings (before offset, because affects both sides)
    layer_parking_left = bufferCrossing(layer_parking_left, layer_points, 'left')
    layer_parking_right = bufferCrossing(layer_parking_right, layer_points, 'right')

    #cut street parking segments in the area of turning circles (before offset, because affects both sides)
    layer_parking_left = bufferTurningCircles(layer_parking_left, layer_points, 'left')
    layer_parking_right = bufferTurningCircles(layer_parking_right, layer_points, 'right')

    #offset street parking segments according to the lane width
    print(time.strftime('%H:%M:%S', time.localtime()), 'Offset street parking data...')
    layer_parking_left = processing.run('native:offsetline', {'INPUT': layer_parking_left, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking_right = processing.run('native:offsetline', {'INPUT': layer_parking_right, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking_left = processing.run('native:offsetline', {'INPUT': layer_no_parking_left, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking_right = processing.run('native:offsetline', {'INPUT': layer_no_parking_right, 'DISTANCE' : QgsProperty.fromExpression('"offset"'), 'OUTPUT': 'memory:'})['OUTPUT']

    #merge left and right street parking layers (reverse left side line direction before)
    layer_parking_left = processing.run('native:reverselinedirection', {'INPUT': layer_parking_left, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_parking_left,layer_parking_right], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking_left = processing.run('native:reverselinedirection', {'INPUT': layer_no_parking_left, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_no_parking_left, layer_no_parking_right], 'OUTPUT': 'memory:'})['OUTPUT']
    layer_no_parking = processing.run('qgis:deletecolumn', {'INPUT' : layer_no_parking, 'COLUMN' : ['path'], 'OUTPUT': 'memory:'})['OUTPUT']

    #include separately mapped parking nodes and convert them to lines (along the virtual kerb line)
    if process_separate_parking:
        print(time.strftime('%H:%M:%S', time.localtime()), 'Include separate parking nodes...')
        layer_parking_separate_nodes = processSeparateParkingNodes(layer_points, layer_virtual_kerb)

    #include separately mapped parking areas and convert them to lines
    if process_separate_parking:
        print(time.strftime('%H:%M:%S', time.localtime()), 'Include separate parking areas...')
        layer_parking_separate_areas = processSeparateParkingAreas(layer_parking, layer_polygons, layer_virtual_kerb)

    #keep street parking segments free in the area of bus stops
    if buffer_bus_stop:
        print(time.strftime('%H:%M:%S', time.localtime()), 'Processing bus stops...')
        layer_parking = bufferBusStop(layer_parking, layer_points, layer_virtual_kerb)

    #cut segments at installations and obstacles on the carriageway (bicycle parking, parkletts, street furniture tagged as parking obstacle...)
    if process_parking_obstacles:
        print(time.strftime('%H:%M:%S', time.localtime()), 'Processing parking obstacles...')
        layer_parking = processObstacles(layer_parking, layer_polygons, layer_points, layer_lines, layer_virtual_kerb)
        #do the same for separately mapped parking areas, but snap to the actual parking segment
        if process_separate_parking:
            layer_parking_separate_areas = processObstacles(layer_parking_separate_areas, layer_polygons, layer_points, layer_lines, layer_parking_separate_areas)

    #TODO include lowered kerbs (kerb=lowered)
    #TODO cut BSR ramps

    QgsProject.instance().addMapLayer(layer_parking, False)

    #separately cut off street parking segments on service roads near the intersection area
    #Select service roads with street parking information, determine intersections with roads and buffer these by the width of the road + 5 metre distance
    print(time.strftime('%H:%M:%S', time.localtime()), 'Processing intersections/driveways...')
    processing.run('qgis:selectbyexpression', {'INPUT' : layer_service, 'EXPRESSION' : ' \"parking:left\" IS NOT NULL OR \"parking:right\" IS NOT NULL'})
    intersects = processing.run('native:lineintersections', {'INPUT' : QgsProcessingFeatureSourceDefinition(layer_service.id(), selectedFeaturesOnly=True), 'INTERSECT' : layer_street, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_service.removeSelection()
    intersects_buffer = processing.run('native:buffer', {'DISTANCE' : QgsProperty.fromExpression('("width_proc_2" / 2) + 5'), 'INPUT' : intersects, 'OUTPUT': 'memory:'})['OUTPUT']
    #add buffer to map
    QgsProject.instance().addMapLayer(intersects_buffer, False)
    group_buffer.insertChildNode(0, QgsLayerTreeLayer(intersects_buffer))
    intersects_buffer.loadNamedStyle(dir + 'styles/buffer_dashed.qml')
    intersects_buffer.setName('shorten service roads')
    #cut the buffers just created from the parking lanes belonging to service roads
    processing.run('qgis:selectbyattribute', {'FIELD' : 'highway', 'INPUT' : layer_parking, 'VALUE' : 'service'})
    layer_parking_service = processing.run('native:difference', {'INPUT' : QgsProcessingFeatureSourceDefinition(layer_parking.id(), selectedFeaturesOnly=True), 'OVERLAY' : intersects_buffer, 'OUTPUT': 'memory:'})['OUTPUT']
    #replace old, uncut parking lanes with newly created cut parking lanes
    layer_parking.startEditing()
    for feature in layer_parking.selectedFeatures():
        layer_parking.deleteFeature(feature.id())
    layer_parking.commitChanges()
    layer_parking = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_parking,layer_parking_service], 'OUTPUT': 'memory:'})['OUTPUT']

    #cut off street parking segments in the carriageway areas
    #Method A - simple but not reliable at intersections between narrow and wider roads:
    #detect intersections between street and parking lane lines, buffer them and cut from parking lane to avoid false parking lanes in large intersection areas
    #layer_parking = bufferIntersection(layer_parking, layer_street, '(min("highway:width_proc", "width_proc") / 2) - 2', 'road junctions', NULL)

    #Method B - maybe slower but safer:
    #buffer the highway line according to its width and cut off parking lanes within this buffer
    centerline = processing.run('native:offsetline', { 'DISTANCE' : QgsProperty.fromExpression('"parking:left:offset" - (("parking:left:offset" + abs("parking:right:offset")) / 2)'), 'INPUT' : layer_street, 'OUTPUT': 'memory:'})['OUTPUT']
    carriageway_buffer = processing.run('native:buffer', { 'DISTANCE' : QgsProperty.fromExpression('("width_proc" / 2) - 0.5'), 'END_CAP_STYLE' : 1, 'INPUT' : centerline, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', { 'INPUT' : layer_parking, 'OVERLAY' : carriageway_buffer, 'OUTPUT': 'memory:'})['OUTPUT']

    #keep parking lanes free in driveway zones
    if buffer_driveway:
        layer_parking = bufferIntersection(layer_parking, layer_service, 'max("width_proc" / 2, ' + str(buffer_driveway / 2) + ')', 'driveways', NULL)
        if process_separate_parking:
            layer_parking_separate_areas = bufferIntersection(layer_parking_separate_areas, layer_service, 'max("width_proc" / 2, ' + str(buffer_driveway / 2) + ')', 'driveways (separate parking areas)', NULL)

    #calculate kerb intersection points
    print(time.strftime('%H:%M:%S', time.localtime()), 'Processing kerb intersection points...')
    intersects = getKerbIntersections(layer_street)

    #locate 5-metre buffers around kerb intersections and cut from parking lanes
    intersects_buffer = processing.run('native:buffer', {'DISTANCE' : 5, 'INPUT' : intersects, 'OUTPUT': 'memory:'})['OUTPUT']
    layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : intersects_buffer, 'OUTPUT': 'memory:'})['OUTPUT']

    #keep parking lanes free where separately mapped parking features are located
    if process_separate_parking:
        layer_parking_separate = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_parking_separate_nodes, layer_parking_separate_areas], 'OUTPUT': 'memory:'})['OUTPUT']
        #snap separate feature lines to virtual kerb
        layer_parking_separate_cut = processing.run('native:snapgeometries', { 'BEHAVIOR' : 1, 'INPUT' : layer_parking_separate, 'REFERENCE_LAYER' : layer_virtual_kerb, 'TOLERANCE' : 8, 'OUTPUT': 'memory:'})['OUTPUT']
        #buffer lines with rectangular shape
        layer_parking_separate_cut = processing.run('native:buffer', {'INPUT' : layer_parking_separate_cut, 'DISTANCE' : 2, 'END_CAP_STYLE' : 1, 'JOIN_STYLE' : 2, 'MITER_LIMIT' : 2, 'OUTPUT': 'memory:'})['OUTPUT']
        #cut parking lanes inside this buffers
        layer_parking = processing.run('native:difference', {'INPUT' : layer_parking, 'OVERLAY' : layer_parking_separate_cut, 'OUTPUT': 'memory:'})['OUTPUT']

        #if missing in attributes if separate parking features: get side, highway, highway name and oneway from nearest virtual kerb line
        layer_parking_separate = pickMissingHighwayAttributes(layer_parking_separate, layer_virtual_kerb)

    #merge with street parking lines from separately mapped street parking features
    if process_separate_parking:
        layer_parking = processing.run('native:mergevectorlayers', {'LAYERS' : [layer_parking, layer_parking_separate], 'OUTPUT': 'memory:'})['OUTPUT']

    #convert multi-part parking lanes into single-part objects
    layer_parking = processing.run('native:multiparttosingleparts', {'INPUT' : layer_parking, 'OUTPUT': 'memory:'})['OUTPUT']

    #delete street parking segments/line artefacts if they are too short for parking...
    #...and add capacity information to line segments or correct cutting errors
    layer_parking = getCapacity(layer_parking)

    #delete unimportant attributes and save output file
    layer_parking = clearAttributes(layer_parking, parking_attribute_list)

    print(time.strftime('%H:%M:%S', time.localtime()), 'Save street parking features...')
    qgis.core.QgsVectorFileWriter.writeAsVectorFormat(layer_parking, dir_output + 'street_parking_lines.geojson', 'utf-8', QgsCoordinateReferenceSystem(crs_to), save_options.driverName)

    #add street parking to map
    layer_no_parking.setName('no street parking')
    QgsProject.instance().addMapLayer(layer_no_parking, False)
    group_parking.insertChildNode(0, QgsLayerTreeLayer(layer_no_parking))
    layer_no_parking.loadNamedStyle(dir + 'styles/parking_lanes_no.qml')

    layer_parking.setName('street parking')
    QgsProject.instance().addMapLayer(layer_parking, False)
    group_parking.insertChildNode(0, QgsLayerTreeLayer(layer_parking))
    layer_parking.loadNamedStyle(dir + 'styles/parking_lanes.qml')

    #convert street parking segments into chains of points for each individual vehicle
    if create_point_chain:
        print(time.strftime('%H:%M:%S', time.localtime()), 'Convert lanes to points...')
        #TODO use calculation from Straßenraumkarte Neukölln Script that is very precise
        #TODO capacity of bus parking spaces isn't calculated correctly
        #Method A: simple calculation for nodes on kerb line
        #layer_parking_chain = processing.run('native:pointsalonglines', {'INPUT' : layer_parking, 'DISTANCE' : QgsProperty.fromExpression('if("orientation" = \'parallel\' OR "orientation" = \'diagonal\' OR "orientation" = \'perpendicular\', $length / "capacity", 0)'), 'START_OFFSET' : QgsProperty.fromExpression('if(\"orientation\" = \'parallel\', 2.6 - 0.4, if(\"orientation\" = \'diagonal\', 1.27, if(\"orientation\" = \'perpendicular\', 1.25 - 0.4, 0)))'), 'END_OFFSET' : QgsProperty.fromExpression('if(\"orientation\" = \'parallel\', 2.6 - 0.4, if(\"orientation\" = \'diagonal\', 3.11, if(\"orientation\" = \'perpendicular\', 1.25 - 0.4, 0)))'), 'OUTPUT' : dir_output + 'parking_points.geojson' })

        #Method B: complex calculation and offset of the point to the centre of the vehicle
        layer_parking_chain = processing.run('native:pointsalonglines', {'INPUT' : layer_parking, 'DISTANCE' : QgsProperty.fromExpression('if("source:capacity" = \'estimated\', if("orientation" = \'diagonal\', 3.1, if("orientation" = \'perpendicular\', 2.5, 5.2)), if("capacity" = 1, $length, if($length < if("orientation" = \'diagonal\', 3.1 * "capacity", if("orientation" = \'perpendicular\', 2.5 * "capacity", (5.2 * "capacity") - 0.8)), ($length + (if("orientation" = \'parallel\', 0.8, if("orientation" = \'perpendicular\', 0.5, 0))) - (2 * if("orientation" = \'diagonal\', 1.55, if("orientation" = \'perpendicular\', 1.25, 2.6)))) / ("capacity" - 1), ($length - (2 * if("orientation" = \'diagonal\', 1.55, if("orientation" = \'perpendicular\', 1.25, 2.6)))) / ("capacity" - 1))))'), 'START_OFFSET' : QgsProperty.fromExpression('if("source:capacity" = \'estimated\', if("orientation" = \'diagonal\', ($length - (3.1*("capacity" - 1))) / 2, if("orientation" = \'perpendicular\', ($length - (2.5*("capacity" - 1))) / 2, ($length - (5.2*("capacity" - 1))) / 2)), if("capacity" < 2, $length / 2, if("orientation" = \'diagonal\', 1.55, if("orientation" = \'perpendicular\', if($length < if("orientation" = \'diagonal\', 3.1 * "capacity", if("orientation" = \'perpendicular\', 2.5 * "capacity", (5.2 * "capacity") - 0.8)), 0.9, 1.25), if($length < if("orientation" = \'diagonal\', 3.1 * "capacity", if("orientation" = \'perpendicular\', 2.5 * "capacity", (5.2 * "capacity") - 0.8)), 2.2, 2.6)))))'), 'OUTPUT': 'memory:'})['OUTPUT']
        layer_parking_chain = processing.run('native:translategeometry', {'INPUT' : layer_parking_chain, 'DELTA_X' : QgsProperty.fromExpression('if("parking" = \'lane\' or "parking" IS NULL or "parking_source" ILIKE \'%separate%\', cos((("angle") - if("orientation" = \'diagonal\', if("side" = \'left\' AND "highway:oneway" = \'true\', -27, 27), 0)) * (pi() / 180)) * if("orientation" = \'diagonal\', -2.1, if("orientation" = \'perpendicular\', -2.2, -1)), if(("parking" = \'street_side\' or "parking" = \'on_kerb\' or "parking" = \'shoulder\') and not "parking_source" ILIKE \'%separate%\', -cos((("angle") - if("orientation" = \'diagonal\', if("side" = \'left\' and "highway:oneway" = \'yes\', -27, 27), 0)) * (pi() / 180)) * if("orientation" = \'diagonal\', -2.1, if("orientation" = \'perpendicular\', -2.2, -1)), 0))'), 'DELTA_Y' : QgsProperty.fromExpression('if("parking" = \'lane\' or "parking" IS NULL or "parking_source" ILKIE \'%separate%\', sin(("angle" - 180 - if("orientation" = \'diagonal\', if("side" = \'left\' and "highway:oneway" = \'yes\', -27, 27), 0)) * (pi() / 180)) * if("orientation" = \'diagonal\', -2.1, if("orientation" = \'perpendicular\', -2.2, -1)), if(("parking" = \'street_side\' or "parking" = \'on_kerb\' or "parking" = \'shoulder\') and not "parking_source" ILIKE \'%separate%\', -sin(("angle" - 180 - if("orientation" = \'diagonal\', if("side" = \'left\' and "highway:oneway" = \'yes\', -27, 27), 0)) * (pi() / 180)) * if("orientation" = \'diagonal\', -2.1, if("orientation" = \'perpendicular\', -2.2, -1)), 0))'), 'OUTPUT': 'memory:'})['OUTPUT']

        #clean up point attributes
        point_attribute_list = parking_attribute_list.copy()
        for attr in ['capacity','source:capacity','offset']:
            if attr in point_attribute_list:
                point_attribute_list.remove(attr)
        point_attribute_list.append('angle')
        layer_parking_chain = clearAttributes(layer_parking_chain, point_attribute_list)

        #offset to the left side of the line for reversed line directions/left hand traffic
        #TODO: Add variable for right or left hand traffic (and use this also for reversing line direction)

        #add point chain to map
        layer_parking_chain.setName('street parking (points)')
        QgsProject.instance().addMapLayer(layer_parking_chain, False)
        group_parking.insertChildNode(0, QgsLayerTreeLayer(layer_parking_chain))
        layer_parking_chain.loadNamedStyle(dir + 'styles/parking_chain.qml')

        print(time.strftime('%H:%M:%S', time.localtime()), 'Save parking points...')
        qgis.core.QgsVectorFileWriter.writeAsVectorFormat(layer_parking_chain, dir_output + 'street_parking_points.geojson', 'utf-8', QgsCoordinateReferenceSystem(crs_to), save_options.driverName)

    #focus on parking layer
    iface.mapCanvas().setExtent(layer_parking.extent())

    print(time.strftime('%H:%M:%S', time.localtime()), 'Completed.')
