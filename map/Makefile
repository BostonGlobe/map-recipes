# steps:
# clean the output folder
# since we're using natural earth I raster for color, we only need hillshade and slopeshade, which we'll get from GMTED
# so first, we'll make hillshade and slopeshade from GMTED
#
#
#

GMTED=~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif

BBOX_LOWER_LEFT=$$(listgeo -d $(GMTED) | grep "Lower Left" | sed 's/Lower Left//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')

BBOX_UPPER_RIGHT=$$(listgeo -d ~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif | grep "Upper Right" | sed 's/Upper Right//' | sed 's/,/ /' | sed 's/(//' | sed 's/)//')

init:

	@echo $(GMTED)
	
# HELLO = world
# HELLO_WORLD = $$(HELLO) world!

# # This echoes "world world!"
# echo $(HELLO_WORLD)

# HELLO = hello

# # This echoes "hello world!"
# echo $(HELLO_WORLD)
	@echo ${BBOX_LOWER_LEFT}
	@echo ${BBOX_UPPER_RIGHT}

all: init clean

	# Make hillshade and slopeshade from GMTED.
	make listgeo slope hillshade file='~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif';

	# Cut Natural Earth I raster to GMTED bounding box.
	gdalwarp -te ${BBOX_LOWER_LEFT} ${BBOX_UPPER_RIGHT} ~/Desktop/TEMP/Natural\ Earth/Raster/NE1_HR_LC/NE1_HR_LC.tif output/color.tif;

clean:

	rm -rf output/*;

# setup: clean

# 	# Find elevation data and use it to make ramp.txt.
# 	igdalinfo -stats ~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif | grep Minimum;

# shadedrelief:

# 	# Make shaded relief parts from Myanmar DEM.
# 	make listgeo slope hillshade color merge file='~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif';

# listgeo:

# 	listgeo ${file} > output/meta.txt;

# slope:

# 	gdaldem slope ${file} output/slope.tif -s 111120;
# 	gdaldem color-relief output/slope.tif slope.txt output/slopeshade.tif;

# hillshade:	

# 	gdaldem hillshade ${file} output/hills.tif -s 111120;

# color:

# 	gdaldem color-relief ${file} ramp.txt output/color.tif;

# merge:

# 	cd output; \
# 		convert -gamma 0.5 hills.tif hills_gamma.tif; \
# 		convert \
# 			slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 50% \
# 			color.tif \
# 			-layers flatten \
# 			slopeONcolor.tif; \
# 		convert slopeONcolor.tif hills_gamma.tif -compose Overlay -composite hillsONslopeONcolor.tif; \
# 		geotifcp -g meta.txt hillsONslopeONcolor.tif myanmar-bbox-shadedrelief.tif

# cutColorToMyanmarBbox:

# 	gdalwarp -te 89.9998611 9.9998611 119.9998611 29.9998611 ~/Desktop/TEMP/Natural\ Earth/Raster/NE1_HR_LC/NE1_HR_LC.tif output/color.tif

