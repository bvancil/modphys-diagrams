// Asymptote code for kinematic_stack_pos_vel_acc_grid.asy
import graph;

pen axis_p = linewidth(1.4)+black;
pen grid_p = linewidth(0.8)+gray(0.2);
pen ticklabel_p = fontsize(.01);
int hticks = 10;
int vMin_ticks = -5;
int vMax_ticks = 5;
real[] hTicks_a = sequence(1, hticks);
real[] vTicks_a = sequence(vMin_ticks, vMax_ticks);
real axis_extra = 0.7; // extend the axis just a bit past the last tick mark
  
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

void kingraph(picture pic, Label vL="", real vMin=vMin_ticks, real vMax=vMax_ticks, Label hL="$t$", real hMin=0, real hMax=hticks) {
  scale(pic, Linear, Linear);
  xlimits(pic, hMin, hMax);
  ylimits(pic, vMin, vMax);
  ticks hTicks = LeftTicks(format=Label(" ", align=E, p=ticklabel_p), Ticks=hTicks_a, extend=true, pTick=grid_p); // The space clears the labels on the ticks.
  ticks vTicks = RightTicks(format=Label(" ", align=W, p=ticklabel_p), Ticks=vTicks_a, extend=true, pTick=grid_p);
  xaxis(pic=pic, L="", axis=BottomTop, p=grid_p, ticks=hTicks);
  yaxis(pic=pic, L="", axis=LeftRight, p=grid_p, ticks=vTicks);
  xaxis(pic=pic, L=hL, axis=VZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(6), above=true);
  yaxis(pic=pic, L=vL, axis=HZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(6), above=true);
}

picture pos_pic;
kingraph(pos_pic, "$s$");

picture vel_pic;
kingraph(vel_pic, "$v$");

picture acc_pic;
kingraph(acc_pic, "$a$");

//xequals(pos_pic,3,Dotted);
//xequals(vel_pic,3,Dotted);
//xequals(acc_pic,3,Dotted);

// boring code for stacking the graphs.  The only interesting part is the htick/vtick settings, which can be used to change the size of the horizontal and vertical units of the graphs.
void stack(picture pics[]) {
  real margin=0mm;
  real htick = .4cm;
  real vtick = .4cm;
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

stack(new picture[] {pos_pic, vel_pic, acc_pic});

