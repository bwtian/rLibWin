

data( fujitopo)

data(japmap)
###data(ETOPO5)


######  set a location for the origin:
PLOC=list(LON=range(fujitopo$lon), x=range(fujitopo$lon),
  LAT=range(fujitopo$lat), y=range(fujitopo$lat))


####  set the projection
PROJ = setPROJ(type=2, LAT0=mean(PLOC$y) , LON0=mean(PLOC$x) )

########  all of Japan
plotGEOmapXY(japmap, PROJ=PROJ, add=FALSE)


readline("Hit Return>")

###  limited around Mt. Fuji

plotGEOmapXY(japmap, PROJ=PROJ, LIM=c(PLOC$LON[1], PLOC$LAT[1],PLOC$LON[2], PLOC$LAT[2] ) , add=FALSE)

readline("Hit Return>")

#########   set the color scheme for the perspective plot
calcol = settopocol()

###############  get a subset of the ETOPO5 data

data(ETOPO5)


ZZ2 = subsetTOPO(ETOPO5, PLOC)

####  dim(ZZ2$z)


 image(ZZ2$x,ZZ2$y, ZZ2$z[ , rev(1:(dim(ZZ2$z)[2]))],  col=topo.colors(100), asp=TRUE , axes=FALSE, xlab="", ylab="" )


readline("Hit Return>")

####  create X-Y matrix for interpolation
G = setplotmat(ZZ2$x,ZZ2$y)



XY = GLOB.XY(rep(ZZ2$y[1], length(ZZ2$x)), ZZ2$x, PROJ)
XYs = GLOB.XY(ZZ2$y,rep(ZZ2$x[1], length(ZZ2$y)),  PROJ)

############  plot image, projected
image(XY$x, XYs$y, ZZ2$z[ , rev(1:(dim(ZZ2$z)[2]))],  col=topo.colors(100), asp=TRUE , axes=FALSE, xlab="", ylab="" )

########   add map data:
plotGEOmapXY(japmap, PROJ=PROJ, LIM=c(PLOC$LON[1], PLOC$LAT[1],PLOC$LON[2], PLOC$LAT[2] ) , add=TRUE)

readline("Hit Return>")
############   make a nice perspective plot of Mt. Fuji region....


##   PMAT = GEOpersp(japmap, jtop  ,calcol=calcol$calcol)
PMAT =GEOTOPO(ETOPO5, PLOC, PROJ, calcol$calcol)


plotGEOmapXY(japmap, PROJ=PROJ, LIM=c(PLOC$LON[1], PLOC$LAT[1],PLOC$LON[2], PLOC$LAT[2] ) , PMAT=PMAT$PMAT , add=TRUE)


