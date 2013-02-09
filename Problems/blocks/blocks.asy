import settings;
outformat="png";

size(10cm,0);
real x, y;
int N=4;
for(int n=1; n<=N; ++n) {
  x = 1.5*(n-1);
  Label l;
  if (n==1) {
    l = "1 block";
  } else if (n < N) {
    l = format("%d",n)+" blocks";
  } else {
    l = "$n$ blocks";
  }
  label(l,(x+0.5,0),S);
  for(int i=0; i<n; ++i) {
    y = 1.0*i;
    draw(shift((x,y))*unitsquare);
  }
  if (n==N) {
    y = 1.0*n;
    dot((x+0.5,y+0.25));
    dot((x+0.5,y+0.5));
    dot((x+0.5,y+0.75));
  }
}
