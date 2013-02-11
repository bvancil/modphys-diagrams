// blank grid
real phi=(1+sqrt(5))/2;
pen axes_p = linewidth(1.4);
real height=5cm;
real width=height*phi;
draw((0,height)--(0,0)--(width,0),axes_p,Arrows(arrowsize(linewidth(.5))));

