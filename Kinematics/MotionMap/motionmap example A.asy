/* Various types of motion maps */
import settings;
//settings.outformat = "png"; // "pdf" will also work
//size(1000,0); // horizontal size of the image in pixels
settings.outformat = "pdf"; // "png" will also work
size(20cm,0); // horizontal size of the image

/*
  Since anything can be scaled to have dt=1 second, we'll assume that.  The x range can be calculated somewhat dynamically.
  I wish that fewer things were hard-coded, but you will probably need to adjust something.
*/
struct MotionMap {
  /* Pens are combined according to whether grayscale bool is set. */
  /* Drawing options for ref=reference axis */
  pen ref_p = linewidth(2);
  pen ref_color = black;
  pen ref_grayscale = black;
  /* Drawing options for pos=position */
  pen pos_p = linewidth(5);
  pen pos_color = rgb(0,0.13725490196078433,0.4); // royal blue
  pen pos_grayscale = black;
  /* Drawing options for vel=velocity */
  pen vel_p = linewidth(2);
  pen vel_color = rgb(0.8,0.3333333333333333,0); // burnt orange
  pen vel_grayscale = gray(.2);
  /* Drawing options for acc=acceleration */
  pen acc_p = linewidth(2); /* Note: I wish Asymptote could do double lines like PGF/Tikz */
  pen acc_color = red;
  pen acc_grayscale = gray(.4);
  arrowbar arrow = Arrow(10); // argument adjusts arrowhead size
  /* dy is a vertical spacing adjustment used to influence distance from axis and vertical "jog" when object stops */
  //real dy = .1; // PNG
  real dy = .007cm; // PDF
  real dxtovratio = 0.5; // in units s
  real dxtoaratio = 0.5; // in units s^2
  real[] x;
  real[] v;
  real[] a;
  real n;
  real pos_max, pos_min, pos_diff, spd_max;
  bool grayscale = false; // If false, use _color pen.  If true, use _grayscale pen.
  bool draw_ref = true;
  bool draw_pos = true;
  bool draw_vel = true;
  bool draw_acc = false;
  
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
  real derivative2(real x(real), real t, real dt=1e-4) {
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
  real[] integrateTrapezoid(real[] vs, real dt) { // implement the Trapezoid rule to integrate v[]
    real[] xs = new real[vs.length];
    xs[0] = 0;
    for(int i = 1; i < vs.length; ++i) {
      xs[i] = xs[i-1]+0.5*dt*(vs[i-1]+vs[i]);
    }
    return xs;
  }
  // not used b/c we can compose array version with the evaluate function:
  real[] integrateTrapezoid(real v(real), real[] t) { // implement the Trapezoid Rule to integrate v(t)
    real[] vs = new real[t.length]; // more memory intensive, but store the evaluations of v
    real dt = t[1]-t[0]; // assume uniform spacing
    for(int i = 0; i < t.length; ++i) {
      vs[i] = v(t[i]);
    }
    return this.integrateTrapezoid(vs, dt);
  }
  pair location(real x) {
    return (x,0);
  }
  path velarrow(int i) {
    return (0,0)--(this.v[i]*dxtovratio,0);
  }
  path accarrow(int i) {
    return (0,0)--(0.5,0);
    return (0,0)--(this.a[i]*dxtoaratio,0);
  }
  void _draw_ref_axis() {
    // int pos_min = floor(this.pos_min); // start at minimum
    int pos_min = 0; //start at zero
    int pos_max = ceil(this.pos_max+.25); // allow for arrow
    
    for(int i = pos_min; i < pos_max; ++i) {
      draw((i,-this.dy*1.3)--(i,-this.dy*0.7),this.ref_p); // numbers control tick size
    }
    draw((pos_min,-this.dy)--(pos_max,-this.dy),this.ref_p,this.arrow); 
    label("+",(pos_max,-this.dy),E,this.ref_p);
  }
  void draw() {
    pair[] locations;
    real curr_x;
    real last_x=-9e99;
    real y_shift=0;
    real last_v=15;
    real curr_v;
    for(int i=0; i<this.n; ++i) {
      curr_x = this.x[i];
      curr_v = this.v[i];
      if (curr_x == last_x) y_shift+=this.dy; // object has stopped
      if (curr_v * last_v < 0) y_shift+=this.dy; // object has changed direction
      last_x = curr_x;
      last_v = curr_v;
      locations.push(shift(0,y_shift)*location(curr_x));
    }
    this._draw_ref_axis();
    if (this.draw_vel) { // draw vel
      for(int i=0; i<this.n; ++i)
	draw(shift(locations[i])*this.velarrow(i),this.vel_p,this.arrow);
    }
    if (this.draw_pos) { // draw pos
      for(pair l : locations)
	dot(l,this.pos_p);
    }
    if (this.draw_acc) { // draw acc
      for(int i=0; i<this.n; ++i)
	draw(shift(locations[i]+(0,dy*0.4))*this.accarrow(i),this.acc_p,this.arrow); // FIXME
    }
  }
  void _update_options() {
    // set the correct pen for grayscale or color
    this.ref_p = this.ref_p + ((this.grayscale)?this.ref_grayscale:this.ref_color);
    this.pos_p = this.pos_p + ((this.grayscale)?this.pos_grayscale:this.pos_color);
    this.vel_p = this.vel_p + ((this.grayscale)?this.vel_grayscale:this.vel_color);
    this.acc_p = this.acc_p + ((this.grayscale)?this.acc_grayscale:this.acc_color);
    // set the useful properties
    this.n = this.x.length;
    this.pos_min = min(this.x);
    this.pos_max = max(this.x);
    this.pos_diff = max(map(abs, this.differences(x)));
    this.spd_max = max(map(abs,this.v));

  }
  void operator init(real[] x, real[] v, real[] a, bool grayscale=false) {
    /* all arrays should have the same length? */
    this.x = x;
    this.v = v;
    this.a = a;
    this.grayscale = grayscale;
    this._update_options();
  }
  void operator init(real[] x, bool grayscale=false) {
    this.x = x;
    this.v = this.differences(x);
    this.a = this.differences(v);
    this.grayscale = grayscale;
    this._update_options();
  }
  void operator init(real x(real), int t, bool grayscale=false) {
    this.x = this.evaluate(x, 0, t, t+1);
    this.v = this.differentiate(x, 0, t, t+1);
    this.a = this.differentiate2(x, 0, t, t+1);
    this.grayscale = grayscale;
    this._update_options();
  }
  // void operator init(real[] v, bool grayscale=false) {
  //   this.x = this.integrateTrapezoid(v, 1);
  //   this.v = v;
  //   this.a = this.differences(v);
  //   this.grayscale = grayscale;
  //   this._update_options();
  // }
  // void operator init(real v(real), int t, bool grayscale = false) {
  //   this.v = this.evaluate(v, 0, t, t+1);
  //   this.x = this.integrateTrapezoid(this.v, 1);
  //   this.a = this.differentiate2(v, 0, t, t+1);
  //   this.n = t+1;
  //   this.grayscale = grayscale;
  //   this._update_options();
  // }
}
from MotionMap unravel MotionMap;

void draw(MotionMap m) {
  m.draw();
}

real x1(real t) { // 5s @ 1m/s, 2s & 0m/s, 
  if (t < 4) return 3+t;
  if (t < 6) return 7-3*(t-4);
  if (t < 10) return 1;
  return 1+2*(t-10);
}
// Synatx:
MotionMap m = MotionMap(x1, 13); // based on position function x1 for t in [0,10]s
draw(m);
// OR
//draw(MotionMap(x1, 10));
     
//real x2(real t) { return t*t/2; } // accelerate
//draw(MotionMap(x2, 4, grayscale=false));

//real v1(real t) { return t; } // accelerate
//MotionMap m = MotionMap(v1,4);
//m.draw_acc = true;
//draw(m);


/* TODO:
*** fix acceleration
*** add an easy toggle for acceleration
*** add an easy toggle for velocity (useful to have students draw in velocity)
*** adjust dy automatically for PDF/PNG and for size of picture (range of position values)
*** adjust arrow head automatically
*/
