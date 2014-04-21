size(6cm,0);

pen compass_rose_p = linewidth(1.2)+gray(0.5)+fontsize(12);
pen x_p = compass_rose_p + gray(0.3);
pen label_p = black+fontsize(12);

pair NofE = unit(E+NE);
pair EofN = unit(N+NE);
pair WofN = unit(N+NW);
pair NofW = unit(W+NW);
pair SofW = unit(W+SW);
pair WofS = unit(S+SW);
pair EofS = unit(S+SE);
pair SofE = unit(E+SE);

void label_dir(Label L, pair direction) {
  real deg = degrees(direction);
  if ((deg > 90) && (deg < 270)) deg = 180+deg; // make each mostly upright
  //label(rotate(deg)*L,direction/1.7,label_p); // rotated labels crunched inward
  label(L,direction/1.1,label_p+fontsize(12));
}
defaultpen(compass_rose_p);
draw(NE--SW,x_p);
draw(SE--NW,x_p);
draw(N--S,Arrows(12));
draw(E--W,Arrows(12));
label("N",N,N);
label("E",E,E);
label("S",S,S);
label("W",W,W);
label_dir("N of E",NofE);
label_dir("E of N",EofN);
label_dir("W of N",WofN);
label_dir("N of W",NofW);
label_dir("S of W",SofW);
label_dir("W of S",WofS);
label_dir("E of S",EofS);
label_dir("S of E",SofE);
