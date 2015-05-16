clean:

	rm -rf output/*;

option1_part1:

	# Translate source DEM to geotiff.
	gdal_translate -a_srs EPSG:4326 /Volumes/Gabriel\ Florit\ External\ HD/mapping/Natural\ Earth\ III/dem_large/16_bit_dem_large.tif output/16_bit_dem_large_translated.tif;

	# Make Myanmar shapefile.
	ogr2ogr -where 'admin="Myanmar"' output/myanmar.shp /Volumes/Gabriel\ Florit\ External\ HD/mapping/Natural\ Earth/Cultural/10m_cultural/ne_10m_admin_0_countries.shp;

	# Find Myanmar bounding box
	ogrinfo output/myanmar.shp myanmar | grep Extent > output/myanmar-bbox.txt;

option1_part2:

	# Make a Myanmar bbox DEM.
	gdalwarp -dstnodata 255 -te 92.174973 9.790717 101.173855 28.538466 output/16_bit_dem_large_translated.tif output/myanmar_dem.tif;

	# Find elevation data and use it to make ramp.txt.
	gdalinfo -stats output/myanmar_dem.tif | grep Minimum;

option1_part3:

	# Make shaded relief parts from Myanmar DEM.
	make listgeo slope hillshade color merge file='output/myanmar_dem.tif';

	# Cut the final relief using Myanmar shapefile.
	gdalwarp -cutline output/myanmar.shp -crop_to_cutline output/myanmar-bbox-shadedrelief.tif output/myanmar-shadedrelief.tif;

option2_part1: clean

	# Find elevation data and use it to make ramp.txt.
	gdalinfo -stats ~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif | grep Minimum;

option2_part2:

	# Make shaded relief parts from Myanmar DEM.
	make listgeo slope hillshade color merge file='~/Desktop/TEMP/GMTED/10N090E_20101117_gmted_mea300.tif';

	# Make Myanmar shapefile.
	ogr2ogr -where 'admin="Myanmar"' output/myanmar.shp ~/Desktop/TEMP/Natural\ Earth/Cultural/10m_cultural/ne_10m_admin_0_countries.shp;

	# Cut the final relief using Myanmar shapefile.
	gdalwarp -cutline output/myanmar.shp -crop_to_cutline output/myanmar-bbox-shadedrelief.tif output/myanmar-shadedrelief.tif;


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


other:










# 	# first step: find the bounding box of myanmar
# 	# make echo_elevation listgeo slope hillshade color file='~/Desktop/mapping/GMTED/10N090E_20101117_gmted_mea300.tif';


# 		# cd output; \
# 		# convert -gamma 0.5 hills.tif hills_gamma.tif; \
# 		# convert -gamma 1 slopeshade.tif slopeshade_gamma.tif; \
# 		# convert color.tif hills_gamma.tif -compose Overlay -composite output_temp.tif; \
# 		# convert output_temp.tif slopeshade_gamma.tif -compose linear-burn -composite output.tif; \
# 		# geotifcp -g meta.txt output.tif output-merged.tif;


# # we are going to go take a Natural Earth III low-res DEM and translate itsetup_1: clean

	# # Translate source DEM to geotiff.
	# gdal_translate -a_srs EPSG:4326 /Volumes/Gabriel\ Florit\ External\ HD/mapping/Natural\ Earth\ III/dem_large/16_bit_dem_large.tif output/16_bit_dem_large_translated.tif;

	# # Make Myanmar shapefile.
	# ogr2ogr -where 'admin="Myanmar"' output/myanmar.shp /Volumes/Gabriel\ Florit\ External\ HD/mapping/Natural\ Earth/Cultural/10m_cultural/ne_10m_admin_0_countries.shp;

	# # OPTION 1:
	# # Use Myanmar shapefile to make a Myanmar DEM.
	# gdalwarp -cutline output/myanmar.shp -crop_to_cutline output/16_bit_dem_large_translated.tif output/myanmar_dem.tif

	# # Find elevation data and use it to make ramp.txt.
	# gdalinfo -stats output/myanmar_dem.tif | grep Minimum;

