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
	
	echo " $" mroctx2isis from=$ctx_image.IMG to=$ctx_image.cub
	mroctx2isis from=$ctx_image.IMG to=$ctx_image.cub

	echo " $" spiceinit from=$ctx_image.cub
	spiceinit from=$ctx_image.cub

	echo
	echo " $" cam2map from=$ctx_image.cub to=$ctx_image.map.cub
	cam2map from=$ctx_image.cub to=$ctx_image.map.cub

	echo
	echo

done

exit 0

