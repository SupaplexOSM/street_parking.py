<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" simplifyAlgorithm="0" simplifyDrawingTol="1" simplifyDrawingHints="0" simplifyLocal="1" labelsEnabled="0" simplifyMaxScale="1" readOnly="0" version="3.16.3-Hannover" minScale="100000000">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal durationUnit="min" startExpression="" endExpression="" startField="" durationField="" accumulate="0" mode="0" enabled="0" fixedDuration="0" endField="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 forceraster="0" enableorderby="0" type="singleSymbol" symbollevels="0">
    <symbols>
      <symbol clip_to_extent="1" type="marker" force_rhr="0" name="0" alpha="1">
        <layer locked="0" pass="0" class="SimpleMarker" enabled="1">
          <prop v="0" k="angle"/>
          <prop v="31,12,173,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="no" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="RenderMetersInMapUnits" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="fillColor">
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
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <customproperties>
    <property value="false" key="OnConvertFormatRegeneratePrimaryKey"/>
    <property key="dualview/previewExpressions">
      <value>"highway:name"</value>
    </property>
    <property value="0" key="embeddedWidgets/count"/>
    <property key="variableNames"/>
    <property key="variableValues"/>
  </customproperties>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer attributeLegend="1" diagramType="Histogram">
    <DiagramCategory sizeType="MM" backgroundAlpha="255" labelPlacementMethod="XHeight" backgroundColor="#ffffff" scaleDependency="Area" penColor="#000000" penWidth="0" minimumSize="0" direction="0" lineSizeType="MM" barWidth="5" spacing="5" spacingUnitScale="3x:0,0,0,0,0,0" width="15" sizeScale="3x:0,0,0,0,0,0" penAlpha="255" spacingUnit="MM" maxScaleDenominator="1e+8" diagramOrientation="Up" minScaleDenominator="0" height="15" showAxis="1" enabled="0" lineSizeScale="3x:0,0,0,0,0,0" opacity="1" scaleBasedVisibility="0" rotationOffset="270">
      <fontProperties description="Cantarell,11,-1,5,50,0,0,0,0,0" style=""/>
      <axisSymbol>
        <symbol clip_to_extent="1" type="line" force_rhr="0" name="" alpha="1">
          <layer locked="0" pass="0" class="SimpleLine" enabled="1">
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
  <DiagramLayerSettings placement="0" zIndex="0" priority="0" obstacle="0" dist="0" showAll="1" linePlacementFlags="18">
    <properties>
      <Option type="Map">
        <Option type="QString" value="" name="name"/>
        <Option name="properties"/>
        <Option type="QString" value="collection" name="type"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
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
    <field configurationFlags="None" name="offset">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="angle">
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
    <alias index="4" field="parking_source" name=""/>
    <alias index="5" field="error_output" name=""/>
    <alias index="6" field="side" name=""/>
    <alias index="7" field="parking" name=""/>
    <alias index="8" field="orientation" name=""/>
    <alias index="9" field="surface" name=""/>
    <alias index="10" field="markings" name=""/>
    <alias index="11" field="width" name=""/>
    <alias index="12" field="condition_class" name=""/>
    <alias index="13" field="vehicle_designated" name=""/>
    <alias index="14" field="vehicle_excluded" name=""/>
    <alias index="15" field="zone" name=""/>
    <alias index="16" field="offset" name=""/>
    <alias index="17" field="angle" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="highway" applyOnUpdate="0"/>
    <default expression="" field="highway:name" applyOnUpdate="0"/>
    <default expression="" field="highway:oneway" applyOnUpdate="0"/>
    <default expression="" field="parking_source" applyOnUpdate="0"/>
    <default expression="" field="error_output" applyOnUpdate="0"/>
    <default expression="" field="side" applyOnUpdate="0"/>
    <default expression="" field="parking" applyOnUpdate="0"/>
    <default expression="" field="orientation" applyOnUpdate="0"/>
    <default expression="" field="surface" applyOnUpdate="0"/>
    <default expression="" field="markings" applyOnUpdate="0"/>
    <default expression="" field="width" applyOnUpdate="0"/>
    <default expression="" field="condition_class" applyOnUpdate="0"/>
    <default expression="" field="vehicle_designated" applyOnUpdate="0"/>
    <default expression="" field="vehicle_excluded" applyOnUpdate="0"/>
    <default expression="" field="zone" applyOnUpdate="0"/>
    <default expression="" field="offset" applyOnUpdate="0"/>
    <default expression="" field="angle" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint unique_strength="0" field="id" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="highway" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="highway:name" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="highway:oneway" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="parking_source" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="error_output" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="side" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="parking" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="orientation" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="surface" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="markings" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="width" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="condition_class" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="vehicle_designated" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="vehicle_excluded" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="zone" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="offset" constraints="0" notnull_strength="0" exp_strength="0"/>
    <constraint unique_strength="0" field="angle" constraints="0" notnull_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="highway" exp=""/>
    <constraint desc="" field="highway:name" exp=""/>
    <constraint desc="" field="highway:oneway" exp=""/>
    <constraint desc="" field="parking_source" exp=""/>
    <constraint desc="" field="error_output" exp=""/>
    <constraint desc="" field="side" exp=""/>
    <constraint desc="" field="parking" exp=""/>
    <constraint desc="" field="orientation" exp=""/>
    <constraint desc="" field="surface" exp=""/>
    <constraint desc="" field="markings" exp=""/>
    <constraint desc="" field="width" exp=""/>
    <constraint desc="" field="condition_class" exp=""/>
    <constraint desc="" field="vehicle_designated" exp=""/>
    <constraint desc="" field="vehicle_excluded" exp=""/>
    <constraint desc="" field="zone" exp=""/>
    <constraint desc="" field="offset" exp=""/>
    <constraint desc="" field="angle" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig sortOrder="0" actionWidgetStyle="dropDown" sortExpression="">
    <columns>
      <column type="field" name="id" hidden="0" width="-1"/>
      <column type="field" name="highway" hidden="0" width="-1"/>
      <column type="field" name="highway:name" hidden="0" width="-1"/>
      <column type="field" name="highway:oneway" hidden="0" width="-1"/>
      <column type="field" name="parking_source" hidden="0" width="-1"/>
      <column type="field" name="error_output" hidden="0" width="-1"/>
      <column type="field" name="side" hidden="0" width="-1"/>
      <column type="field" name="parking" hidden="0" width="-1"/>
      <column type="field" name="orientation" hidden="0" width="-1"/>
      <column type="field" name="surface" hidden="0" width="-1"/>
      <column type="field" name="markings" hidden="0" width="-1"/>
      <column type="field" name="width" hidden="0" width="-1"/>
      <column type="field" name="condition_class" hidden="0" width="-1"/>
      <column type="field" name="vehicle_designated" hidden="0" width="-1"/>
      <column type="field" name="vehicle_excluded" hidden="0" width="-1"/>
      <column type="field" name="zone" hidden="0" width="-1"/>
      <column type="field" name="offset" hidden="0" width="-1"/>
      <column type="field" name="angle" hidden="0" width="-1"/>
      <column type="actions" hidden="1" width="-1"/>
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
    <field editable="1" name="angle"/>
    <field editable="1" name="condition_class"/>
    <field editable="1" name="error_output"/>
    <field editable="1" name="highway"/>
    <field editable="1" name="highway:name"/>
    <field editable="1" name="highway:oneway"/>
    <field editable="1" name="id"/>
    <field editable="1" name="markings"/>
    <field editable="1" name="offset"/>
    <field editable="1" name="orientation"/>
    <field editable="1" name="parking"/>
    <field editable="1" name="parking_source"/>
    <field editable="1" name="side"/>
    <field editable="1" name="surface"/>
    <field editable="1" name="vehicle_designated"/>
    <field editable="1" name="vehicle_excluded"/>
    <field editable="1" name="width"/>
    <field editable="1" name="zone"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="angle"/>
    <field labelOnTop="0" name="condition_class"/>
    <field labelOnTop="0" name="error_output"/>
    <field labelOnTop="0" name="highway"/>
    <field labelOnTop="0" name="highway:name"/>
    <field labelOnTop="0" name="highway:oneway"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="markings"/>
    <field labelOnTop="0" name="offset"/>
    <field labelOnTop="0" name="orientation"/>
    <field labelOnTop="0" name="parking"/>
    <field labelOnTop="0" name="parking_source"/>
    <field labelOnTop="0" name="side"/>
    <field labelOnTop="0" name="surface"/>
    <field labelOnTop="0" name="vehicle_designated"/>
    <field labelOnTop="0" name="vehicle_excluded"/>
    <field labelOnTop="0" name="width"/>
    <field labelOnTop="0" name="zone"/>
  </labelOnTop>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"highway:name"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>
