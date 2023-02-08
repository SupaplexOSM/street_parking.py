<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyAlgorithm="0" simplifyDrawingTol="1" styleCategories="AllStyleCategories" maxScale="0" simplifyLocal="1" labelsEnabled="0" simplifyMaxScale="1" readOnly="0" simplifyDrawingHints="1" version="3.16.3-Hannover" hasScaleBasedVisibilityFlag="0" minScale="100000000">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal durationField="" enabled="0" startExpression="" endField="" durationUnit="min" fixedDuration="0" mode="0" startField="" endExpression="" accumulate="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 symbollevels="0" enableorderby="0" type="RuleRenderer" forceraster="0">
    <rules key="{f239a9bc-0df2-429a-b75b-d4c5a8b54fb2}">
      <rule symbol="0" filter="&quot;orientation&quot; = 'parallel'" key="{b1467406-b271-4092-9e3d-f2ab7e482a1a}" label="parallel"/>
      <rule symbol="1" filter="&quot;orientation&quot; = 'diagonal'" key="{5c76d1fb-af22-40b3-9d42-5aef9ff15e29}" label="diagonal"/>
      <rule symbol="2" filter="&quot;orientation&quot; = 'perpendicular'" key="{a2b2a5ef-6aa8-4008-80d0-9a31b875a146}" label="perpendicular"/>
      <rule symbol="3" filter="&quot;orientation&quot; IS NULL OR (&quot;orientation&quot; != 'parallel' AND &quot;orientation&quot; != 'diagonal' AND &quot;orientation&quot; != 'perpendicular')" key="{06f609bf-725a-4978-8e06-fd75433f3e98}" label="unknown"/>
    </rules>
    <symbols>
      <symbol name="0" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
        <layer locked="0" enabled="1" pass="0" class="HashLine">
          <prop k="average_angle_length" v="4"/>
          <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="average_angle_unit" v="MM"/>
          <prop k="hash_angle" v="90"/>
          <prop k="hash_length" v="4.4"/>
          <prop k="hash_length_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="hash_length_unit" v="RenderMetersInMapUnits"/>
          <prop k="interval" v="5.2"/>
          <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="interval_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset" v="0"/>
          <prop k="offset_along_line" v="2.2"/>
          <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_along_line_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="RenderMetersInMapUnits"/>
          <prop k="placement" v="interval"/>
          <prop k="ring_filter" v="0"/>
          <prop k="rotate" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="offset" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if((&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder') AND NOT &quot;parking_source&quot;='separate_area',1.1,if(&quot;parking&quot;='half_on_kerb',0,-1.1))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol name="@0@0" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
            <layer locked="0" enabled="1" pass="0" class="SimpleLine">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="flat"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="RenderMetersInMapUnits"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="31,12,173,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="1.8"/>
              <prop k="line_width_unit" v="RenderMetersInMapUnits"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="RenderMetersInMapUnits"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="outlineColor" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol name="1" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
        <layer locked="0" enabled="1" pass="0" class="HashLine">
          <prop k="average_angle_length" v="4"/>
          <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="average_angle_unit" v="MM"/>
          <prop k="hash_angle" v="144"/>
          <prop k="hash_length" v="4.4"/>
          <prop k="hash_length_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="hash_length_unit" v="RenderMetersInMapUnits"/>
          <prop k="interval" v="3.1"/>
          <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="interval_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset" v="0"/>
          <prop k="offset_along_line" v="3.1"/>
          <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_along_line_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="RenderMetersInMapUnits"/>
          <prop k="placement" v="interval"/>
          <prop k="ring_filter" v="0"/>
          <prop k="rotate" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="lineAngle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if(&quot;highway:oneway&quot;='yes' AND &quot;side&quot;='left',36,144)"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="offset" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if((&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder') AND NOT &quot;parking_source&quot;='separate_area',2.2,if(&quot;parking&quot;='half_on_kerb',0,-2.2))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol name="@1@0" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
            <layer locked="0" enabled="1" pass="0" class="SimpleLine">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="flat"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="RenderMetersInMapUnits"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="31,12,173,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="1.8"/>
              <prop k="line_width_unit" v="RenderMetersInMapUnits"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="RenderMetersInMapUnits"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="outlineColor" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol name="2" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
        <layer locked="0" enabled="1" pass="0" class="HashLine">
          <prop k="average_angle_length" v="4"/>
          <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="average_angle_unit" v="MM"/>
          <prop k="hash_angle" v="0"/>
          <prop k="hash_length" v="4.4"/>
          <prop k="hash_length_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="hash_length_unit" v="RenderMetersInMapUnits"/>
          <prop k="interval" v="2.5"/>
          <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="interval_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset" v="0"/>
          <prop k="offset_along_line" v="1.1"/>
          <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_along_line_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="RenderMetersInMapUnits"/>
          <prop k="placement" v="interval"/>
          <prop k="ring_filter" v="0"/>
          <prop k="rotate" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="offset" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if((&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder') AND NOT &quot;parking_source&quot;='separate_area',2.2,if(&quot;parking&quot;='half_on_kerb',0,-2.2))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol name="@2@0" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
            <layer locked="0" enabled="1" pass="0" class="SimpleLine">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="flat"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="RenderMetersInMapUnits"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="31,12,173,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="1.8"/>
              <prop k="line_width_unit" v="RenderMetersInMapUnits"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="RenderMetersInMapUnits"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="outlineColor" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol name="3" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
        <layer locked="0" enabled="1" pass="0" class="SimpleLine">
          <prop k="align_dash_pattern" v="0"/>
          <prop k="capstyle" v="flat"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="RenderMetersInMapUnits"/>
          <prop k="dash_pattern_offset" v="0"/>
          <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="dash_pattern_offset_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="31,12,173,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="1.8"/>
          <prop k="line_width_unit" v="RenderMetersInMapUnits"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="RenderMetersInMapUnits"/>
          <prop k="ring_filter" v="0"/>
          <prop k="tweak_dash_pattern_on_corners" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="offset" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if(&quot;parking_source&quot;='separate_area' OR &quot;parking_source&quot;='separate_node',-1.1,if(&quot;parking&quot;='on_kerb' OR &quot;parking&quot;='street_side' OR &quot;parking&quot;='shoulder',1.1,if(&quot;parking&quot;='half_on_kerb',0,-1.1)))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="outlineColor" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="if(&quot;condition_class&quot; ILIKE '%mixed%' OR &quot;condition_class&quot; ILIKE '%residents%' OR &quot;condition_class&quot; ILIKE '%paid%','#ad0c89',if(&quot;condition_class&quot; ILIKE '%time_limited%','#c60ccd',if(&quot;condition_class&quot; ILIKE '%loading%' OR &quot;condition_class&quot; ILIKE '%charging%' OR &quot;condition_class&quot; ILIKE '%access_restriction%' OR &quot;condition_class&quot; ILIKE '%disabled%' OR &quot;condition_class&quot; ILIKE '%car_sharing%','#707070',if(&quot;condition_class&quot; ILIKE '%no_parking%','#a099d7',if(&quot;condition_class&quot; ILIKE '%taxi%','#ffb000','#1f0cad')))))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
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
    <DiagramCategory opacity="1" lineSizeType="MM" minScaleDenominator="0" penAlpha="255" sizeScale="3x:0,0,0,0,0,0" spacingUnit="MM" spacing="5" rotationOffset="270" maxScaleDenominator="1e+8" penColor="#000000" barWidth="5" showAxis="1" scaleDependency="Area" sizeType="MM" direction="0" minimumSize="0" labelPlacementMethod="XHeight" lineSizeScale="3x:0,0,0,0,0,0" diagramOrientation="Up" enabled="0" spacingUnitScale="3x:0,0,0,0,0,0" backgroundColor="#ffffff" height="15" backgroundAlpha="255" penWidth="0" width="15" scaleBasedVisibility="0">
      <fontProperties style="" description="Cantarell,11,-1,5,50,0,0,0,0,0"/>
      <attribute color="#000000" field="" label=""/>
      <axisSymbol>
        <symbol name="" clip_to_extent="1" force_rhr="0" type="line" alpha="1">
          <layer locked="0" enabled="1" pass="0" class="SimpleLine">
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
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings obstacle="0" linePlacementFlags="18" showAll="1" placement="2" priority="0" dist="0" zIndex="0">
    <properties>
      <Option type="Map">
        <Option name="name" type="QString" value=""/>
        <Option name="properties"/>
        <Option name="type" type="QString" value="collection"/>
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
    <field name="id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="highway" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="highway:name" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="highway:oneway" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="parking_source" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="error_output" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="side" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="parking" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="orientation" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="capacity" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="source:capacity" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="surface" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="markings" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="markings:type" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="width" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="condition_class" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="vehicle_designated" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="vehicle_excluded" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="zone" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="offset" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="highway" name="" index="1"/>
    <alias field="highway:name" name="" index="2"/>
    <alias field="highway:oneway" name="" index="3"/>
    <alias field="parking_source" name="" index="4"/>
    <alias field="error_output" name="" index="5"/>
    <alias field="side" name="" index="6"/>
    <alias field="parking" name="" index="7"/>
    <alias field="orientation" name="" index="8"/>
    <alias field="capacity" name="" index="9"/>
    <alias field="source:capacity" name="" index="10"/>
    <alias field="surface" name="" index="11"/>
    <alias field="markings" name="" index="12"/>
    <alias field="markings:type" name="" index="13"/>
    <alias field="width" name="" index="14"/>
    <alias field="condition_class" name="" index="15"/>
    <alias field="vehicle_designated" name="" index="16"/>
    <alias field="vehicle_excluded" name="" index="17"/>
    <alias field="zone" name="" index="18"/>
    <alias field="offset" name="" index="19"/>
  </aliases>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="highway" expression="" applyOnUpdate="0"/>
    <default field="highway:name" expression="" applyOnUpdate="0"/>
    <default field="highway:oneway" expression="" applyOnUpdate="0"/>
    <default field="parking_source" expression="" applyOnUpdate="0"/>
    <default field="error_output" expression="" applyOnUpdate="0"/>
    <default field="side" expression="" applyOnUpdate="0"/>
    <default field="parking" expression="" applyOnUpdate="0"/>
    <default field="orientation" expression="" applyOnUpdate="0"/>
    <default field="capacity" expression="" applyOnUpdate="0"/>
    <default field="source:capacity" expression="" applyOnUpdate="0"/>
    <default field="surface" expression="" applyOnUpdate="0"/>
    <default field="markings" expression="" applyOnUpdate="0"/>
    <default field="markings:type" expression="" applyOnUpdate="0"/>
    <default field="width" expression="" applyOnUpdate="0"/>
    <default field="condition_class" expression="" applyOnUpdate="0"/>
    <default field="vehicle_designated" expression="" applyOnUpdate="0"/>
    <default field="vehicle_excluded" expression="" applyOnUpdate="0"/>
    <default field="zone" expression="" applyOnUpdate="0"/>
    <default field="offset" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="highway" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="highway:name" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="highway:oneway" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="parking_source" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="error_output" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="side" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="parking" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="orientation" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="capacity" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="source:capacity" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="surface" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="markings" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="markings:type" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="width" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="condition_class" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="vehicle_designated" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="vehicle_excluded" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="zone" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
    <constraint field="offset" notnull_strength="0" exp_strength="0" unique_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" exp="" desc=""/>
    <constraint field="highway" exp="" desc=""/>
    <constraint field="highway:name" exp="" desc=""/>
    <constraint field="highway:oneway" exp="" desc=""/>
    <constraint field="parking_source" exp="" desc=""/>
    <constraint field="error_output" exp="" desc=""/>
    <constraint field="side" exp="" desc=""/>
    <constraint field="parking" exp="" desc=""/>
    <constraint field="orientation" exp="" desc=""/>
    <constraint field="capacity" exp="" desc=""/>
    <constraint field="source:capacity" exp="" desc=""/>
    <constraint field="surface" exp="" desc=""/>
    <constraint field="markings" exp="" desc=""/>
    <constraint field="markings:type" exp="" desc=""/>
    <constraint field="width" exp="" desc=""/>
    <constraint field="condition_class" exp="" desc=""/>
    <constraint field="vehicle_designated" exp="" desc=""/>
    <constraint field="vehicle_excluded" exp="" desc=""/>
    <constraint field="zone" exp="" desc=""/>
    <constraint field="offset" exp="" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{00000000-0000-0000-0000-000000000000}"/>
  </attributeactions>
  <attributetableconfig sortOrder="0" actionWidgetStyle="dropDown" sortExpression="&quot;condition_class&quot;">
    <columns>
      <column width="271" name="id" type="field" hidden="0"/>
      <column width="-1" name="highway" type="field" hidden="0"/>
      <column width="-1" name="highway:name" type="field" hidden="0"/>
      <column width="-1" name="error_output" type="field" hidden="0"/>
      <column width="-1" name="parking" type="field" hidden="0"/>
      <column width="-1" name="capacity" type="field" hidden="0"/>
      <column width="-1" name="width" type="field" hidden="0"/>
      <column width="-1" name="offset" type="field" hidden="0"/>
      <column width="-1" type="actions" hidden="1"/>
      <column width="-1" name="orientation" type="field" hidden="0"/>
      <column width="-1" name="source:capacity" type="field" hidden="0"/>
      <column width="-1" name="side" type="field" hidden="0"/>
      <column width="-1" name="markings" type="field" hidden="0"/>
      <column width="258" name="condition_class" type="field" hidden="0"/>
      <column width="-1" name="vehicle_designated" type="field" hidden="0"/>
      <column width="-1" name="vehicle_excluded" type="field" hidden="0"/>
      <column width="-1" name="highway:oneway" type="field" hidden="0"/>
      <column width="-1" name="parking_source" type="field" hidden="0"/>
      <column width="-1" name="surface" type="field" hidden="0"/>
      <column width="-1" name="zone" type="field" hidden="0"/>
      <column width="-1" name="markings:type" type="field" hidden="0"/>
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
    <field name="markings:type" editable="1"/>
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
    <field labelOnTop="0" name="access"/>
    <field labelOnTop="0" name="access:conditional"/>
    <field labelOnTop="0" name="capacity"/>
    <field labelOnTop="0" name="condition"/>
    <field labelOnTop="0" name="condition:other"/>
    <field labelOnTop="0" name="condition:other:time"/>
    <field labelOnTop="0" name="condition_class"/>
    <field labelOnTop="0" name="error_output"/>
    <field labelOnTop="0" name="fee"/>
    <field labelOnTop="0" name="fee:conditional"/>
    <field labelOnTop="0" name="highway"/>
    <field labelOnTop="0" name="highway:name"/>
    <field labelOnTop="0" name="highway:oneway"/>
    <field labelOnTop="0" name="highway:width"/>
    <field labelOnTop="0" name="highway:width:effective"/>
    <field labelOnTop="0" name="highway:width_proc"/>
    <field labelOnTop="0" name="highway:width_proc:effective"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="layer"/>
    <field labelOnTop="0" name="markings"/>
    <field labelOnTop="0" name="markings:type"/>
    <field labelOnTop="0" name="maxstay"/>
    <field labelOnTop="0" name="maxstay:conditional"/>
    <field labelOnTop="0" name="offset"/>
    <field labelOnTop="0" name="orientation"/>
    <field labelOnTop="0" name="parking"/>
    <field labelOnTop="0" name="parking_source"/>
    <field labelOnTop="0" name="path"/>
    <field labelOnTop="0" name="position"/>
    <field labelOnTop="0" name="restriction"/>
    <field labelOnTop="0" name="restriction:conditional"/>
    <field labelOnTop="0" name="side"/>
    <field labelOnTop="0" name="source:capacity"/>
    <field labelOnTop="0" name="surface"/>
    <field labelOnTop="0" name="vehicle_designated"/>
    <field labelOnTop="0" name="vehicle_excluded"/>
    <field labelOnTop="0" name="vehicles"/>
    <field labelOnTop="0" name="width"/>
    <field labelOnTop="0" name="zone"/>
  </labelOnTop>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"highway:name"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>
