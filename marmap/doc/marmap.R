### R code from vignette source 'marmap.Rnw'

###################################################
### code chunk number 1: marmap.Rnw:21-26
###################################################
options(width=60,continue="  ")
options(SweaveHooks=list(fig=function()
              par(mar=c(5.1, 4.1, 1.1, 2.1))))
library(marmap)
marmap::read.bathy('png.xyz', header=F, sep="\t") -> papoue


###################################################
### code chunk number 2: marmap.Rnw:45-49 (eval = FALSE)
###################################################
## library(marmap)
## getNOAA.bathy(lon1 = 140, lon2 = 155, lat1 = -13, lat2 = 0, 
## 	resolution = 10) -> papoue
## summary(papoue)


###################################################
### code chunk number 3: marmap.Rnw:52-53
###################################################
summary(papoue)


###################################################
### code chunk number 4: marmap.Rnw:62-63
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(papoue)


###################################################
### code chunk number 5: marmap.Rnw:68-70
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(papoue, image = TRUE)
scaleBathy(papoue, deg = 2, x = "bottomleft", inset = 5)


###################################################
### code chunk number 6: marmap.Rnw:75-78
###################################################
getOption("SweaveHooks")[["fig"]]()
colorRampPalette(c("red","purple","blue","cadetblue1",
	"white")) -> blues
plot(papoue, image = TRUE, bpal = blues(100))


###################################################
### code chunk number 7: marmap.Rnw:83-88
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(papoue, image = TRUE, bpal = blues(100),
	deep = c(-9000, -3000, 0), shallow = c(-3000, -10, 0),
	step = c(1000, 1000, 0), lwd = c(0.8, 0.8, 1),
	col = c("lightgrey", "darkgrey", "black"),
	lty = c(1, 1, 1), drawlabel = c(FALSE, FALSE, FALSE))


###################################################
### code chunk number 8: marmap.Rnw:95-96
###################################################
get.transect(papoue, 151, -6, 153, -7, distance = TRUE)


###################################################
### code chunk number 9: marmap.Rnw:102-105
###################################################
getOption("SweaveHooks")[["fig"]]()
get.transect(papoue, 151, -6, 153, -7, 
	distance = TRUE) -> transect
plotProfile(transect)


###################################################
### code chunk number 10: marmap.Rnw:123-134
###################################################
x = c(142.1390, 142.9593, 144.0466, 145.9141,
      145.9372, 146.0115, 145.9141, 146.8589,
      146.6651, 147.1772, 147.2856, 152.7475,
      152.5025, 152.7816, 152.9010, 153.2314)
y = c(-2.972065, -3.209449, -3.391399, -4.675720,
      -4.914153, -5.130116, -5.329641, -2.587792,
      -2.897221, -3.250368, -2.720080, -6.005769,
      -6.211152, -6.326915, -5.990206, -6.023344)

paste("station",1:16, sep = "") -> station
data.frame(x, y, station) -> sampling


###################################################
### code chunk number 11: marmap.Rnw:139-151
###################################################
getOption("SweaveHooks")[["fig"]]()
head(sampling) # a preview of the first 6 lines of the dataset. 

plot(papoue, image = TRUE, bpal = blues(100),
	deep = c(-9000, -3000, 0), shallow = c(-3000, -10, 0),
	step = c(1000, 1000, 0), lwd = c(0.8, 0.8, 1),
	col = c("lightgrey", "darkgrey", "black"),
	lty = c(1, 1, 1), drawlabel = c(FALSE, FALSE, FALSE))

# add points from the sampling.csv, and add text to the plot:
points(sampling$x, sampling$y, pch = 21, col = "black", 
	bg = "yellow", cex = 1.3)
text(152, -7.2, "New Britain\nTrench", col = "white", font = 3)


###################################################
### code chunk number 12: marmap.Rnw:169-194
###################################################
getOption("SweaveHooks")[["fig"]]()
# make a table of fake sampling information, with fake depth
samp.depth = sample(seq(-3000, -1000, by = 50), size = 16)
data.frame(sampling$x, sampling$y, samp.depth) -> sp
names(sp) <- c("lon", "lat", "depth")
head(sp)

# plot map
par(mai=c(1,1,1,1.5))
plot(papoue, deep = c(-4500, 0), shallow = c(-50, 0), step = c(500, 0), 
	lwd = c(0.3, 1), lty = c(1, 1), col = c("grey", "black"),
	drawlabels = c(FALSE, FALSE))	
scaleBathy(papoue, deg = 3, x = "bottomleft", inset = 5)

# set color palette	
max(-sp$depth, na.rm = TRUE) -> mx
colorRampPalette(c("white", "lightyellow", "lightgreen", 
	"blue", "lightblue1", "purple")) -> ramp
blues <- ramp(mx)

# plot points and color depth scale	
points(sp[,1:2], col = "black", bg = blues[-sp$depth], 
	pch = 21, cex = 1.5)
library(shape)
colorlegend(zlim = c(mx, 0), col = rev(blues), main = "depth (m)",
	posx = c(0.85, 0.88))


###################################################
### code chunk number 13: marmap.Rnw:199-204
###################################################
data(hawaii)
get.area(hawaii, level.inf = -4000, level.sup = -1000) -> bathyal
get.area(hawaii, level.inf = min(hawaii), level.sup = -4000) -> abyssal
round(bathyal$Square.Km, 0) -> ba
round(abyssal$Square.Km, 0) -> ab


###################################################
### code chunk number 14: marmap.Rnw:209-218
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(hawaii, lwd = 0.2)
image(bathyal$Lon, bathyal$Lat, bathyal$Area, 
	col = c("transparent", rgb(0.7, 0, 0, 0.3)), add = TRUE)
image(abyssal$Lon, abyssal$Lat, abyssal$Area, 
	col = c("transparent", rgb(0.7, 0.7, 0.3, 0.3)), add = TRUE)
legend("bottomleft", 
	legend = c(paste("bathyal:", ba, "km2"), 
	paste("abyssal:", ab, "km2")), 
	fill = c(rgb(0.7, 0, 0, 0.3), rgb(0.7, 0.7, 0, 0.3)))


###################################################
### code chunk number 15: marmap.Rnw:225-228
###################################################
data(hawaii, hawaii.sites)
sites <- hawaii.sites[-c(1,4),]
rownames(sites) <- 1:4


###################################################
### code chunk number 16: marmap.Rnw:336-344
###################################################
getOption("SweaveHooks")[["fig"]]()
data(nw.atlantic) ; atl <- as.bathy(nw.atlantic)
plot(atl, xlim = c(-70, -52), 
	deep = c(-5000, 0), shallow = c(0, 0), step = c(1000, 0), 
	col = c("lightgrey", "black"), lwd = c(0.8, 1), 
	lty = c(1, 1), draw = c(FALSE, FALSE))
        
get.box(atl, x1 = -68.6, x2 = -53.7, y1 = 42.4, y2 = 32.5, 
	width = 3, col = "red") -> out


###################################################
### code chunk number 17: marmap.Rnw:346-352
###################################################
getOption("SweaveHooks")[["fig"]]()
library(lattice)             
wireframe(out, shade = TRUE, zoom = 1.1,
	aspect = c(1/4, 0.1), 
	screen = list(z = -60, x = -55), 
	par.settings = list(axis.line = list(col = "transparent")),
	par.box = c(col = rgb(0, 0, 0, 0.1)))


###################################################
### code chunk number 18: marmap.Rnw:450-453
###################################################
library(marmap)
read.bathy('png.xyz', header = FALSE, sep = "\t") -> papoue
summary(papoue)


###################################################
### code chunk number 19: marmap.Rnw:464-466
###################################################
require(RSQLite)
setSQL(bathy = "png.xyz", sep = "\t")


###################################################
### code chunk number 20: marmap.Rnw:471-474
###################################################
subsetSQL(min_lon = 145, max_lon = 150,
	 min_lat = -2, max_lat = 0) -> test
summary(test)


###################################################
### code chunk number 21: marmap.Rnw:479-480
###################################################
system("rm bathy_db")


