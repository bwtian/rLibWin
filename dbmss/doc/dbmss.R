
## ----Declarations, echo=FALSE, include=FALSE-----------------------------
library(knitr)
# set global chunk options
opts_chunk$set(cache=TRUE, warning=FALSE, tidy=FALSE, fig.width=8, fig.height=6, out.width='0.7\\maxwidth')
par(mar=c(0,0,0,0))
library(dbmss)


## ----SimpleWmppp---------------------------------------------------------
Pattern <- wmppp(data.frame(X=runif(100), Y=runif(100)))
summary(Pattern)


## ----CSBIGS, echo=FALSE, results='hide'----------------------------------
load("CSBIGS.Rdata")
Category <- cut(Emergencies$M, quantile(Emergencies$M, c(0, 0.9, 1)),
   labels = c("Other", "Biggest"), include.lowest = TRUE)
X <- wmppp(data.frame(X=Emergencies$X, Y=Emergencies$Y, PointType=Category),
   win=Region)
X$window$units <- c("meter","meters")


## ----Toulouse, echo=FALSE, results='hide', fig.height=4, fig.width=6-----
load("CSBIGS.Rdata")
Category <- cut(Emergencies$M, quantile(Emergencies$M, c(0, 0.9, 1)),
   labels = c("Other", "Biggest"), include.lowest = TRUE)
X <- wmppp(data.frame(X=Emergencies$X, Y=Emergencies$Y, PointType=Category),
   win=Region)
X$window$units <- c("meter","meters")
X2 <- split(X)
marks(X2$Other) <- rep(1, X2$Other$n)
marks(X2$Biggest) <- rep(1, X2$Biggest$n)
par(mfrow=c(1,2), mar=c(0,0,0,0))  
plot(X2$Other, main="", maxsize=1)
text(514300,  1826800, "a")
plot(X2$Biggest, main="", maxsize=1)
text(514300,  1826800, "b")
par(mfrow=c(1,1))


## ----KdCode, eval=FALSE--------------------------------------------------
## load("CSBIGS.Rdata")
## Category <- cut(Emergencies$M, quantile(Emergencies$M, c(0, 0.9, 1)),
##    labels = c("Other", "Biggest"), include.lowest = TRUE)
## X <- wmppp(data.frame(X=Emergencies$X, Y=Emergencies$Y, PointType=Category),
##    win=Region)
## X$window$units <- c("meter","meters")
## KdE <- KdEnvelope(X, r=seq(0, 10000, 100), NumberOfSimulations=1000,
##    ReferenceType="Biggest", Global=TRUE)
## plot(KdE, main="")


## ----KdFig, echo=FALSE, results='hide'-----------------------------------
load("CSBIGS.Rdata")
Category <- cut(Emergencies$M, quantile(Emergencies$M, c(0, 0.9, 1)),
   labels = c("Other", "Biggest"), include.lowest = TRUE)
X <- wmppp(data.frame(X=Emergencies$X, Y=Emergencies$Y, PointType=Category),
   win=Region)
X$window$units <- c("meter","meters")
KdE <- KdEnvelope(X, r=seq(0, 10000, 100), NumberOfSimulations=1000,
   ReferenceType="Biggest", Global=TRUE)
plot(KdE, main="")


## ----P16Code, eval=FALSE-------------------------------------------------
## data("paracou16")
## plot(paracou16, which.marks="PointWeight", main="")


## ----P16Fig, echo=FALSE, results='hide'----------------------------------
par(mar=c(0,1,0,4))
data("paracou16")
plot(paracou16, which.marks="PointWeight", main="")


## ----MCode, echo=TRUE, eval=FALSE----------------------------------------
## Envelope <- MEnvelope(paracou16, r = seq(0, 30, 2), NumberOfSimulations
##    = 1000, Alpha = 0.05, ReferenceType = "V. Americana", NeighborType
##    = "Q. Rosea", SimulationType = "RandomLabeling", Global = TRUE)
## plot(Envelope, main="")


## ----MFig, echo=FALSE, results='hide'------------------------------------
Envelope <- MEnvelope(paracou16, r = seq(0, 30, 2), NumberOfSimulations 
   = 1000, Alpha = 0.05, ReferenceType = "V. Americana", NeighborType 
   = "Q. Rosea", SimulationType = "RandomLabeling", Global = TRUE)
plot(Envelope, main="")


## ----MEnvelope-----------------------------------------------------------
GoFtest(Envelope)


## ----Ktest---------------------------------------------------------------
data("paracou16")
RectWindow <- owin(c(300, 400), c(0, 150))
X <- paracou16[RectWindow]
Ktest(X, seq(5, 50, 5))


