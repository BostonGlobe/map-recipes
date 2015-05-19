GMTED=~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif
GMTED_SIZE=$$(identify -format "%wx%h" $(GMTED))
NATURAL_EARTH=~/Desktop/TEMP/Natural\ Earth/Raster/NE1_HR_LC/NE1_HR_LC.tif 
BBOX_LOWER_LEFT=$$(listgeo -d $(GMTED) | grep "Lower Left" | sed 's/Lower Left//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')
BBOX_UPPER_RIGHT=$$(listgeo -d $(GMTED) | grep "Upper Right" | sed 's/Upper Right//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')

init_variables:

	@echo ${BBOX_LOWER_LEFT}
	@echo ${BBOX_UPPER_RIGHT}
	@echo ${GMTED_SIZE}

all: init_variables clean

	# Make hillshade and slopeshade from GMTED.
	make listgeo slope hillshade file=$(GMTED);

	# Cut Natural Earth I raster to GMTED bounding box.
	gdalwarp -te ${BBOX_LOWER_LEFT} ${BBOX_UPPER_RIGHT} ${NATURAL_EARTH} output/color.tif;

	# Merge all tifs.
	make merge;

clean:

	rm -rf output/*;

listgeo:

	listgeo ${file} > output/meta.txt;

slope:

	gdaldem slope ${file} output/slope.tif -s 111120;
	gdaldem color-relief output/slope.tif slope.txt output/slopeshade.tif;

hillshade:	

	gdaldem hillshade ${file} output/hills.tif -s 111120;

merge:

	cd output; \
		convert color.tif -resize ${GMTED_SIZE} color_resized.tif; \
		convert -gamma 0.5 hills.tif hills_gamma.tif; \
		convert \
			slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 40% \
			color_resized.tif \
			-layers flatten \
			slopeONcolor.tif; \
		convert slopeONcolor.tif hills_gamma.tif -compose Overlay -composite hillsONslopeONcolor.tif; \
		geotifcp -g meta.txt hillsONslopeONcolor.tif shadedrelief.tif
