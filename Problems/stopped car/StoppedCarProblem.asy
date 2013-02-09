/* File unicodetex not found. */

 /* Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki, go to User:Azjps/geogebra */
import graph;  
size(8.65cm,0);
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(12); defaultpen(dps); /* default pen style */ 
pen dotstyle = black; /* point style */ 
real xmin = -0.87, xmax = 7.79, ymin = -44.19, ymax = 58.03;  /* image dimensions */
pen qqttcc = rgb(0,0.2,0.8); 
Label laxis; laxis.p = fontsize(12); string xaxislabel (real x) { return "$" + string(x) + "$";} string yaxislabel (real x) { return "$" + string(x) + "$";} 
xaxis("$t\ \mathrm{(s)}$",xmin, xmax, Ticks(laxis, xaxislabel, Step = 1, Size = 2, NoZero), Arrows(6), above = true); 
yaxis("$x\ \mathrm{(m)}$", ymin, ymax, Ticks(laxis, yaxislabel, Step = 10, Size = 2, NoZero), Arrows(6), above = true); /* draws axes; NoZero hides '0' label */ 
 /* draw figures */
real f1 (real x) {return -35+20*x;} 
draw(graph(f1,-0.86,7.78), linewidth(1.6) + linetype("4 4") + qqttcc); 
real f2 (real x) {return 2.5/2*x^2;} 
draw(graph(f2,0.01,7.78), linewidth(1.6)); 
real f3 (real x) {
  if (x<4) return -35+20*x-5/2*x^2;
  return 5;
}
draw(graph(f3,-0.86,7.78), linewidth(1.6) + linetype("4 4") + qqttcc); 
 /* dots and labels */
label("my car", (0.73,-34.18), NE * labelscalefactor,qqttcc); 
label("stopped car", (-0.27,4.5), NE * labelscalefactor); 
clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax+2)--(xmax,ymin)--cycle); 
 /* end of picture */

