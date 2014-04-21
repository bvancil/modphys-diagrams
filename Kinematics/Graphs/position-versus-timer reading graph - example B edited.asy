 /* Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki, go to User:Azjps/geogebra */
import graph; size(10.91310503944411cm); 
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(12); defaultpen(dps); /* default pen style */ 
pen dotstyle = black; /* point style */ 
real xmin = -0.5971035844772679, xmax = 10.31600145496684, ymin = -0.4460995476012107, ymax = 7.461949987746248;  /* image dimensions */
pen wqwqwq = rgb(0.3764705882352946,0.3764705882352946,0.3764705882352946); 
 /* draw grid of horizontal/vertical lines */
pen gridstyle = linewidth(1.0) + wqwqwq + linetype("2 2"); real gridx = 1.000000000000000, gridy = 1.000000000000000; /* grid intervals */
for(real i = ceil(xmin/gridx)*gridx; i <= floor(xmax/gridx)*gridx; i += gridx)
 draw((i,ymin)--(i,ymax), gridstyle);
for(real i = ceil(ymin/gridy)*gridy; i <= floor(ymax/gridy)*gridy; i += gridy)
 draw((xmin,i)--(xmax,i), gridstyle);
 /* end grid */ 

Label laxis; laxis.p = fontsize(12); string xaxislabel (real x) { return "$" + string(x) + "\,\mathrm{s}$";} string yaxislabel (real x) { return "$" + string(x) + "\,\mathrm{m }$";} 
xaxis("$t$",xmin, xmax,defaultpen+black+linewidth(1.2), Ticks(laxis, xaxislabel, Step = 1.000000000000000, Size = 2, NoZero), Arrows(6), above = true); 
yaxis("$⃑s$", ymin, ymax,defaultpen+black+linewidth(1.2), Ticks(laxis, yaxislabel, Step = 1.000000000000000, Size = 2, NoZero), Arrows(6), above = true); /* draws axes; NoZero hides '0' label */ 
 /* draw figures */
draw((0.000000000000000,4.000000000000000)--(2.000000000000000,0.000000000000000), linewidth(3.600000000000004)); 
draw((2.000000000000000,0.000000000000000)--(3.000000000000000,0.000000000000000), linewidth(3.600000000000004)); 
draw((3.000000000000000,0.000000000000000)--(6.000000000000000,3.000000000000000), linewidth(3.600000000000004)); 
draw((6.000000000000000,3.000000000000000)--(8.000000000000000,6.000000000000000), linewidth(3.600000000000004)); 
draw((8.000000000000000,6.000000000000000)--(10.00000000000000,6.000000000000000), linewidth(3.600000000000004)); 
 /* dots and labels */
clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle); 
 /* end of picture */
