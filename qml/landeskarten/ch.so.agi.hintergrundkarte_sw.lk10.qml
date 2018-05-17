<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="2.18.19" minimumScale="5000" maximumScale="10000" hasScaleBasedVisibilityFlag="1">
  <pipe>
    <rasterrenderer gradient="BlackToWhite" opacity="1" alphaBand="2" type="singlebandgray" grayBand="1">
      <rasterTransparency/>
      <contrastEnhancement>
        <minValue>0</minValue>
        <maxValue>255</maxValue>
        <algorithm>StretchToMinimumMaximum</algorithm>
      </contrastEnhancement>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0"/>
    <huesaturation colorizeGreen="128" colorizeOn="0" colorizeRed="255" colorizeBlue="128" grayscaleMode="0" saturation="0" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2" zoomedOutResampler="bilinear"/>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
