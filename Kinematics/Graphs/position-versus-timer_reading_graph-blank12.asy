 /* Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki, go to User:Azjps/geogebra */
import graph;
real xmin = 0, xmax = 12, ymin = 0, ymax = 8;  /* image dimensions */

void myship(string suffix) {
  shipout(outprefix()+"_"+suffix);
}

size(10.91310503944411cm); 
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(14); defaultpen(dps); /* default pen style */ 
pen dotstyle = black; /* point style */ 
pen wqwqwq = rgb(0.3764705882352946,0.3764705882352946,0.3764705882352946); 
 /* draw grid of horizontal/vertical lines */
pen gridstyle = linewidth(1.4) + wqwqwq + linetype("2 2"); real gridx = 1, gridy = 1; /* grid intervals */

for(real i = ceil(xmin/gridx)*gridx; i <= floor(xmax/gridx)*gridx; i += gridx)
 draw((i,ymin)--(i,ymax), gridstyle);
for(real i = ceil(ymin/gridy)*gridy; i <= floor(ymax/gridy)*gridy; i += gridy)
 draw((xmin,i)--(xmax,i), gridstyle);
 /* end grid */ 

Label laxis = Label(" "); // The space blanks out the ticks.
laxis.p = fontsize(12);
xaxis(Label("$t$/", embed=Shift, align=4*E),xmin, xmax,defaultpen+black+linewidth(1.2), Ticks(laxis, ticklabel=null, Step = 1, Size = 2), Arrow(6), above = true); 
yaxis(rotate(0)*Label("$\vec{s}$/",align=3*N), ymin, ymax,defaultpen+black+linewidth(1.2), Ticks(laxis, ticklabel=null, Step = 1, Size = 2), Arrow(6), above = true); /* draws axes; NoZero hides '0' label */ 
 /* draw figures */
pen worldline = linewidth(3.6);
//draw((0,4)--(2,0)--(3,0)--(6,3)--(8,6)--(10,6), worldline);

real x1(real t)
{
  if (t<2) return 4-2*t;
  if (t<3) return 0;
  if (t<6) return 0+1*(t-3);
  if (t<8) return 3+1.5*(t-6);
  return 6;
}
//draw(graph(x1, 0, 10), worldline);

 /* dots and labels */
//clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle); 
 /* end of picture */
