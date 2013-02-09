import graph;

defaultpen(fontsize(10));
pen thick_p = linewidth(1.5);
pen axis_p = black+fontsize(8);
pen grid_major_p = gray(0.5)+linewidth(1.0);
pen grid_minor_p = gray(0.7)+linewidth(0.5);
pen circle_p = thick_p+black;
pen radial_p = black;
pen radial_accent_p = linewidth(1.5)+radial_p;
pen degree_p = black;

real tick_major = 0.1;
real tick_minor = 0.02;
real tick_low = 0.97;
real tick_high = 1.03;
int tick_every = 5;

// letter paper with 0.5" margins:
real width = 8.5 inches - 2*0.5 inches; 
real height = 11 inches - 2*0.5 inches;
size(width, height);

scale(true, true);
xlimits(-1.1,1.1);
ylimits(-1.1,1.1);

real axis_extend = 1.0;
real xmin = -axis_extend;
real xmax = axis_extend;
real ymin = -axis_extend;
real ymax = axis_extend;

real dummy(real x) { return 1.001*x; }
draw(graph(dummy,-1.0,1.0),invisible);
pen thin=linewidth(0.5*linewidth());
xaxis("",axis=LeftRight,axis_p,xmin=-1.1,xmax=1.1,Ticks(format="%",beginlabel=false,endlabel=false,Step=tick_major,step=tick_minor,begin=true,end=true,extend=true,pTick=grid_major_p,ptick=grid_minor_p),above=false);
yaxis("",axis=LeftRight,axis_p,ymin=-1.1,ymax=1.1,Ticks(format="%",beginlabel=false,endlabel=false,Step=tick_major,step=tick_minor,begin=true,end=true,extend=true,pTick=grid_major_p,ptick=grid_minor_p),above=false);
xaxis("",axis=YZero,axis_p,xmin=xmin,xmax=xmax,LeftTicks(beginlabel=false,endlabel=false,Step=tick_major,step=tick_minor,begin=false,end=false,NoZero,extend=false,pTick=axis_p,ptick=grid_minor_p),above=false);
yaxis("",axis=XZero,axis_p,ymin=ymin,ymax=ymax,RightTicks(beginlabel=false,endlabel=false,Step=tick_major,step=tick_minor,begin=false,end=false,NoZero,extend=false,pTick=axis_p,ptick=grid_minor_p),above=false);
draw((-1,0)--(1,0),axis_p+thick_p);
draw((0,-1)--(0,1),axis_p+thick_p);

path unitsquare = (-1,-1)--(-1,1)--(1,1)--(1,-1)--cycle;
//filldraw(Circle((0,0),1)^^(scale(1.1)*unitsquare),evenodd+white,white); // mask the grid outside the circle
for(int angle = 1; angle < 360; ++angle) {
  if (angle % tick_every == 0) continue;
  draw(tick_low*dir(angle)--dir(angle),radial_p);
}
string angle_label;
for(int angle = 0; angle < 360; angle+=tick_every) {
  draw(0.97*dir(angle)--tick_high*dir(angle),radial_accent_p);
  angle_label = "$"+format("%d",angle)+"^{\circ}$";
  //angle_label = "$"+format("%d",angle)+"^{\circ}\ ("+format("%#1.3f",Cos(angle))+","+format("%#1.3f",Sin(angle))+")$"; // for cheat sheet
  label(rotate(angle)*Label(angle_label),tick_high*dir(angle),dir(angle),degree_p);
}
draw(Circle((0,0),1),circle_p);



