// Asymptote code for kinematic_stack_pos_vel_grid_wide.asy
import graph;

pen axis_p = linewidth(1.4)+black+fontsize(9);
pen grid_p = linewidth(0.8)+gray(0.5);
pen ticklabel_p = fontsize(.01);
real phi=(1+sqrt(5))/2; // golden ratio
  
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
    axis.align = 2.2*N;
    axis.extend = extend;
    };
}
axis HZero = HZero();

void kingraph(picture pic, Label vL="", real vMin=-6, real vMax=6, Label hL=Label("$t$/s",embed=Shift, align=4*E), real hMin=0, real hMax=12) {
  scale(pic, Linear, Linear);
  xlimits(pic, hMin, hMax);
  ylimits(pic, vMin, vMax);
  real[] hTicks_a = sequence(1, floor(hMax));
  real[] vTicks_a = sequence(floor(vMin), ceil(vMax));
  ticks hTicks = LeftTicks(format=Label(" ", align=E, p=ticklabel_p), Ticks=hTicks_a, extend=true, pTick=grid_p); // The space clears the labels on the ticks.
  ticks vTicks = RightTicks(format=Label(" ", align=W, p=ticklabel_p), Ticks=vTicks_a, extend=true, pTick=grid_p);
  xaxis(pic=pic, L="", axis=BottomTop, p=grid_p, ticks=hTicks);
  yaxis(pic=pic, L="", axis=LeftRight, p=grid_p, ticks=vTicks);
  xaxis(pic=pic, L=hL, axis=VZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(4), above=true);
  yaxis(pic=pic, L=vL, axis=HZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(4), above=true);
}

picture pos_pic;
kingraph(pos_pic,  rotate(0)*Label("$x$/m",align=3*N), vMin=0, vMax=11);

picture vel_pic;
kingraph(vel_pic, rotate(0)*Label("$v$/(m/s)",align=3*N), vMin=-6, vMax=6);

//xequals(pos_pic,3,Dotted);
//xequals(vel_pic,3,Dotted);

// boring code for stacking the graphs.  The only interesting part is the htick/vtick settings, which can be used to change the size of the horizontal and vertical units of the graphs.
void stack(picture pics[]) {
  real margin=0mm;
  real htick = .4cm;
  real vtick = .25cm;
  frame[] frames = new frame[pics.length];
  for(int i=0; i<pics.length; ++i) {
    unitsize(pics[i], htick, vtick);
    frames[i] = pics[i].fit();
    if (i>0) {
      frames[i] = shift(0,min(frames[i-1]).y-max(frames[i]).y-margin)*frames[i];
    }
    add(frames[i]);
  }
}

stack(new picture[] {pos_pic, vel_pic});

