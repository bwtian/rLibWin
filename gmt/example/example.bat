@echo off
set file=map.eps
gmtdefaults -Ds > .gmtdefaults4
gmtset DEGREE_SYMBOL degree PAGE_ORIENTATION portrait PAPER_MEDIA a4+ PLOT_DEGREE_FORMAT F
pscoast -JM16c -R30W/15E/54N/70N -Di -G100/200/100 -B10f5g5/4f2g2 -K > %file%
psxy tmp/xy.gmt -JM -R -Scp -W2p -O -K >> %file%
pstext tmp/text.gmt -JM -R -O -K >> %file%
psxy tmp/bar.gmt -JM -R -W1p -G180 -O -K -A -M >> %file%
psxy tmp/empty.gmt -JM -R -O >> %file%
del .gmtcommands4 .gmtdefaults4
