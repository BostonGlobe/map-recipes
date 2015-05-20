# filepaths of DEM and rasters. You can use any DEM and raster.
DEM=~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif
COLOR_RASTER=~/Desktop/TEMP/Natural\ Earth/Raster/NE1_HR_LC/NE1_HR_LC.tif

# e.g. 3200x1600
DEM_SIZE=$$(identify -format "%wx%h" $(DEM))

# e.g. 42.15 90.27
DEM_BBOX_LOWER_LEFT=$$(listgeo -d $(DEM) | grep "Lower Left" | sed 's/Lower Left//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')

# e.g. 44.15 92.27
DEM_BBOX_UPPER_RIGHT=$$(listgeo -d $(DEM) | grep "Upper Right" | sed 's/Upper Right//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')

# this forces make to compute the properties on the first pass.
init_variables:

	@echo ${DEM_BBOX_LOWER_LEFT}
	@echo ${DEM_BBOX_UPPER_RIGHT}
	@echo ${DEM_SIZE}

# clean out directory contents
clean:

	rm -rf output/*;

# save DEM bounding box for later
listgeo:

	listgeo ${DEM} > output/meta.txt;

# create slopeshade from DEM
slope:

	gdaldem slope ${DEM} output/slope.tif -s 111120;
	gdaldem color-relief output/slope.tif slope.txt output/slopeshade.tif;

# create hillshade from DEM
hillshade:

	gdaldem hillshade ${DEM} output/hills.tif -s 111120;

# cut raster to fit DEM bounding box
cutRasterToDEM:

	gdalwarp -te ${DEM_BBOX_LOWER_LEFT} ${DEM_BBOX_UPPER_RIGHT} ${COLOR_RASTER} output/color.tif;

# use imagemagick to stitch all the tiffs together
merge:

	cd output; \
		convert color.tif -resize ${DEM_SIZE} color_resized.tif; \
		convert -gamma 0.5 hills.tif hills_gamma.tif; \
		convert \
			slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 40% \
			color_resized.tif \
			-layers flatten \
			slopeONcolor.tif; \
		convert slopeONcolor.tif hills_gamma.tif -compose Overlay -composite hillsONslopeONcolor.tif; \
		geotifcp -g meta.txt hillsONslopeONcolor.tif shadedrelief.tif

all: init_variables clean listgeo slope hillshade cutRasterToDEM merge
