/*
Makes a position-versus-timer reading graph from a function real(real) describing the position as a function of time.
*/

/* Originally from a Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki, go to User:Azjps/geogebra */
import graph;
real xmin = 0, xmax = 10, ymin = 0, ymax = 6;  /* image dimensions */
real gridx = 1, gridy = 1; /* grid intervals */
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(14); defaultpen(dps); /* default pen style */
pen ticklabel_p = defaultpen+fontsize(12);
pen dotstyle = black; /* point style */ 
pen wqwqwq = rgb(0.3764705882352946,0.3764705882352946,0.3764705882352946); 
 /* draw grid of horizontal/vertical lines */
pen grid_p = linewidth(1.4) + wqwqwq + linetype("2 2");
pen worldline_p = linewidth(3.6);
pen axis_p = defaultpen+black+linewidth(1.4);

void myship(string suffix) {
  shipout(outprefix()+"_"+suffix);
}

axis VZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.x.T(pic.scale.x.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 1; // relative position of axis label
    axis.side = left;
    axis.align = 1.5*E;
    axis.extend = extend;
    };
}
axis VZero = VZero();

axis HZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.y.T(pic.scale.y.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 1; // relative position of axis label
    axis.side = right;
    axis.align = W;
    axis.extend = extend;
    };
}
axis HZero = HZero();


void make_pos_graph(string suffix, real pos(real), real t0, real t1, Label t_label=Label("$t$/s", embed=Shift, align=4*E), Label pos_label=rotate(0)*Label("$x$/m",align=3*N))
{
  erase();
  size(10.91310503944411cm);

  draw(graph(pos, t0, t1), worldline_p);

  ticks hTicks = LeftTicks(format=Label(" ", align=E, p=ticklabel_p), Step=1, extend=true, pTick=grid_p); // The space clears the labels on the ticks.
  ticks vTicks = RightTicks(format=Label(" ", align=W, p=ticklabel_p), Step=1, extend=true, pTick=grid_p);
  xaxis(L="", axis=BottomTop, xmin=0, p=grid_p, ticks=hTicks);
  yaxis(L="", axis=LeftRight, ymin=0, p=grid_p, ticks=vTicks);
  hTicks = Ticks(format=Label("", align=E, p=ticklabel_p), ticklabel=null, Step=1, Size=2);
  vTicks = Ticks(format=Label("", align=W, p=ticklabel_p), ticklabel=null, Step=1, Size=2);
  xaxis(L=t_label, axis=VZero(false), xmin=0, p=axis_p, ticks=hTicks, arrow=Arrow(6), above=true);
  yaxis(L=pos_label, axis=HZero(false), ymin=0, p=axis_p, ticks=vTicks, arrow=Arrow(6), above=true);
  
  myship(suffix);
  return;
}


