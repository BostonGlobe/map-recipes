clean:

	rm -rf output/*;

setup: clean

	# Find elevation data and use it to make ramp.txt.
	gdalinfo -stats ~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif | grep Minimum;

shadedrelief:

	# Make shaded relief parts from Myanmar DEM.
	make listgeo slope hillshade color merge file='~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif';

listgeo:

	listgeo ${file} > output/meta.txt;

slope:

	gdaldem slope ${file} output/slope.tif -s 111120;
	gdaldem color-relief output/slope.tif slope.txt output/slopeshade.tif;

hillshade:	

	gdaldem hillshade ${file} output/hills.tif -s 111120;

color:

	gdaldem color-relief ${file} ramp.txt output/color.tif;

merge:

	cd output; \
		convert -gamma 0.5 hills.tif hills_gamma.tif; \
		convert \
			slopeshade.tif -compose multiply -alpha set -channel A -evaluate set 50% \
			color.tif \
			-layers flatten \
			slopeONcolor.tif; \
		convert slopeONcolor.tif hills_gamma.tif -compose Overlay -composite hillsONslopeONcolor.tif; \
		geotifcp -g meta.txt hillsONslopeONcolor.tif myanmar-bbox-shadedrelief.tif

cutColorToMyanmarBbox:

	gdalwarp -te 89.9998611 9.9998611 119.9998611 29.9998611 ~/Desktop/TEMP/Natural\ Earth/Raster/NE1_HR_LC/NE1_HR_LC.tif output/color.tif
