import graph;
defaultpen(linewidth(0.8)+black+Helvetica()+fontsize(8));

real r1 = 5cm;
real r3 = 4cm;
real r2 = (r1+r3)/2;
real r4 = 5mm;
pair O = (0,0);

// Base line and semicircles
draw((-r2,0)--Arc(O, r1, 0, 180)--cycle);
draw(Arc(O, r2, 0, 180));
draw(Arc(O, r3, 0, 180));
draw(Arc(O, r4, 0, 180));
draw(r3*dir(170)--r3*dir(10));

// Crosshair
draw(O--r4*dir(90));

// Angle label functions

int top_angle(int angle) {
  return angle;
}

int bottom_angle(int angle) {
  return 180-angle;
}

// Tick marks and angle labels
real tick_length1 = 1mm;
real tick_length5 = 2mm;
real tick_length10 = 2mm;

pair u; // for unit in correct direction
for(int angle = 1; angle <= 179; ++angle) {
  u = dir(angle);
  draw((r1-tick_length1)*u--r1*u);
  draw(r3*u--(r3+tick_length1)*u);
}
for(int angle = 5; angle <= 175; angle = angle + 10) {
  u = dir(angle);
  draw((r1-tick_length5)*u--r1*u);
  draw(r3*u--(r3+tick_length5)*u);
}
for(int angle = 10; angle <= 170; angle = angle + 10) {
  u = dir(angle);
  draw((r1-tick_length10)*u--r1*u);
  draw((r3*sin(radians(10))*(1/tan(radians(angle)),1)-tick_length1*u)--(r3+tick_length10)*u);
  label(rotate(angle-90)*("\phantom{${}^\circ$}"+format("%d", top_angle(angle))+"${}^\circ$"), r2*u, u);
  label(rotate(angle-90)*("\phantom{${}^\circ$}"+format("%d", bottom_angle(angle))+"${}^\circ$"), r2*u, -u);  
}
label("0${}^\circ$", (-r2,0),NE);
label("0${}^\circ$", (r2,0),NE);
label("180$\!{}^\circ$", (-r2,0),NW+0.2*E,fontsize(6));
label("180$\!{}^\circ$", (r2,0),NW+0.2*E,fontsize(6));

// Ruler
// 1mm marks
for(int n = -39; n <= 39; ++n) {
  draw((n*1mm,0)--(n*1mm,tick_length1));
}
// 5mm marks
for(int n = -35; n <= 35; n = n + 10) {
  draw((n*1mm,0)--(n*1mm,tick_length5));
}
// 10mm marks
for(int n = -30; n <= 30; n = n + 10) {
  draw((n*1mm,0)--(n*1mm,tick_length10*2));
}
label("cm", (1cm,tick_length10*2),W);
  

// Adjust bounding box
real tol = 1mm;
real l = r1+tol;
draw((-l,-tol)--(-l,l)--(l,l)--(l,-tol)--cycle,invisible);
