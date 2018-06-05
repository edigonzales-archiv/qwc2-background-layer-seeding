<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="2.18.17" minimumScale="150000" maximumScale="4e+06" hasScaleBasedVisibilityFlag="1">
  <pipe>
    <rasterrenderer gradient="BlackToWhite" opacity="1" alphaBand="0" type="singlebandgray" grayBand="1">
      <rasterTransparency/>
      <contrastEnhancement>
        <minValue>121</minValue>
        <maxValue>210</maxValue>
        <algorithm>StretchToMinimumMaximum</algorithm>
      </contrastEnhancement>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation colorizeGreen="128" colorizeOn="0" colorizeRed="255" colorizeBlue="128" grayscaleMode="0" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="8" zoomedOutResampler="bilinear" zoomedInResampler="bilinear"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
