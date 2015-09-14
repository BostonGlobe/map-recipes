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

	rm -rf output;
	mkdir output;

	# create slope.txt
	echo '0 255 255 255\n90 0 0 0' > output/slope.txt;

# save DEM bounding box for later
listgeo:

	listgeo ${DEM} > output/meta.txt;

# create slopeshade from DEM
slope:

	gdaldem slope ${DEM} output/slope.tif -s 111120;
	gdaldem color-relief output/slope.tif output/slope.txt output/slopeshade.tif;

# create hillshade from DEM
hillshade:

	gdaldem hillshade ${DEM} output/hills.tif -s 111120;

# cut raster to fit DEM bounding box
cutRasterToDEM:

	gdalwarp -te ${DEM_BBOX_LOWER_LEFT} ${DEM_BBOX_UPPER_RIGHT} ${COLOR_RASTER} output/color.tif;

# use imagemagick to stitch all the tiffs together
merge:

	# cd output; \
	# 	convert color.tif -resize ${DEM_SIZE} color_resized.tif; \
	# 	convert -gamma 0.5 hills.tif hills_gamma.tif; \
	# 	convert \
	# 		slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 40% \
	# 		color_resized.tif \
	# 		-layers flatten \
	# 		slopeONcolor.tif; \
	# 	convert slopeONcolor.tif hills_gamma.tif -compose Overlay -composite hillsONslopeONcolor.tif; \
	# 	geotifcp -g meta.txt hillsONslopeONcolor.tif shadedrelief.tif

	convert output/color.tif -resize ${DEM_SIZE} output/color_resized.tif; \
	convert -gamma 0.5 output/hills.tif output/hills_gamma.tif; \
	convert \
		output/slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 40% \
		output/color_resized.tif \
		-layers flatten \
		output/slopeONcolor.tif; \
	convert output/slopeONcolor.tif output/hills_gamma.tif -compose Overlay -composite output/hillsONslopeONcolor.tif; \
	geotifcp -g output/meta.txt output/hillsONslopeONcolor.tif output/shadedrelief.tif

shadedrelief: init_variables clean listgeo slope hillshade cutRasterToDEM merge

