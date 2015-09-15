# shadedrelief

This generates a shaded relief `.tif` from a DEM and a color raster, like [![Mandalay](http://apps.bostonglobe.com/graphics/2015/05/myanmar/assets/img/map-mandalay.jpg)](http://apps.bostonglobe.com/graphics/2015/05/myanmar/part-1.html)

## Instructions

- `make shadedrelief DEM=my-dem.tif COLOR_RASTER=my-color-raster.tif`

## Example

We're going to make a shaded relief of southeast asia (Myanmar). We'll use the GMTED2010 viewer, at http://topotools.cr.usgs.gov/gmted_viewer/viewer.htm. Click around until you find the desired tile and download the appropriate resolution. For our purposes, 30 arc-sec will do.

Next we need a color raster. Natural Earth has many excellent rasters - see http://www.naturalearthdata.com/downloads/10m-raster-data/10m-natural-earth-1/. We'll choose Natural Earth I (with no added shaded relief).

Once we have both files, run the following command:

- `make shadedrelief DEM=10N090E_20101117_gmted_mea300.tif COLOR_RASTER=NE1_HR_LC.tif`

This will generate an output directory full of various intermediate tifs, including the final composite: `shadedrelief.tif`. Enjoy!

## Another example

We want to make a shaded relief of Europe and bits of Asia. We'll use Natural Earth III's [small grayscale DEM](http://www.shadedrelief.com/natural3/pages/extra.html), because it offers a lower resolution than others I found. Perhaps when I figure out how to decrease DEM resolutions this step will become deprecated.

Unfortunately that DEM doesn't come georeferenced. But we can fix that:

- `gdal_translate -of GTiff -a_srs EPSG:4326 -a_ullr -180 90 180 -90 dem.tif dem_georeferenced.tif`

Now we can run the above command. Notice that we're using Natural Earth's cross blended hypsometric tint:

- `make shadedrelief DEM=dem_georeferenced.tif COLOR_RASTER=HYP_LR.tif`

We're done: ![Shaded relief of Europe and East Asia](https://cloud.githubusercontent.com/assets/370976/9882652/c6e93c82-5ba3-11e5-9718-9ee987eb67f4.png)
