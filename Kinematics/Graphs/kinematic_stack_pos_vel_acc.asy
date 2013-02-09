// Asymptote code for kinematic_stack_pos_vel_acc.asy
import graph;

pen axis_p = linewidth(1.4)+black;
pen grid_p = linewidth(1.0)+gray(0.2);

real hticks = 5;
real vMin_ticks = -5;
real vMax_ticks = 5;

void kingraph(picture pic, Label vL="", real vMin=vMin_ticks, real vMax=vMax_ticks, Label hL="$t$", real hMin=0, real hMax=hticks) {
  scale(pic, Linear, Linear);
  xlimits(pic, hMin, hMax);
  ylimits(pic, vMin, vMax);
  xaxis(pic, hL, YZero, axis_p, Arrow(6));
  yaxis(pic, vL, XZero, axis_p, Arrow(6));
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

