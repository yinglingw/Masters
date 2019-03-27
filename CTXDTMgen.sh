#! /bin/bash

ctx_list=$(ls *.IMG | sed -e 's/\..*$//')

set -- $ctx_list

echo
echo ----- Images to be processed -----

for f in $ctx_list;
do
	echo $f
done

echo ----------------------------------
echo
echo Preprocessing...
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
	echo
	echo

done

echo ----------------------------------
echo
echo Generating DTM...
echo

echo " $" cam2map4stereo.py $1.eo.cal.cub $2.eo.cal.cub
cam2map4stereo.py $1.eo.cal.cub $2.eo.cal.cub

echo " $" parallel_stereo $1.map.cub $2.map.cub results/out
parallel_stereo $1.map.cub $2.map.cub results/out

echo " $" point2dem results/out-PC.tif
point2dem results/out-PC.tif

echo "Removing extra files"
rm $1.cub
rm $1.cal.cub
rm $1.eo.cal.cub
rm $1.map.cub

rm $2.cub
rm $2.cal.cub
rm $2.eo.cal.cub
rm $2.map.cub

echo Done!
echo ----------------------------------

exit 0

