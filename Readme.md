# How to make Myanmar shaded relief

## Requirements

## Steps

### First, make the country shapefile.

- `ogr2ogr -where 'admin="Myanmar"' output/myanmar.shp /Volumes/Gabriel\ Florit\ External\ HD/mapping/Natural\ Earth/Cultural/10m_cultural/ne_10m_admin_0_countries.shp`

### Use the country shapefile to made a country DEM.

- `gdalwarp -cutline output/myanmar.shp ~/Desktop/TEMP/Natural\ Earth\ III/dem_large/16_bit_dem_large_translated.tif output/myanmar_dem.tif`



























### Next, find the country's bounding box and save it to `extent.txt`.

- `ogrinfo myanmar.shp myanmar | grep Extent > extent.txt`

