<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" simplifyDrawingHints="1" simplifyDrawingTol="1" simplifyLocal="1" simplifyAlgorithm="0" minScale="100000000" simplifyMaxScale="1" readOnly="0" version="3.16.3-Hannover" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal mode="0" startExpression="" endField="" accumulate="0" startField="" endExpression="" fixedDuration="0" enabled="0" durationField="" durationUnit="min">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 symbollevels="0" forceraster="0" attr="highway" enableorderby="0" type="categorizedSymbol">
    <categories>
      <category symbol="0" render="true" value="construction" label="construction"/>
      <category symbol="1" render="true" value="" label=""/>
    </categories>
    <symbols>
      <symbol clip_to_extent="1" force_rhr="0" name="0" alpha="1" type="line">
        <layer class="MarkerLine" pass="0" enabled="1" locked="0">
          <prop k="average_angle_length" v="4"/>
          <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="average_angle_unit" v="MM"/>
          <prop k="interval" v="4"/>
          <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="interval_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset" v="0"/>
          <prop k="offset_along_line" v="0"/>
          <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_along_line_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="RenderMetersInMapUnits"/>
          <prop k="placement" v="interval"/>
          <prop k="ring_filter" v="0"/>
          <prop k="rotate" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="interval" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="&quot;width_proc&quot;" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
                <Option name="outlineWidth" type="Map">
                  <Option name="active" value="false" type="bool"/>
                  <Option name="expression" value="&quot;width_proc&quot; / 4" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" force_rhr="0" name="@0@0" alpha="1" type="marker">
            <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
              <prop k="angle" v="0"/>
              <prop k="color" v="210,210,210,255"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="name" v="circle"/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="RenderMetersInMapUnits"/>
              <prop k="outline_color" v="35,35,35,255"/>
              <prop k="outline_style" v="no"/>
              <prop k="outline_width" v="0"/>
              <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="outline_width_unit" v="RenderMetersInMapUnits"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="RenderMetersInMapUnits"/>
              <prop k="vertical_anchor_point" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="size" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="expression" value="&quot;width_proc&quot; / 2" type="QString"/>
                      <Option name="type" value="3" type="int"/>
                    </Option>
                  </Option>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" name="1" alpha="1" type="line">
        <layer class="SimpleLine" pass="0" enabled="1" locked="0">
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="round"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MapUnit"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="round"/>
          <prop k="line_color" v="210,210,210,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.26"/>
          <prop k="line_width_unit" v="MapUnit"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MapUnit"/>
          <prop k="ring_filter" v="0"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="offset" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="(to_real(&quot;parking:right:width:carriageway&quot;) - to_real(&quot;parking:left:width:carriageway&quot;)) / 2" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
                <Option name="outlineWidth" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="expression" value="&quot;width_proc&quot;" type="QString"/>
                  <Option name="type" value="3" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <source-symbol>
      <symbol clip_to_extent="1" force_rhr="0" name="0" alpha="1" type="line">
        <layer class="SimpleLine" pass="0" enabled="1" locked="0">
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="round"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MapUnit"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="round"/>
          <prop k="line_color" v="210,210,210,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.26"/>
          <prop k="line_width_unit" v="MapUnit"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MapUnit"/>
          <prop k="ring_filter" v="0"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="outlineWidth" type="Map">
                  <Option name="active" value="true" type="bool"/>
                  <Option name="field" value="processing_width" type="QString"/>
                  <Option name="type" value="2" type="int"/>
                </Option>
              </Option>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </source-symbol>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontFamily="DejaVu Sans" fontStrikeout="0" textOpacity="1" fontItalic="0" useSubstitutions="0" multilineHeight="1" fontLetterSpacing="0" fontSizeUnit="RenderMetersInMapUnits" previewBkgrdColor="255,255,255,255" fontSize="10" textOrientation="horizontal" fieldName="name" fontWeight="50" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontUnderline="0" blendMode="0" textColor="255,255,255,255" allowHtml="0" namedStyle="Book" capitalization="0" fontKerning="1" fontWordSpacing="0" isExpression="0">
        <text-buffer bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferJoinStyle="128" bufferBlendMode="0" bufferColor="255,255,255,255" bufferSizeUnits="MM" bufferDraw="0" bufferSize="1" bufferOpacity="1" bufferNoFill="1"/>
        <text-mask maskJoinStyle="128" maskSize="1.5" maskEnabled="0" maskedSymbolLayers="" maskType="0" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskOpacity="1" maskSizeUnits="MM"/>
        <background shapeSizeType="0" shapeBorderColor="128,128,128,255" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidth="0" shapeOffsetUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="MM" shapeRadiiUnit="MM" shapeBorderWidthUnit="MM" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeRotationType="0" shapeType="0" shapeOpacity="1" shapeBlendMode="0" shapeSVGFile="" shapeOffsetY="0" shapeRotation="0" shapeDraw="0" shapeRadiiX="0" shapeJoinStyle="64" shapeRadiiY="0" shapeFillColor="255,255,255,255" shapeOffsetX="0" shapeSizeY="0" shapeSizeX="0">
          <symbol clip_to_extent="1" force_rhr="0" name="markerSymbol" alpha="1" type="marker">
            <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
              <prop k="angle" v="0"/>
              <prop k="color" v="232,113,141,255"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="name" v="circle"/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="outline_color" v="35,35,35,255"/>
              <prop k="outline_style" v="solid"/>
              <prop k="outline_width" v="0"/>
              <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="outline_width_unit" v="MM"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="MM"/>
              <prop k="vertical_anchor_point" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOffsetGlobal="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowColor="0,0,0,255" shadowBlendMode="6" shadowOpacity="0.7" shadowRadiusUnit="MM" shadowDraw="0" shadowRadius="1.5" shadowOffsetDist="1" shadowUnder="0" shadowRadiusAlphaOnly="0" shadowOffsetAngle="135" shadowOffsetUnit="MM" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100"/>
        <dd_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format placeDirectionSymbol="0" formatNumbers="0" autoWrapLength="0" useMaxLineLengthForAutoWrap="1" decimals="3" plussign="0" leftDirectionSymbol="&lt;" wrapChar="" multilineAlign="0" addDirectionSymbol="0" reverseDirectionSymbol="0" rightDirectionSymbol=">"/>
      <placement repeatDistance="250" lineAnchorPercent="0.5" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" distUnits="MM" yOffset="0" offsetType="0" geometryGeneratorEnabled="0" overrunDistanceUnit="MM" rotationAngle="0" dist="0" lineAnchorType="0" distMapUnitScale="3x:0,0,0,0,0,0" quadOffset="4" overrunDistance="0" geometryGenerator="" polygonPlacementFlags="2" repeatDistanceUnits="RenderMetersInMapUnits" centroidInside="0" maxCurvedCharAngleOut="-25" fitInPolygonOnly="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" placement="3" preserveRotation="1" offsetUnits="MM" priority="5" xOffset="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" placementFlags="9" geometryGeneratorType="PointGeometry" centroidWhole="0" maxCurvedCharAngleIn="25" layerType="LineGeometry"/>
      <rendering fontLimitPixelSize="0" obstacleFactor="1" scaleVisibility="0" obstacle="1" drawLabels="1" maxNumLabels="2000" fontMaxPixelSize="10000" scaleMin="0" obstacleType="1" upsidedownLabels="0" displayAll="0" fontMinPixelSize="3" zIndex="0" limitNumLabels="0" minFeatureSize="0" mergeLines="1" labelPerPart="0" scaleMax="0"/>
      <dd_properties>
        <Option type="Map">
          <Option name="name" value="" type="QString"/>
          <Option name="properties" type="Map">
            <Option name="Size" type="Map">
              <Option name="active" value="true" type="bool"/>
              <Option name="expression" value="&quot;processing_width&quot; - 2" type="QString"/>
              <Option name="type" value="3" type="int"/>
            </Option>
          </Option>
          <Option name="type" value="collection" type="QString"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option name="anchorPoint" value="pole_of_inaccessibility" type="QString"/>
          <Option name="ddProperties" type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
          <Option name="drawToAllParts" value="false" type="bool"/>
          <Option name="enabled" value="0" type="QString"/>
          <Option name="labelAnchorPoint" value="point_on_exterior" type="QString"/>
          <Option name="lineSymbol" value="&lt;symbol clip_to_extent=&quot;1&quot; force_rhr=&quot;0&quot; name=&quot;symbol&quot; alpha=&quot;1&quot; type=&quot;line&quot;>&lt;layer class=&quot;SimpleLine&quot; pass=&quot;0&quot; enabled=&quot;1&quot; locked=&quot;0&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; value=&quot;&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; value=&quot;collection&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString"/>
          <Option name="minLength" value="0" type="double"/>
          <Option name="minLengthMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="minLengthUnit" value="MM" type="QString"/>
          <Option name="offsetFromAnchor" value="0" type="double"/>
          <Option name="offsetFromAnchorMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="offsetFromAnchorUnit" value="MM" type="QString"/>
          <Option name="offsetFromLabel" value="0" type="double"/>
          <Option name="offsetFromLabelMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="offsetFromLabelUnit" value="MM" type="QString"/>
        </Option>
      </callout>
    </settings>
  </labeling>
  <customproperties>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory backgroundColor="#ffffff" scaleDependency="Area" minScaleDenominator="0" rotationOffset="270" sizeType="MM" width="15" height="15" lineSizeType="MM" diagramOrientation="Up" spacingUnitScale="3x:0,0,0,0,0,0" sizeScale="3x:0,0,0,0,0,0" backgroundAlpha="255" penAlpha="255" showAxis="1" direction="0" maxScaleDenominator="1e+8" labelPlacementMethod="XHeight" enabled="0" scaleBasedVisibility="0" penWidth="0" spacingUnit="MM" minimumSize="0" barWidth="5" spacing="5" lineSizeScale="3x:0,0,0,0,0,0" opacity="1" penColor="#000000">
      <fontProperties style="" description="Cantarell,11,-1,5,50,0,0,0,0,0"/>
      <attribute color="#000000" field="" label=""/>
      <axisSymbol>
        <symbol clip_to_extent="1" force_rhr="0" name="" alpha="1" type="line">
          <layer class="SimpleLine" pass="0" enabled="1" locked="0">
            <prop k="align_dash_pattern" v="0"/>
            <prop k="capstyle" v="square"/>
            <prop k="customdash" v="5;2"/>
            <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="customdash_unit" v="MM"/>
            <prop k="dash_pattern_offset" v="0"/>
            <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="dash_pattern_offset_unit" v="MM"/>
            <prop k="draw_inside_polygon" v="0"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="line_color" v="35,35,35,255"/>
            <prop k="line_style" v="solid"/>
            <prop k="line_width" v="0.26"/>
            <prop k="line_width_unit" v="MM"/>
            <prop k="offset" v="0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="ring_filter" v="0"/>
            <prop k="tweak_dash_pattern_on_corners" v="0"/>
            <prop k="use_custom_dash" v="0"/>
            <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" value="" type="QString"/>
                <Option name="properties"/>
                <Option name="type" value="collection" type="QString"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings zIndex="0" priority="0" placement="2" obstacle="0" dist="0" showAll="1" linePlacementFlags="18">
    <properties>
      <Option type="Map">
        <Option name="name" value="" type="QString"/>
        <Option name="properties"/>
        <Option name="type" value="collection" type="QString"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions removeDuplicateNodes="0" geometryPrecision="0">
    <activeChecks/>
    <checkConfiguration/>
  </geometryOptions>
  <legend type="default-vector"/>
  <referencedLayers/>
  <fieldConfiguration>
    <field configurationFlags="None" name="id">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="highway">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="surface">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="name">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:left">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:left:orientation">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:right">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:right:orientation">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:left:width">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="width_proc">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="width_proc:effective">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:right:width">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:left:width:carriageway">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:right:width:carriageway">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:left:offset">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking:right:offset">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="error_output">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" index="0" field="id"/>
    <alias name="" index="1" field="highway"/>
    <alias name="" index="2" field="surface"/>
    <alias name="" index="3" field="name"/>
    <alias name="" index="4" field="parking:left"/>
    <alias name="" index="5" field="parking:left:orientation"/>
    <alias name="" index="6" field="parking:right"/>
    <alias name="" index="7" field="parking:right:orientation"/>
    <alias name="" index="8" field="parking:left:width"/>
    <alias name="" index="9" field="width_proc"/>
    <alias name="" index="10" field="width_proc:effective"/>
    <alias name="" index="11" field="parking:right:width"/>
    <alias name="" index="12" field="parking:left:width:carriageway"/>
    <alias name="" index="13" field="parking:right:width:carriageway"/>
    <alias name="" index="14" field="parking:left:offset"/>
    <alias name="" index="15" field="parking:right:offset"/>
    <alias name="" index="16" field="error_output"/>
  </aliases>
  <defaults>
    <default expression="" applyOnUpdate="0" field="id"/>
    <default expression="" applyOnUpdate="0" field="highway"/>
    <default expression="" applyOnUpdate="0" field="surface"/>
    <default expression="" applyOnUpdate="0" field="name"/>
    <default expression="" applyOnUpdate="0" field="parking:left"/>
    <default expression="" applyOnUpdate="0" field="parking:left:orientation"/>
    <default expression="" applyOnUpdate="0" field="parking:right"/>
    <default expression="" applyOnUpdate="0" field="parking:right:orientation"/>
    <default expression="" applyOnUpdate="0" field="parking:left:width"/>
    <default expression="" applyOnUpdate="0" field="width_proc"/>
    <default expression="" applyOnUpdate="0" field="width_proc:effective"/>
    <default expression="" applyOnUpdate="0" field="parking:right:width"/>
    <default expression="" applyOnUpdate="0" field="parking:left:width:carriageway"/>
    <default expression="" applyOnUpdate="0" field="parking:right:width:carriageway"/>
    <default expression="" applyOnUpdate="0" field="parking:left:offset"/>
    <default expression="" applyOnUpdate="0" field="parking:right:offset"/>
    <default expression="" applyOnUpdate="0" field="error_output"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="id"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="highway"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="surface"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="name"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:left"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:left:orientation"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:right"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:right:orientation"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:left:width"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="width_proc"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="width_proc:effective"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:right:width"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:left:width:carriageway"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:right:width:carriageway"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:left:offset"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="parking:right:offset"/>
    <constraint exp_strength="0" constraints="0" unique_strength="0" notnull_strength="0" field="error_output"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="highway"/>
    <constraint exp="" desc="" field="surface"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="parking:left"/>
    <constraint exp="" desc="" field="parking:left:orientation"/>
    <constraint exp="" desc="" field="parking:right"/>
    <constraint exp="" desc="" field="parking:right:orientation"/>
    <constraint exp="" desc="" field="parking:left:width"/>
    <constraint exp="" desc="" field="width_proc"/>
    <constraint exp="" desc="" field="width_proc:effective"/>
    <constraint exp="" desc="" field="parking:right:width"/>
    <constraint exp="" desc="" field="parking:left:width:carriageway"/>
    <constraint exp="" desc="" field="parking:right:width:carriageway"/>
    <constraint exp="" desc="" field="parking:left:offset"/>
    <constraint exp="" desc="" field="parking:right:offset"/>
    <constraint exp="" desc="" field="error_output"/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{00000000-0000-0000-0000-000000000000}"/>
  </attributeactions>
  <attributetableconfig sortOrder="0" sortExpression="" actionWidgetStyle="dropDown">
    <columns>
      <column width="-1" name="id" hidden="0" type="field"/>
      <column width="-1" name="highway" hidden="0" type="field"/>
      <column width="-1" name="name" hidden="0" type="field"/>
      <column width="-1" hidden="1" type="actions"/>
      <column width="-1" name="width_proc" hidden="0" type="field"/>
      <column width="-1" name="surface" hidden="0" type="field"/>
      <column width="-1" name="width_proc:effective" hidden="0" type="field"/>
      <column width="-1" name="error_output" hidden="0" type="field"/>
      <column width="-1" name="parking:left" hidden="0" type="field"/>
      <column width="-1" name="parking:left:orientation" hidden="0" type="field"/>
      <column width="-1" name="parking:right" hidden="0" type="field"/>
      <column width="-1" name="parking:right:orientation" hidden="0" type="field"/>
      <column width="-1" name="parking:left:width" hidden="0" type="field"/>
      <column width="-1" name="parking:right:width" hidden="0" type="field"/>
      <column width="-1" name="parking:left:width:carriageway" hidden="0" type="field"/>
      <column width="-1" name="parking:right:width:carriageway" hidden="0" type="field"/>
      <column width="-1" name="parking:left:offset" hidden="0" type="field"/>
      <column width="-1" name="parking:right:offset" hidden="0" type="field"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS forms can have a Python function that is called when the form is
opened.

Use this function to add extra logic to your forms.

Enter the name of the function in the "Python Init function"
field.
An example follows:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="error_output" editable="1"/>
    <field name="highway" editable="1"/>
    <field name="id" editable="1"/>
    <field name="name" editable="1"/>
    <field name="parking:lane:left" editable="1"/>
    <field name="parking:lane:left:offset" editable="1"/>
    <field name="parking:lane:left:position" editable="1"/>
    <field name="parking:lane:left:width" editable="1"/>
    <field name="parking:lane:left:width:carriageway" editable="1"/>
    <field name="parking:lane:right" editable="1"/>
    <field name="parking:lane:right:offset" editable="1"/>
    <field name="parking:lane:right:position" editable="1"/>
    <field name="parking:lane:right:width" editable="1"/>
    <field name="parking:lane:right:width:carriageway" editable="1"/>
    <field name="parking:left" editable="1"/>
    <field name="parking:left:offset" editable="1"/>
    <field name="parking:left:orientation" editable="1"/>
    <field name="parking:left:width" editable="1"/>
    <field name="parking:left:width:carriageway" editable="1"/>
    <field name="parking:right" editable="1"/>
    <field name="parking:right:offset" editable="1"/>
    <field name="parking:right:orientation" editable="1"/>
    <field name="parking:right:width" editable="1"/>
    <field name="parking:right:width:carriageway" editable="1"/>
    <field name="processing_width" editable="1"/>
    <field name="surface" editable="1"/>
    <field name="width" editable="1"/>
    <field name="width:carriageway" editable="1"/>
    <field name="width_proc" editable="1"/>
    <field name="width_proc:effective" editable="1"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="error_output"/>
    <field labelOnTop="0" name="highway"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="name"/>
    <field labelOnTop="0" name="parking:lane:left"/>
    <field labelOnTop="0" name="parking:lane:left:offset"/>
    <field labelOnTop="0" name="parking:lane:left:position"/>
    <field labelOnTop="0" name="parking:lane:left:width"/>
    <field labelOnTop="0" name="parking:lane:left:width:carriageway"/>
    <field labelOnTop="0" name="parking:lane:right"/>
    <field labelOnTop="0" name="parking:lane:right:offset"/>
    <field labelOnTop="0" name="parking:lane:right:position"/>
    <field labelOnTop="0" name="parking:lane:right:width"/>
    <field labelOnTop="0" name="parking:lane:right:width:carriageway"/>
    <field labelOnTop="0" name="parking:left"/>
    <field labelOnTop="0" name="parking:left:offset"/>
    <field labelOnTop="0" name="parking:left:orientation"/>
    <field labelOnTop="0" name="parking:left:width"/>
    <field labelOnTop="0" name="parking:left:width:carriageway"/>
    <field labelOnTop="0" name="parking:right"/>
    <field labelOnTop="0" name="parking:right:offset"/>
    <field labelOnTop="0" name="parking:right:orientation"/>
    <field labelOnTop="0" name="parking:right:width"/>
    <field labelOnTop="0" name="parking:right:width:carriageway"/>
    <field labelOnTop="0" name="processing_width"/>
    <field labelOnTop="0" name="surface"/>
    <field labelOnTop="0" name="width"/>
    <field labelOnTop="0" name="width:carriageway"/>
    <field labelOnTop="0" name="width_proc"/>
    <field labelOnTop="0" name="width_proc:effective"/>
  </labelOnTop>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"name"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>
