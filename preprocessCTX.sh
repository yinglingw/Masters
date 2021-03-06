#! /bin/bash

ctx_list=$(ls *.IMG | sed -e 's/\..*$//')

echo
echo ----- Images to be processed -----

for f in $ctx_list;
do
	echo $f
done

echo ----------------------------------
echo

for ctx_image in $ctx_list;
do 
	echo Processing file: $ctx_image.IMG

	echo " $" mroctx2isis from=$ctx_image.IMG to=$ctx_image.output.cub
	mroctx2isis from=$ctx_image.IMG to=$ctx_image.cub

	wait
	echo " $" spiceinit from=$ctx_image.input.cub
	spiceinit from=$ctx_image.cub

	wait
	echo " $" ctxcal from=$ctx_image.cub to=$ctx_image.cal.cub
	ctxcal from=$ctx_image.cub to=$ctx_image.cal.cub

	wait
	echo " $" ctxevenodd from=$ctx_image.cal.cub to=$ctx_image.eo.cal.cub
	ctxevenodd from=$ctx_image.cal.cub to=$ctx_image.eo.cal.cub
	
	wait
	echo " $" cam2map from=$ctx_image.eo.cal.cub to=$ctx_image.map.cub matchmap=no pixres=CAMERA defaultrange=MINIMIZE
	cam2map from=$ctx_image.eo.cal.cub to=$ctx_image.map.cub matchmap=no pixres=CAMERA defaultrange=MINIMIZE

	wait
	echo " $" gdal_translate -ot Float32 -of GTiff -co bigtiff=if_safer $ctx_image.map.cub $ctx_image.final.tif
	gdal_translate -ot Float32 -of GTiff -co bigtiff=if_safer $ctx_image.map.cub $ctx_image.final.tif

	rm $ctx_image.cub
	rm $ctx_image.cal.cub
	rm $ctx_image.eo.cal.cub
	rm $ctx_image.map.cub

	echo
	echo

done

exit 0

