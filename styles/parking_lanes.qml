<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.3-Hannover" minScale="100000000" labelsEnabled="0" maxScale="0" simplifyDrawingHints="1" readOnly="0" simplifyMaxScale="1" hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories" simplifyAlgorithm="0" simplifyDrawingTol="1" simplifyLocal="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal endExpression="" durationField="" enabled="0" fixedDuration="0" accumulate="0" startExpression="" startField="" endField="" durationUnit="min" mode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 forceraster="0" symbollevels="0" type="RuleRenderer" enableorderby="0">
    <rules key="{f239a9bc-0df2-429a-b75b-d4c5a8b54fb2}">
      <rule label="parallel" key="{b1467406-b271-4092-9e3d-f2ab7e482a1a}" symbol="0" filter="&quot;orientation&quot; = 'parallel'"/>
      <rule label="diagonal" key="{5c76d1fb-af22-40b3-9d42-5aef9ff15e29}" symbol="1" filter="&quot;orientation&quot; = 'diagonal'"/>
      <rule label="perpendicular" key="{a2b2a5ef-6aa8-4008-80d0-9a31b875a146}" symbol="2" filter="&quot;orientation&quot; = 'perpendicular'"/>
      <rule label="unknown" key="{06f609bf-725a-4978-8e06-fd75433f3e98}" symbol="3" filter="&quot;orientation&quot; IS NULL OR (&quot;orientation&quot; != 'parallel' AND &quot;orientation&quot; != 'diagonal' AND &quot;orientation&quot; != 'perpendicular')"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" clip_to_extent="1" type="line" name="0" alpha="1">
        <layer enabled="1" locked="0" class="HashLine" pass="0">
          <prop v="4" k="average_angle_length"/>
          <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
          <prop v="MM" k="average_angle_unit"/>
          <prop v="90" k="hash_angle"/>
          <prop v="4.4" k="hash_length"/>
          <prop v="3x:0,0,0,0,0,0" k="hash_length_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="hash_length_unit"/>
          <prop v="5.2" k="interval"/>
          <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="interval_unit"/>
          <prop v="0" k="offset"/>
          <prop v="2.2" k="offset_along_line"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_along_line_unit"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_unit"/>
          <prop v="interval" k="placement"/>
          <prop v="0" k="ring_filter"/>
          <prop v="1" k="rotate"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="offset">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;parking_source&quot;='separate_area' OR &quot;parking_source&quot;='separate_node',-1.1,if(&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder',1.1,if(&quot;parking&quot;='half_on_kerb',0,-1.1)))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@0@0" alpha="1">
            <layer enabled="1" locked="0" class="SimpleLine" pass="0">
              <prop v="0" k="align_dash_pattern"/>
              <prop v="flat" k="capstyle"/>
              <prop v="5;2" k="customdash"/>
              <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="customdash_unit"/>
              <prop v="0" k="dash_pattern_offset"/>
              <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
              <prop v="MM" k="dash_pattern_offset_unit"/>
              <prop v="0" k="draw_inside_polygon"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="31,12,173,255" k="line_color"/>
              <prop v="solid" k="line_style"/>
              <prop v="1.8" k="line_width"/>
              <prop v="RenderMetersInMapUnits" k="line_width_unit"/>
              <prop v="0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="offset_unit"/>
              <prop v="0" k="ring_filter"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="outlineColor">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                  </Option>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="line" name="1" alpha="1">
        <layer enabled="1" locked="0" class="HashLine" pass="0">
          <prop v="4" k="average_angle_length"/>
          <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
          <prop v="MM" k="average_angle_unit"/>
          <prop v="144" k="hash_angle"/>
          <prop v="4.4" k="hash_length"/>
          <prop v="3x:0,0,0,0,0,0" k="hash_length_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="hash_length_unit"/>
          <prop v="3.1" k="interval"/>
          <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="interval_unit"/>
          <prop v="0" k="offset"/>
          <prop v="3.1" k="offset_along_line"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_along_line_unit"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_unit"/>
          <prop v="interval" k="placement"/>
          <prop v="0" k="ring_filter"/>
          <prop v="1" k="rotate"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="lineAngle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;highway:oneway&quot;='yes' AND &quot;side&quot;='left',36,144)" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="offset">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;parking_source&quot;='separate_area' OR &quot;parking_source&quot;='separate_node',-2.2,if(&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder',2.2,if(&quot;parking&quot;='half_on_kerb',0,-2.2)))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@1@0" alpha="1">
            <layer enabled="1" locked="0" class="SimpleLine" pass="0">
              <prop v="0" k="align_dash_pattern"/>
              <prop v="flat" k="capstyle"/>
              <prop v="5;2" k="customdash"/>
              <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="customdash_unit"/>
              <prop v="0" k="dash_pattern_offset"/>
              <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
              <prop v="MM" k="dash_pattern_offset_unit"/>
              <prop v="0" k="draw_inside_polygon"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="31,12,173,255" k="line_color"/>
              <prop v="solid" k="line_style"/>
              <prop v="1.8" k="line_width"/>
              <prop v="RenderMetersInMapUnits" k="line_width_unit"/>
              <prop v="0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="offset_unit"/>
              <prop v="0" k="ring_filter"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="outlineColor">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                  </Option>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="line" name="2" alpha="1">
        <layer enabled="1" locked="0" class="HashLine" pass="0">
          <prop v="4" k="average_angle_length"/>
          <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
          <prop v="MM" k="average_angle_unit"/>
          <prop v="0" k="hash_angle"/>
          <prop v="4.4" k="hash_length"/>
          <prop v="3x:0,0,0,0,0,0" k="hash_length_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="hash_length_unit"/>
          <prop v="2.5" k="interval"/>
          <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="interval_unit"/>
          <prop v="0" k="offset"/>
          <prop v="1.1" k="offset_along_line"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_along_line_unit"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_unit"/>
          <prop v="interval" k="placement"/>
          <prop v="0" k="ring_filter"/>
          <prop v="1" k="rotate"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="offset">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;parking_source&quot;='separate_area' OR &quot;parking_source&quot;='separate_node',-2.2,if(&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder',2.2,if(&quot;parking&quot;='half_on_kerb',0,-2.2)))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@2@0" alpha="1">
            <layer enabled="1" locked="0" class="SimpleLine" pass="0">
              <prop v="0" k="align_dash_pattern"/>
              <prop v="flat" k="capstyle"/>
              <prop v="5;2" k="customdash"/>
              <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="customdash_unit"/>
              <prop v="0" k="dash_pattern_offset"/>
              <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
              <prop v="MM" k="dash_pattern_offset_unit"/>
              <prop v="0" k="draw_inside_polygon"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="31,12,173,255" k="line_color"/>
              <prop v="solid" k="line_style"/>
              <prop v="1.8" k="line_width"/>
              <prop v="RenderMetersInMapUnits" k="line_width_unit"/>
              <prop v="0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="RenderMetersInMapUnits" k="offset_unit"/>
              <prop v="0" k="ring_filter"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="outlineColor">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                  </Option>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="line" name="3" alpha="1">
        <layer enabled="1" locked="0" class="SimpleLine" pass="0">
          <prop v="0" k="align_dash_pattern"/>
          <prop v="flat" k="capstyle"/>
          <prop v="5;2" k="customdash"/>
          <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="customdash_unit"/>
          <prop v="0" k="dash_pattern_offset"/>
          <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
          <prop v="MM" k="dash_pattern_offset_unit"/>
          <prop v="0" k="draw_inside_polygon"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="31,12,173,255" k="line_color"/>
          <prop v="solid" k="line_style"/>
          <prop v="1.8" k="line_width"/>
          <prop v="RenderMetersInMapUnits" k="line_width_unit"/>
          <prop v="0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_unit"/>
          <prop v="0" k="ring_filter"/>
          <prop v="0" k="tweak_dash_pattern_on_corners"/>
          <prop v="0" k="use_custom_dash"/>
          <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="offset">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;parking_source&quot;='separate_area' OR &quot;parking_source&quot;='separate_node',-1.1,if(&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder',1.1,if(&quot;parking&quot;='half_on_kerb',0,-1.1)))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="outlineColor">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <customproperties>
    <property key="dualview/previewExpressions" value="&quot;highway:name&quot;"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory maxScaleDenominator="1e+8" width="15" penWidth="0" spacing="5" scaleBasedVisibility="0" enabled="0" spacingUnitScale="3x:0,0,0,0,0,0" showAxis="1" penAlpha="255" scaleDependency="Area" direction="0" sizeScale="3x:0,0,0,0,0,0" rotationOffset="270" backgroundAlpha="255" labelPlacementMethod="XHeight" lineSizeType="MM" lineSizeScale="3x:0,0,0,0,0,0" minScaleDenominator="0" opacity="1" height="15" sizeType="MM" penColor="#000000" minimumSize="0" diagramOrientation="Up" barWidth="5" spacingUnit="MM" backgroundColor="#ffffff">
      <fontProperties style="" description="Cantarell,11,-1,5,50,0,0,0,0,0"/>
      <attribute label="" color="#000000" field=""/>
      <axisSymbol>
        <symbol force_rhr="0" clip_to_extent="1" type="line" name="" alpha="1">
          <layer enabled="1" locked="0" class="SimpleLine" pass="0">
            <prop v="0" k="align_dash_pattern"/>
            <prop v="square" k="capstyle"/>
            <prop v="5;2" k="customdash"/>
            <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
            <prop v="MM" k="customdash_unit"/>
            <prop v="0" k="dash_pattern_offset"/>
            <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
            <prop v="MM" k="dash_pattern_offset_unit"/>
            <prop v="0" k="draw_inside_polygon"/>
            <prop v="bevel" k="joinstyle"/>
            <prop v="35,35,35,255" k="line_color"/>
            <prop v="solid" k="line_style"/>
            <prop v="0.26" k="line_width"/>
            <prop v="MM" k="line_width_unit"/>
            <prop v="0" k="offset"/>
            <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
            <prop v="MM" k="offset_unit"/>
            <prop v="0" k="ring_filter"/>
            <prop v="0" k="tweak_dash_pattern_on_corners"/>
            <prop v="0" k="use_custom_dash"/>
            <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings placement="2" zIndex="0" priority="0" showAll="1" linePlacementFlags="18" obstacle="0" dist="0">
    <properties>
      <Option type="Map">
        <Option type="QString" value="" name="name"/>
        <Option name="properties"/>
        <Option type="QString" value="collection" name="type"/>
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
    <field configurationFlags="None" name="highway:name">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="highway:oneway">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="highway:width_proc">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="highway:width_proc:effective">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking_source">
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
    <field configurationFlags="None" name="side">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="parking">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="orientation">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="capacity">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="source:capacity">
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
    <field configurationFlags="None" name="markings">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="width">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="offset">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="condition_class">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="vehicle_designated">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="vehicle_excluded">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="zone">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="layer">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id" name=""/>
    <alias index="1" field="highway" name=""/>
    <alias index="2" field="highway:name" name=""/>
    <alias index="3" field="highway:oneway" name=""/>
    <alias index="4" field="highway:width_proc" name=""/>
    <alias index="5" field="highway:width_proc:effective" name=""/>
    <alias index="6" field="parking_source" name=""/>
    <alias index="7" field="error_output" name=""/>
    <alias index="8" field="side" name=""/>
    <alias index="9" field="parking" name=""/>
    <alias index="10" field="orientation" name=""/>
    <alias index="11" field="capacity" name=""/>
    <alias index="12" field="source:capacity" name=""/>
    <alias index="13" field="surface" name=""/>
    <alias index="14" field="markings" name=""/>
    <alias index="15" field="width" name=""/>
    <alias index="16" field="offset" name=""/>
    <alias index="17" field="condition_class" name=""/>
    <alias index="18" field="vehicle_designated" name=""/>
    <alias index="19" field="vehicle_excluded" name=""/>
    <alias index="20" field="zone" name=""/>
    <alias index="21" field="layer" name=""/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="highway"/>
    <default applyOnUpdate="0" expression="" field="highway:name"/>
    <default applyOnUpdate="0" expression="" field="highway:oneway"/>
    <default applyOnUpdate="0" expression="" field="highway:width_proc"/>
    <default applyOnUpdate="0" expression="" field="highway:width_proc:effective"/>
    <default applyOnUpdate="0" expression="" field="parking_source"/>
    <default applyOnUpdate="0" expression="" field="error_output"/>
    <default applyOnUpdate="0" expression="" field="side"/>
    <default applyOnUpdate="0" expression="" field="parking"/>
    <default applyOnUpdate="0" expression="" field="orientation"/>
    <default applyOnUpdate="0" expression="" field="capacity"/>
    <default applyOnUpdate="0" expression="" field="source:capacity"/>
    <default applyOnUpdate="0" expression="" field="surface"/>
    <default applyOnUpdate="0" expression="" field="markings"/>
    <default applyOnUpdate="0" expression="" field="width"/>
    <default applyOnUpdate="0" expression="" field="offset"/>
    <default applyOnUpdate="0" expression="" field="condition_class"/>
    <default applyOnUpdate="0" expression="" field="vehicle_designated"/>
    <default applyOnUpdate="0" expression="" field="vehicle_excluded"/>
    <default applyOnUpdate="0" expression="" field="zone"/>
    <default applyOnUpdate="0" expression="" field="layer"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="0" field="id" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="highway" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="highway:name" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="highway:oneway" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="highway:width_proc" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="highway:width_proc:effective" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="parking_source" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="error_output" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="side" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="parking" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="orientation" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="capacity" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="source:capacity" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="surface" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="markings" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="width" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="offset" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="condition_class" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="vehicle_designated" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="vehicle_excluded" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="zone" constraints="0" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" field="layer" constraints="0" unique_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="id" desc=""/>
    <constraint exp="" field="highway" desc=""/>
    <constraint exp="" field="highway:name" desc=""/>
    <constraint exp="" field="highway:oneway" desc=""/>
    <constraint exp="" field="highway:width_proc" desc=""/>
    <constraint exp="" field="highway:width_proc:effective" desc=""/>
    <constraint exp="" field="parking_source" desc=""/>
    <constraint exp="" field="error_output" desc=""/>
    <constraint exp="" field="side" desc=""/>
    <constraint exp="" field="parking" desc=""/>
    <constraint exp="" field="orientation" desc=""/>
    <constraint exp="" field="capacity" desc=""/>
    <constraint exp="" field="source:capacity" desc=""/>
    <constraint exp="" field="surface" desc=""/>
    <constraint exp="" field="markings" desc=""/>
    <constraint exp="" field="width" desc=""/>
    <constraint exp="" field="offset" desc=""/>
    <constraint exp="" field="condition_class" desc=""/>
    <constraint exp="" field="vehicle_designated" desc=""/>
    <constraint exp="" field="vehicle_excluded" desc=""/>
    <constraint exp="" field="zone" desc=""/>
    <constraint exp="" field="layer" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{00000000-0000-0000-0000-000000000000}"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="&quot;condition_class&quot;" sortOrder="0">
    <columns>
      <column width="271" hidden="0" type="field" name="id"/>
      <column width="-1" hidden="0" type="field" name="highway"/>
      <column width="-1" hidden="0" type="field" name="highway:name"/>
      <column width="-1" hidden="0" type="field" name="error_output"/>
      <column width="-1" hidden="0" type="field" name="parking"/>
      <column width="-1" hidden="0" type="field" name="capacity"/>
      <column width="-1" hidden="0" type="field" name="width"/>
      <column width="-1" hidden="0" type="field" name="offset"/>
      <column width="-1" hidden="1" type="actions"/>
      <column width="-1" hidden="0" type="field" name="highway:width_proc"/>
      <column width="-1" hidden="0" type="field" name="highway:width_proc:effective"/>
      <column width="-1" hidden="0" type="field" name="orientation"/>
      <column width="-1" hidden="0" type="field" name="source:capacity"/>
      <column width="-1" hidden="0" type="field" name="layer"/>
      <column width="-1" hidden="0" type="field" name="side"/>
      <column width="-1" hidden="0" type="field" name="markings"/>
      <column width="258" hidden="0" type="field" name="condition_class"/>
      <column width="-1" hidden="0" type="field" name="vehicle_designated"/>
      <column width="-1" hidden="0" type="field" name="vehicle_excluded"/>
      <column width="-1" hidden="0" type="field" name="highway:oneway"/>
      <column width="-1" hidden="0" type="field" name="parking_source"/>
      <column width="-1" hidden="0" type="field" name="surface"/>
      <column width="-1" hidden="0" type="field" name="zone"/>
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
    <field name="access" editable="1"/>
    <field name="access:conditional" editable="1"/>
    <field name="capacity" editable="1"/>
    <field name="condition" editable="1"/>
    <field name="condition:other" editable="1"/>
    <field name="condition:other:time" editable="1"/>
    <field name="condition_class" editable="1"/>
    <field name="error_output" editable="1"/>
    <field name="fee" editable="1"/>
    <field name="fee:conditional" editable="1"/>
    <field name="highway" editable="1"/>
    <field name="highway:name" editable="1"/>
    <field name="highway:oneway" editable="1"/>
    <field name="highway:width" editable="1"/>
    <field name="highway:width:effective" editable="1"/>
    <field name="highway:width_proc" editable="1"/>
    <field name="highway:width_proc:effective" editable="1"/>
    <field name="id" editable="1"/>
    <field name="layer" editable="1"/>
    <field name="markings" editable="1"/>
    <field name="maxstay" editable="1"/>
    <field name="maxstay:conditional" editable="1"/>
    <field name="offset" editable="1"/>
    <field name="orientation" editable="1"/>
    <field name="parking" editable="1"/>
    <field name="parking_source" editable="1"/>
    <field name="path" editable="1"/>
    <field name="position" editable="1"/>
    <field name="restriction" editable="1"/>
    <field name="restriction:conditional" editable="1"/>
    <field name="side" editable="1"/>
    <field name="source:capacity" editable="1"/>
    <field name="surface" editable="1"/>
    <field name="vehicle_designated" editable="1"/>
    <field name="vehicle_excluded" editable="1"/>
    <field name="vehicles" editable="1"/>
    <field name="width" editable="1"/>
    <field name="zone" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="access" labelOnTop="0"/>
    <field name="access:conditional" labelOnTop="0"/>
    <field name="capacity" labelOnTop="0"/>
    <field name="condition" labelOnTop="0"/>
    <field name="condition:other" labelOnTop="0"/>
    <field name="condition:other:time" labelOnTop="0"/>
    <field name="condition_class" labelOnTop="0"/>
    <field name="error_output" labelOnTop="0"/>
    <field name="fee" labelOnTop="0"/>
    <field name="fee:conditional" labelOnTop="0"/>
    <field name="highway" labelOnTop="0"/>
    <field name="highway:name" labelOnTop="0"/>
    <field name="highway:oneway" labelOnTop="0"/>
    <field name="highway:width" labelOnTop="0"/>
    <field name="highway:width:effective" labelOnTop="0"/>
    <field name="highway:width_proc" labelOnTop="0"/>
    <field name="highway:width_proc:effective" labelOnTop="0"/>
    <field name="id" labelOnTop="0"/>
    <field name="layer" labelOnTop="0"/>
    <field name="markings" labelOnTop="0"/>
    <field name="maxstay" labelOnTop="0"/>
    <field name="maxstay:conditional" labelOnTop="0"/>
    <field name="offset" labelOnTop="0"/>
    <field name="orientation" labelOnTop="0"/>
    <field name="parking" labelOnTop="0"/>
    <field name="parking_source" labelOnTop="0"/>
    <field name="path" labelOnTop="0"/>
    <field name="position" labelOnTop="0"/>
    <field name="restriction" labelOnTop="0"/>
    <field name="restriction:conditional" labelOnTop="0"/>
    <field name="side" labelOnTop="0"/>
    <field name="source:capacity" labelOnTop="0"/>
    <field name="surface" labelOnTop="0"/>
    <field name="vehicle_designated" labelOnTop="0"/>
    <field name="vehicle_excluded" labelOnTop="0"/>
    <field name="vehicles" labelOnTop="0"/>
    <field name="width" labelOnTop="0"/>
    <field name="zone" labelOnTop="0"/>
  </labelOnTop>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"highway:name"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>
