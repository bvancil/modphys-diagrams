size(8cm,0);
int start=0;
int stop=100;
real height=-8;
real spacing=-4;
real y;
for(int ruler=0; ruler<4; ++ruler) {
  y = ruler*height;
  if (ruler>0) y+=spacing*(ruler-1);
  draw((start,y)--(start,y+height)--(stop,y+height)--(stop,y)--cycle);
  if (ruler>=1) {
    for(int i=start; i<=stop; i+=10) {
      draw((i,y)--(i,y+height));
    }
  }
  if (ruler>=2) {
    for(int i=start; i<=stop; i+=1) {
      draw((i,y)--(i,y+height/2));
    }
  }
  if (ruler>=3) {
    for(real i=start; i<=stop; i+=.1) {
      draw((i,y)--(i,y+height/4));
    }
  }
}
