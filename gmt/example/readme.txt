These scripts mimic the behaviour of the 'gmt' package, with the input files
stored in a tmp directory. Take a look at either example.bat or example.sh:

Like gmt()     we first decide on a filename and parameter settings
 "   pscoast() we then draw the main map
 "   psxy()    we add circles of different sizes
 "   pstext()  we write text in various fonts
 "   psbar()   we draw equally high bars at different latitudes
 "   psclose() we finalize the map and remove history files

The main difference is that the 'gmt' package does not aggregate all commands in
a single shell script, but calls them one by one using the R function system().
