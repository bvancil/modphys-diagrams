size(8cm,0);
int start=98;
int stop=102;
real height=.4;
void draw_arrow(real pos) {
  draw((pos,-height/3)--(pos,-.01),Arrow);
}

draw((start,0)--(start,height)--(stop,height)--(stop,0)--cycle);
for(int i=start+1; i<=stop-1; i+=1) {
  draw((i,0)--(i,height));
  label(format("%i",i),(i,height/2));
}
for(real i=start; i<=stop; i+=.1) {
  draw((i,0)--(i,height/3));
}
draw_arrow(100.04);
