/* Various types of motion maps */
import settings;
settings.outformat = "png"; // "pdf" will also work
size(1000,0); // horizontal size of the image; can put in units of cm or inches with PDF.

/*
  Since anything can be scaled to have dt=1 second, we'll assume that.  The x range can be calculated somewhat dynamically.
  I wish that fewer things were hard-coded, but you will probably need to adjust something.
*/
struct MotionMap {
  pen ref_p = linewidth(2)+black;
  pen pos_p = linewidth(5)+blue;
  pen vel_p = linewidth(2)+green;
  pen acc_p = linewidth(2)+red;
  arrowbar arrow = Arrow(12);
  real dy = .1;
  real vtodxratio = 0.5;
  real[] x;
  real[] v;
  real[] a;
  real n;
  real pos_max, pos_min, pos_diff, spd_max;
  
  real[] differences(real[] array) {
    /* return the difference array */
    real[] result;
    for (int i=1; i<array.length; ++i)
      result.push(array[i]-array[i-1]);
    return result;
  }
  real[] linspace(real t0, real t1, int n) {
    real[] result;
    real dt = (t1-t0)/(n-1);
    real t = t0;
    for(int i = 0; i < n; ++i) {
      result.push(t);
      t += dt;
    }
    return result;
  }
  real[] evaluate(real x(real), real t0, real t1, int n) {
    real[] result;
    real dt = (t1-t0)/(n-1);
    real t = t0;
    for(int i = 0; i < n; ++i) {
      result.push(x(t));
      t += dt;
    }
    return result;
  }
  real derivative(real x(real), real t) {
    real dt = 1e-4;
    return (x(t+dt)-x(t))/dt; // one-sided
    //return (x(t+dt)-x(t-dt))/dt/2; // order O(h^2)
    //return (-x(t+2*dt)+8*x(t+dt)-8*x(t-dt)+x(t-2*dt)); // order O(h^4)
  }
  real[] differentiate(real x(real), real t0, real t1, int n) {
    real[] result;
    real dt = (t1-t0)/(n-1);
    real t = t0;
    for(int i = 0; i < n; ++i) {
      result.push(this.derivative(x,t));
      t += dt;
    }
    return result;
  }
  real derivative2(real x(real), real t) {
    real dt = 1e-4;
    //return (x(t+dt)+x(t-dt)-2*x(t))/(dt*dt); // order O(h^2)
    return (-x(t+2*dt)+16*x(t+dt)-30*x(t)+16*x(t-dt)-x(t-2*dt))/(12*dt*dt); // order O(h^4)
  }
  real[] differentiate2(real x(real), real t0, real t1, int n) {
    real[] result;
    real dt = (t1-t0)/(n-1);
    real t = t0;
    for(int i = 0; i < n; ++i) {
      result.push(this.derivative2(x,t));
      t += dt;
    }
    return result;
  }
  pair location(real x) {
    return (x,0);
  }
  path velarrow(int i) {
    return (0,0)--(this.v[i]*vtodxratio,0);
  }
  void draw_ref_axis() {
    int pos_min = floor(this.pos_min);
    int pos_max = ceil(this.pos_max+.25); // allow for arrow
    for(int i = pos_min; i < pos_max; ++i) {
      draw((i,-this.dy*1.3)--(i,-this.dy*0.7),this.ref_p); // numbers control tick size
    }
    draw((pos_min,-this.dy)--(pos_max,-this.dy),this.ref_p,this.arrow);
    label("+",(pos_max,-this.dy),E,this.ref_p);
  }
  void draw() {
    this.pos_min = min(this.x);
    this.pos_max = max(this.x);
    this.pos_diff = max(map(abs, this.differences(x)));
    this.spd_max = max(map(abs,this.v));
    pair[] locations;
    real last_x=-9e99;
    real y_shift=0;
    for(real curr_x : this.x) {
      if (curr_x == last_x) y_shift+=this.dy;
      last_x = curr_x;
      locations.push(shift(0,y_shift)*location(curr_x));
    }
    this.draw_ref_axis();
    // draw vel
    for(int i=0; i<this.n; ++i)
      draw(shift(locations[i])*velarrow(i),this.vel_p,this.arrow);
    // draw pos
    for(pair l : locations)
      dot(l,this.pos_p);
    // draw acc
    //for(pair l : locations)
    //  dot(shift(0,dy*0.4)*l,acc_p); // FIXME
  }
  void operator init(real[] x, real[] v, real[] a) {
    /* all arrays should have the same length? */
    this.x = x;
    this.v = v;
    this.a = a;
    this.n = x.length;
  }
  void operator init(real[] x) {
    this.x = x;
    this.v = this.differences(x);
    this.a = null;
    this.n = x.length;
  }
  void operator init(real x(real), int t) {
    this.x = this.evaluate(x, 0, t, t+1);
    this.v = this.differentiate(x, 0, t, t+1);
    this.a = this.differentiate2(x, 0, t, t+1);
    this.n = this.x.length;
  }

}
from MotionMap unravel MotionMap;

void draw(MotionMap m) {
  m.draw();
}

real x(real t) {
  if (t < 5) return t;
  if (t < 7) return 5;
  return t-2;
}
MotionMap m = MotionMap(x, 10);
draw(m);
