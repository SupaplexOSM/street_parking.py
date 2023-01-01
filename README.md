# street_parking.py for QGIS
**Python script for QGIS to generate street parking data from OpenStreetMap (OSM) data**

## How to use

1. Run [Overpass-Query](https://overpass-turbo.eu/s/1ptH) for road network and street parking data
2. Export result as GeoJSON to 'data/input.geojson'
3. Run this python script in QGIS
   1. "Plugins" => "Python Console"
   1. (If internal Python Editor Panel is hidden: Right click in Console => "Show Editor")
   1. Open File in QGIS Python Editor
   1. Run from there (Note: Do _not_ use the "Browser" => File => "Run Script")
4. Some optional steps for quality assurance should be done afterwards:
   - Check the resulting parking lane data for bugs, depending on how accurate you need it to be. Street side and kerb parking as well as street segments with diagonal or perpendicular parking have the highest potential for accuracy failures, depending on how accurately the OSM data is mapped.
   - Locate objects that affect parking in parking lanes (e.g. street lamps or trees in the parking lane area, street furniture in kerbside parking) and cut them off from the parking lane segments.


## Results

The script generates georeferenced line features representing street parking lanes. The lines are rendered in QGIS with a basic styling and can afterwards be further edited or spatially analysed as required. To understand, how the results are interpolated, some "cutting" areas and features are also rendered.

The **attributes** include key parking information such as the capacity of a parking lane (number of parked vehicles), orientation and position (e.g. parallel or diagonal, on the carriageway, on the pavement, in a parking bay etc.), parking restrictions (free, paid, residents, time limited, disabled, temporary no parking, vehicle restrictions etc.) as well as other information (e.g. surface, parking zone, markings...) if this information is mapped in OSM.

## Features

- Calculation of parking lanes according to the [https://wiki.openstreetmap.org/wiki/Street_parking](OSM Street parking scheme)
- Interpolation of intersection areas and inclusion of driveways, traffic lights, crossings, bus stops and some other spatial features that influence parking
- Including separately mapped street parking areas (e.g. street-side parking bays)
- Basic interpretation of parking restrictions
- Street parking data can optionally also be output as point chains, where each point represents a single parking space

## Notes

- Directory: Make sure that there is no folder containing the string "street_parking.py" in the directory path (but the script itself is called exactly that) and that the following directory structure exists:

  ```
  └ your-directory
    ├ data/
    ┊ └ input.geojson
    ├ styles/
    ┊ └ [various style files for basic rendering].qml
    └ street_parking.py
  ```

- Coordinate Reference System: Results are saved in EPSG:25833 (ETRS89 / UTM zone 33N). A different CRS may be necessary at other locations and can be set at the top of the script.

- Highway Line Representation: There is no consensus yet on which line the highway objekt in OSM represents exactly: The centerline of the carriageway or the driving line. So far, this script calculates the location of parking lanes according to variant B in [this figure](https://wiki.openstreetmap.org/wiki/File:Highway_representation.png) (driving line). ![](https://wiki.openstreetmap.org/wiki/File:Highway_representation.png)

- This script is intended for the calculation of parking spaces on (or next to) the street. Depending on your needs, it may be useful to include parking spaces in car parks, multi-storey car parks, underground garages, etc.

- This script is working for countries with right hand traffic. In countries with left hand traffic, some adjustments might be necessary (not tested/supported yet)

- Background: This script was originally based on very basic programming and QGIS knowledge. Many steps have been solved more effectively in the meantime, but there are more that can certainly be solved much more elegantly. Plus there are still some (marked) TODO's that would make it even better. I am happy about improvements and extensions!

## Methodology - OSM Street Parking Project

There is a detailed [https://parkraum.osm-verkehrswende.org/project-prototype-neukoelln/report](report about the methodology of OSM street parking analysis) in German language as well as a shorter [https://www.openstreetmap.org/user/Supaplex030/diary/396104](english blog post). This is also the base of the [https://parkraum.osm-verkehrswende.org/project-vector-tiles/](OSM Street Parking Project), which has further automated this methodology and made the interpolation of OSM street parking data more scalable.

## Example Images

![street parking lines](https://raw.githubusercontent.com/SupaplexOSM/street_parking.py/main/sample%20images/street%20parking%20lines.png)
![street parking points](https://raw.githubusercontent.com/SupaplexOSM/street_parking.py/main/sample%20images/street%20parking%20points.png)
