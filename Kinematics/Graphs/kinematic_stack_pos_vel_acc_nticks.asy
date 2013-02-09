// Asymptote code for kinematic_stack_pos_vel_acc_nticks.asy
import graph;

pen axis_p = linewidth(1.4)+black;
pen tick_p = linewidth(1.0)+gray(0.2)+fontsize(8);
pen ticklabel_p = tick_p;
int hticks = 5;
int vMin_ticks = -5;
int vMax_ticks = 5;
real[] hTicks_a = sequence(1, hticks);
real[] vTicks_a = sequence(vMin_ticks, vMax_ticks);
ticks hTicks = Ticks(format=Label("$%.4g$", align=E, p=ticklabel_p), Ticks=hTicks_a, Size=1mm, pTick=tick_p);
ticks vTicks = Ticks(format=Label("$%.4g$", align=W, p=ticklabel_p), Ticks=vTicks_a, Size=1mm, pTick=tick_p);
real axis_extra = 0.7; // extend the axis just a bit past the last tick mark
  
axis VZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.x.T(pic.scale.x.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 1; // relative position of axis label
    axis.side = left;
    axis.align = 5*E;
    axis.extend = extend;
    };
}
axis VZero = VZero();

axis HZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.y.T(pic.scale.y.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 0.5; // relative position of axis label
    axis.side = right;
    axis.align = W;
    axis.extend = extend;
    };
}
axis HZero = HZero();

void kingraph(picture pic, Label vL="", real vMin=vMin_ticks-axis_extra, real vMax=vMax_ticks+axis_extra, Label hL="$t$ [sec]", real hMin=0, real hMax=hticks+axis_extra) {
  scale(pic, Linear, Linear);
  xlimits(pic, hMin, hMax);
  ylimits(pic, vMin, vMax);
  xaxis(pic=pic, L=hL, axis=VZero(false), p=axis_p, ticks=hTicks, arrow=Arrow(6), above=false);
  yaxis(pic=pic, L=vL, axis=HZero(false), p=axis_p, ticks=vTicks, arrow=Arrow(6), above=false);
}

picture pos_pic;
kingraph(pos_pic, "$s$ [m]");

picture vel_pic;
kingraph(vel_pic, "$v$ [m/sec]");

picture acc_pic;
kingraph(acc_pic, "$a$ [m/sec/sec]");

//xequals(pos_pic,3,Dotted);
//xequals(vel_pic,3,Dotted);
//xequals(acc_pic,3,Dotted);

// boring code for stacking the graphs.  The only interesting part is the htick/vtick settings, which can be used to change the size of the horizontal and vertical units of the graphs.
void stack(picture pics[]) {
  real margin=2mm;
  real htick = .8cm;
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

