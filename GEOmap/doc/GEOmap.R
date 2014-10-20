### R code from vignette source 'GEOmap.Rnw'
### Encoding: ASCII

###################################################
### code chunk number 1: GEOmap.Rnw:94-100
###################################################
library(GEOmap)
options(continue = " ")

kliuLL = c(56.056000,   160.640000)
PROJ =GEOmap::setPROJ(type=2, LAT0=kliuLL[1], 	LON0= kliuLL[2] , 	LATS=NULL, LONS=NULL, DLAT=NULL, DLON=NULL, FN =0)



###################################################
### code chunk number 2: GEOmap.Rnw:109-110
###################################################
 GEOmap::projtype()


###################################################
### code chunk number 3: GEOmap.Rnw:117-120
###################################################
require('geomapdata')
data(kammap)
GEOmap::plotGEOmap(kammap,  add=FALSE, asp=1)


###################################################
### code chunk number 4: GEOmap.Rnw:124-125
###################################################
GEOmap::plotGEOmapXY(kammap,  PROJ=PROJ, add=FALSE, xlab="km", ylab="km")


###################################################
### code chunk number 5: GEOmap.Rnw:199-217
###################################################

  data(cosomap)
     data(faults)
     data(hiways)
     data(owens)
data(cosogeol)
## cosocolnumbers = cosogeol$STROKES$col+1

 proj = cosomap$PROJ
 GEOmap::plotGEOmapXY(cosomap, PROJ=proj,  add=FALSE, ann=FALSE, axes=FALSE)
  
cosogeol = GEOmap::boundGEOmap(cosogeol)
  GEOmap::plotGEOmapXY(cosogeol, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  
  GEOmap::plotGEOmapXY(cosomap, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  
  GEOmap::plotGEOmapXY(faults, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  


###################################################
### code chunk number 6: GEOmap.Rnw:223-234
###################################################

XMCOL = RPMG::setXMCOL()

cosocolnumbers = 1:length(cosogeol$STROKES$col)

newcol = XMCOL[cosogeol$STROKES$col]

cosocolnums = cosogeol$STROKES$col
 
cosogeol$STROKES$col = newcol



###################################################
### code chunk number 7: GEOmap.Rnw:238-272
###################################################
ss = strsplit(cosogeol$STROKES$nam, split="_")     

geo = unlist(sapply(ss  , "[[", 1))
UGEO = unique(geo)

mgeo = match( geo, UGEO )

cosogeol = GEOmap::boundGEOmap(cosogeol)

gcol = paste(sep=".", geo, cosogeol$STROKES$col)


ucol = unique(gcol)


spucol = strsplit(ucol,split="\\.")     
N = length(spucol)

       
names = unlist(sapply(spucol  , "[[", 1))

shades = unlist(sapply(spucol  , FUN="[[", 2))

ORDN = order(names)
 GEOmap::plotGEOmapXY(cosomap, PROJ=proj,  add=FALSE, ann=FALSE, axes=FALSE)
  
  GEOmap::plotGEOmapXY(cosogeol, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  

  GEOmap::plotGEOmapXY(cosomap, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  
  GEOmap::plotGEOmapXY(faults, PROJ=proj,  add=TRUE, ann=FALSE, axes=FALSE)
  GEOmap::geoLEGEND(names[ORDN], shades[ORDN], .28, .14, 16, 6)



###################################################
### code chunk number 8: GEOmap.Rnw:291-296
###################################################
jvolcs = scan(file="Volc_points.LLZ", what=list(name="", lat=0, lon=0, h=0), sep=" ")
stas = scan(file="newFUJIstation.LLZ", what=list(name="", lat=0, lon=0, h=0), sep=" ")
eqs = scan(file="japan.eng", what=list(lon=0, lat=0, z=0, m=0))




###################################################
### code chunk number 9: GEOmap.Rnw:306-310
###################################################

ifuji = grep("FUJI", jvolcs$name)
PROJ = GEOmap::setPROJ(type=2, LAT0=jvolcs$lat[ifuji] , LON0=jvolcs$lon[ifuji] )



###################################################
### code chunk number 10: GEOmap.Rnw:324-327
###################################################
LL = GEOmap::XY.GLOB(c(-150, 150), c(-150,150), PROJ =PROJ)
FUJIAREA = c(LL$lon[1], LL$lat[1], LL$lon[2], LL$lat[2])



###################################################
### code chunk number 11: GEOmap.Rnw:336-352
###################################################
require("geomapdata")

data("japmap", package="geomapdata")

GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, xlab="km", ylab="km" )
GEOmap::pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)

rect(-150, -150, 150,150)

pctexp = 0.01

RLON = GEOmap::expandbound( range(RPMG::fmod(japmap$POINTS$lon, 360)), pctexp) 
      RLAT = GEOmap::expandbound( range(japmap$POINTS$lat), pctexp) 
      JAPLIM=c( RLON[1], RLAT[1], RLON[2] , RLAT[2] )




###################################################
### code chunk number 12: GEOmap.Rnw:358-363
###################################################

GEOmap::plotGEOmapXY(japmap,  LIM =FUJIAREA, PROJ=PROJ, xlab="km", ylab="km" )
GEOmap::pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)
GEOmap::textGEOmapXY(jvolcs$lat, jvolcs$lon , PROJ=PROJ, labels = jvolcs$name, cex=.5, pos=3)



###################################################
### code chunk number 13: GEOmap.Rnw:379-380
###################################################
print(japmap$STROKES$code)


###################################################
### code chunk number 14: GEOmap.Rnw:387-394
###################################################

isel = which( japmap$STROKES$code != "i" )
GEOmap::plotGEOmapXY(japmap,  LIM =FUJIAREA, PROJ=PROJ, SEL=isel, xlab="km", ylab="km" )
GEOmap::pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)
GEOmap::textGEOmapXY(jvolcs$lat, jvolcs$lon , PROJ=PROJ, labels = jvolcs$name, cex=.5, pos=3)




###################################################
### code chunk number 15: GEOmap.Rnw:413-414
###################################################
plates = scan(file="Plates.gmt", what="", sep="\n")


###################################################
### code chunk number 16: GEOmap.Rnw:423-428
###################################################

g = grep("^>", plates)
plates[g[1:10]]




###################################################
### code chunk number 17: GEOmap.Rnw:433-470
###################################################


PLATES = list(STROKES=list(nam=NULL, num=NULL, index=NULL, col=NULL, style=NULL, code=NULL), 
POINTS=list(lat=NULL, lon=NULL))


K = 0
for(i in 1:length(g))
  {
i1 = g[i]+1
i2 = g[i+1]-1
if(i == length(g)) i2 = length(plates) 
LONLAT = as.numeric(unlist( strsplit( plates[i1:i2], split=" ") ))
lon = LONLAT[seq(from=1, to=length(LONLAT), by=2)]
lat = LONLAT[seq(from=2, to=length(LONLAT), by=2)]

PLATES$POINTS$lat = c(PLATES$POINTS$lat, lat)
PLATES$POINTS$lon = c(PLATES$POINTS$lon, lon)

PLATES$STROKES$nam = c(PLATES$STROKES$nam, paste("PLATE", i, sep="") )
PLATES$STROKES$num = c(PLATES$STROKES$num, length(lat) )
PLATES$STROKES$index = c(PLATES$STROKES$index, K)
PLATES$STROKES$col = c(PLATES$STROKES$col, "blue")
PLATES$STROKES$style = c(PLATES$STROKES$style, 2)
PLATES$STROKES$code  = c(PLATES$STROKES$code, "p")

K = K+length(lat)


  }


PLATES$POINTS$lon = RPMG::fmod(PLATES$POINTS$lon, 360)
PLATES = GEOmap::boundGEOmap(PLATES, NEGLON =FALSE)

PLATES$PROJ = PROJ



###################################################
### code chunk number 18: GEOmap.Rnw:472-477
###################################################
data(worldmap)

GEOmap::plotGEOmap(worldmap, asp=1)
GEOmap::plotGEOmap(PLATES, add=TRUE)



###################################################
### code chunk number 19: GEOmap.Rnw:482-490
###################################################


GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="km", ylab="km" )
GEOmap::pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)
GEOmap::pointsGEOmapXY(eqs$lat,eqs$lon, PROJ=PROJ, col='green', pch=".", cex=2)

GEOmap::plotGEOmapXY(PLATES, PROJ=PROJ, LIM=JAPLIM,  add=TRUE)



###################################################
### code chunk number 20: GEOmap.Rnw:499-509
###################################################

rcol = rainbow(120)

ecol = 1+floor( 99* (eqs$z-min(eqs$z))/(max(eqs$z)-min(eqs$z)) )

GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="km", ylab="km" )
##  pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)
GEOmap::pointsGEOmapXY(eqs$lat,eqs$lon, PROJ=PROJ,  pch=".", cex=2, col=rcol[ecol])
GEOmap::plotGEOmapXY(PLATES, PROJ=PROJ, , LIM=JAPLIM , add=TRUE)



###################################################
### code chunk number 21: GEOmap.Rnw:517-518
###################################################
print(sizelegend)


###################################################
### code chunk number 22: GEOmap.Rnw:523-565
###################################################

esiz = exp(eqs$m)

rsiz = RPMG::RESCALE(esiz, .4, 10, min(esiz), max(esiz))

GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="", ylab="", axes=FALSE )

##  pointsGEOmapXY(jvolcs$lat, jvolcs$lon, PROJ=PROJ, col='red', pch=2, cex=.5)
PLAT =  pretty(eqs$lat)
PLON =  pretty(eqs$lon)

 GEOmap::addLLXY(PLAT ,PLON , GRIDcol="black", LABS=0, BORDER=0 , PROJ=PROJ )

GEOmap::pointsGEOmapXY(eqs$lat,eqs$lon, PROJ=PROJ,  pch=rep(1, length(rsiz)) , cex=rsiz, col=rcol[ecol])
GEOmap::plotGEOmapXY(PLATES, PROJ=PROJ, LIM=JAPLIM,  add=TRUE)


RPMG::HOZscale(eqs$z, rcol[1:100] , units = "km depth", SIDE = 1, s1 = 0.5, s2 = 0.95)


##  location of zebra: zeb = locator(); DUMPLOC(zeb)

zeb=list()
zeb$x=c(458.266070479352,870.677297484252)
zeb$y=c(-129.768792704472,-12.2491966665725)



zebra(zeb$x[1],zeb$y[1], 500, 100, 60, lab="Km", cex=.6)


am = pretty(eqs$m)
am = am[am>min(eqs$m) & am<max(eqs$m) ]

em = exp(am)
se = RPMG::RESCALE(em, .4, 10, min(esiz), max(esiz))

GEOmap::sizelegend(se, am, pch=1)

GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="km", ylab="km", add=TRUE )

## plotGEOmapXY(worldmap,  PROJ=PROJ, add=TRUE )


###################################################
### code chunk number 23: GEOmap.Rnw:570-599
###################################################
EXY = GEOmap::GLOB.XY(eqs$lat,eqs$lon, PROJ)
PLAT =  pretty(eqs$lat)
PLON =  pretty(eqs$lon)


esiz = exp(eqs$m)

rsiz = RPMG::RESCALE(esiz, .04, .2, min(esiz), max(esiz))

###  plot with the larges events first so they do not
###  cover the smaller ones

ordsiz = order(rsiz, decreasing = TRUE)


acol=rcol[ecol]

GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="", ylab="", axes=FALSE )

 GEOmap::addLLXY(PLAT ,PLON , GRIDcol="black", LABS=0, BORDER=0 , PROJ=PROJ )

GEOmap::pgon(EXY$x[ordsiz],EXY$y[ordsiz], siz=rsiz[ordsiz], col=acol[ordsiz], border='black', startalph =60, K=5, lwd=.5, xpd=TRUE)


GEOmap::plotGEOmapXY(PLATES, PROJ=PROJ, LIM=JAPLIM, add=TRUE)
GEOmap::plotGEOmapXY(japmap,  PROJ=PROJ, SEL=isel, xlab="", ylab="", axes=FALSE, add=TRUE )
RPMG::HOZscale(eqs$z, rcol[1:100] , units = "km depth", SIDE = 1, s1 = 0.5, s2 = 0.95)

                 


###################################################
### code chunk number 24: GEOmap.Rnw:618-619
###################################################
GEOmap::GEOsymbols()


