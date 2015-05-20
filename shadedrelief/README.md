# shadedrelief

This generates a shaded relief `.tif` from a DEM and a color raster.

## Instructions

- `make shadedrelief DEM=my-dem.tif COLOR_RASTER=my-color-raster.tif`

## Example

We're going to make a shaded relief of southeast asia (Myanmar). We'll use the GMTED2010 viewer, at http://topotools.cr.usgs.gov/gmted_viewer/viewer.htm. Click around until you find the desired tile and download the appropriate resolution. For our purposes, 30 arc-sec will do.

Next we need a color raster. Natural Earth has many excellent rasters - see http://www.naturalearthdata.com/downloads/10m-raster-data/10m-natural-earth-1/. We'll choose Natural Earth I (with no added shaded relief).

Once we have both files, run the following command:

- `make shadedrelief DEM=10N090E_20101117_gmted_mea300.tif COLOR_RASTER=NE1_HR_LC/NE1_HR_LC.tif`

This will generate an output directory full of various intermediate tifs, including the final composite: `shadedrelief.tif`. Enjoy!
