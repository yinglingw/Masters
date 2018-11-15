#! /bin/bash

mola_list=$(ls m*.lbl | sed -e 's/\..*$//')

echo
echo ----- Images to be processed -----

for f in $mola_list;
do
	echo $f
done

echo ----------------------------------
echo

for mola_image in $mola_list;
do 
	echo Processing file: $mola_image
	
	echo " $" pds2isis from=$mola_image.LBL to=$mola_image.cub
	pds2isis from=$mola_image.LBL to=$mola_image.cub

	echo
	echo

done

exit 0

