#####
This file accompanies the preprocessCTX.sh script.
November 2018 Will Yingling
wyinglin@uwo.ca
#####


Purpose of script:
	- To send the PDS CTX.img images through automatic ISIS processing for hands-off ease and 
	  to make them compatible with ArcGIS.

Under the hood:
	- the images are sent through 3 ISIS commands
		$ mroctx2isis  # reformat images
		$ spiceinit    # details orbiter conditions for projection system
		$ cam2map      # spatially projects images


To install globally:
	- put copy of this script in /usr/local/bin
	$ chmod a+x preprocessCTX.sh
	- go to any dir. type "preprocessCTX.sh" and it will run within that dir
	- Et voila



