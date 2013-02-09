import graph;

pen grid_p = gray+linewidth(.5);
pen shape_p = black+linewidth(2);
pen thinner_p = black+linewidth(.5);
defaultpen(shape_p);

string absentticks(real x) {
  return "";
}

void prepgrid(int n) {
  defaultpen(shape_p);
  erase();
  size(7.5cm,0);
  scale(true);
  xlimits(-n,n);
  ylimits(-n,n);
  xaxis(BottomTop,RightTicks(ticklabel=absentticks,Step=1,extend=true,pTick=grid_p),p=grid_p);
  yaxis(LeftRight,RightTicks(ticklabel=absentticks,Step=1,extend=true,pTick=grid_p),p=grid_p);
}

void preprealgrid(int n) {
  defaultpen(thinner_p);
  erase();
  unitsize(.25cm);
  //scale(true);
  xlimits(-n,n);
  ylimits(-n,n);
  xaxis(BottomTop,RightTicks(ticklabel=absentticks,Step=1,extend=true,pTick=grid_p),p=grid_p);
  yaxis(LeftRight,RightTicks(ticklabel=absentticks,Step=1,extend=true,pTick=grid_p),p=grid_p);
}

void myship(string suffix) {
  shipout(outprefix()+"_"+suffix);
}

// prepgrid(5);
// draw(circle((0,0),5));
// myship("disc05");

// prepgrid(10);
// draw(circle((0,0),10));
// myship("disc10");

// prepgrid(5);
// draw((-4,-4)--(4,-3)--(2,4)--cycle);
// myship("triangle1");

// prepgrid(6);
// draw((-4,-3)..(3,-1)..(0,5)..(-1,3)..cycle);
// myship("blob1");

// prepgrid(6);
// path basic = 2.5*dir(0)..4.5*dir(36);
// path composite = basic;
// for(int angle = 72; angle < 360; angle += 72) {
//   composite = composite..(rotate(angle)*basic);
// }
// composite=composite..cycle;
// draw(composite);
// myship("star1");

// prepgrid(6);
// draw((-5,-4)--(2,-5)--(4,5)--(-1,-1)--cycle);
// myship("quadrilaterial1");

// prepgrid(5);
// draw((-4,4)--(1,4)--(4,2)--(1,0)--(-1,0)--(-1,-4)--(-4,-4)--cycle);
// myship("P");

prepgrid(5);
draw((-5,-2)--(-1,-2)..(1,-1.3)..(3,1)--(5,5)--(5,-5)--(-5,-5)--cycle);
myship("graph1");

// for(int r=1; r<10; ++r) {
//   preprealgrid(r);
//   dot((0,0));
//   draw(circle((0,0),r));
//   myship("scaleddisc0"+format("%i",r));
// }
