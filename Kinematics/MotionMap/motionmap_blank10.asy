/* Various types of motion maps */

struct MotionMap {
  pen ref_p = black+linewidth(1.4);
  real arrow_size = 12; // arrow head size
  real length = 8cm;
  real n; // for number of marks
  real dx; // for tick marks
  real dy = .2cm; // for vertical offsets
  Label axis_L;
  
  void draw() {
    // draw ref axis
    draw((0,-this.dy)--(this.length,-this.dy),this.ref_p,Arrow(this.arrow_size));
    // draw axis label
    label(this.axis_L, (this.length,-this.dy), E, this.ref_p);
    // old code for X with no ticks and + in pos. dir.
    //label("+",(this.length,-this.dy),E,this.ref_p);
    //label("$\times$",(0,-this.dy),this.ref_p);
    // new code for ticks:
    for(int i; i < this.n; ++i) {
      draw((i*this.dx,0)--(i*this.dx,-2*this.dy), this.ref_p);
    }
  }
  void operator init(Label axis_L="$\vec{s}$", real length=10cm, real num_ticks=10) {
    this.axis_L = axis_L;
    this.length = length;
    this.n = num_ticks;
    this.dx = this.length/this.n;
  }
}
from MotionMap unravel MotionMap;

void draw(MotionMap m) {
  m.draw();
}

MotionMap m = MotionMap();
draw(m);
