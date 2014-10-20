## ----setOptions, message=FALSE-------------------------------------------
library(googleVis)
op <- options(gvis.plot.tag='chart')

## ----results='asis', eval=FALSE------------------------------------------
#  library(XML)
#  url = "http://en.wikipedia.org/wiki/ISO_3166-2:DE"
#  ISO_3166_2_DE <- readHTMLTable(url, stringsAsFactors = FALSE)[[1]]

## ----results='asis'------------------------------------------------------
library(spacetime)
data(air) # loads rural and DE_NUTS1
Tbl <- gvisTable(ISO_3166_2_DE, options=list(width=400))
plot(Tbl)

## ------------------------------------------------------------------------
DE_NUTS1$name = ISO_3166_2_DE[,2]
DE_NUTS1$name[2] = "Bayern"        # Not: "Bayern (Bavaria)"
DE_NUTS1$name[9] = "Niedersachsen" # Not: "Niedersachsen (Lower Saxony)"

## ----GeoMapExample, results='asis', tidy=FALSE---------------------------
library(googleVis)
M = gvisGeoMap(DE_NUTS1@data, locationvar = "name", numvar = "Shape_Area",
	options=list(region="DE"))
plot(M)

## ----results='asis'------------------------------------------------------
DE_NUTS1$code = ISO_3166_2_DE[,1]
M = gvisGeoMap(DE_NUTS1@data, locationvar = "code", numvar = "Shape_Area",
	options=list(region="DE"))
plot(M)

## ----results='asis'------------------------------------------------------
noBerlin = DE_NUTS1[ISO_3166_2_DE[,1] != "DE-BE",]
M = gvisGeoMap(noBerlin@data, locationvar = "code", numvar = "Shape_Area",
	options=list(region="DE"))
plot(M)

## ----results='asis'------------------------------------------------------
DE_NUTS1.years = STF(DE_NUTS1, as.Date(c("2008-01-01", "2009-01-01")))
agg = aggregate(rural[,"2008::2009"], DE_NUTS1.years, mean, na.rm=TRUE)
d = agg[,1]@data # select time step one, take attr table of resulting SpatialPolygonsDataFrame object
d$code = ISO_3166_2_DE[,1] # add region codes
M = gvisGeoMap(na.omit(d), locationvar = "code", numvar = "PM10",
	options=list(region="DE",height=350)) # drop NA values for Geo chart
Tbl <- gvisTable(d, options=list(height=380, width=200))
plot(gvisMerge(M, Tbl, horizontal=TRUE))

## ----results='asis'------------------------------------------------------
library(sp)
data("wind", package = "gstat")
wind.loc$y = as.numeric(char2dms(as.character(wind.loc[["Latitude"]])))
wind.loc$x = as.numeric(char2dms(as.character(wind.loc[["Longitude"]])))
wind.loc$yx = paste(wind.loc$y, wind.loc$x, sep=":")
m = round(apply(wind,2,mean), 3)
sd = round(apply(wind,2,sd), 3)
wind.loc$mean = m[match(wind.loc$Code, names(m))]
wind.loc$sd = sd[match(wind.loc$Code, names(sd))]
M <- gvisGeoChart(wind.loc, "yx", "mean", "sd", "Station",
	options = list(region = "IE"))
plot(M)

## ----results='asis'------------------------------------------------------
# select:
wind = wind[wind$year > 76,] # select three years, 1976-1978
time = ISOdate(wind$year+1900, wind$month, wind$day)
wind.stack = stack(wind[,4:15])
names(wind.stack) = c("wind_speed", "station")
wind.stack$time = rep(time, 12)
M = gvisAnnotatedTimeLine(wind.stack, "time", "wind_speed", "station",
	options = list(width = "1000px", height = "500px",
		zoomStartTime=time[length(time)-365], zoomEndTime=max(time)))
plot(M)

## ----results='asis'------------------------------------------------------
wind$time = time
M = gvisLineChart(wind[1:200,], "time", names(wind)[4:9])
plot(M)

## ----results='asis'------------------------------------------------------
wind$time = time
wind[4:5, 7:9] = NA
M = gvisLineChart(wind[1:10,], "time", names(wind)[4:9])
plot(M)

## ----results='asis'------------------------------------------------------
library(spacetime)
data(air)
d = as(rural[1:10,"2001"], "data.frame") # daily, 2001
M = gvisAnnotationChart(d, "time", "PM10", "sp.ID",
	options = list(width = "1000px", height = "500px"))
		# zoomStartTime=d$time[1], zoomEndTime=d$time[1]+365))
plot(M)

## ----MotionChartExample, results='asis', tidy=FALSE----------------------
data("Produc", package = "plm")
M <- gvisMotionChart(Produc, "state", "year")
plot(M)

## ----resetOptions--------------------------------------------------------
## Set options back to original options
options(op)

