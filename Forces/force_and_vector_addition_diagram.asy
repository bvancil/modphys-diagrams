import graph;
import labelpath;

pen grid_p = linewidth(0.8)+gray(0.5);

struct Vector {
  real scale = 1cm; // per unit of vector
  pen vec_p = linewidth(3)+black;
  pair base = (0,0);
  pair vec;
  string name;
  string units;
  string mode; // "rectangular" or "polar"
  void draw() {
    path vec_path = (this.scale*this.base)--(this.scale*(this.base+this.vec));
    draw(vec_path, this.vec_p, Arrow(12));
    //label("$"+this.name+"="+format("%.2f",length(this.vec))+"\ \textrm{"+this.units+"}$", vec_path, RightSide);
    labelpath(shift((0,0.2cm))*Label("$"+this.name+"="+format("%.2f",length(this.vec))+"\ \textrm{"+this.units+"}$"), vec_path, RightJustified);
  }

  void operator init(string name, string units, pair vec, pair base=(0,0), pen color=black, string mode="polar") {
    this.name = name;
    this.units = units;
    this.vec = vec;
    this.base = base;
    this.vec_p = this.vec_p+color;
    this.mode = mode;
  }
}
from Vector unravel Vector;

string fn(string type, string description) {
  return "\vec{\textbf{F}}^"+type+"_{\textrm{\scriptsize "+description+"}}";
}
Vector v = Vector(fn("n","A on O"), "N", (5,3));
v.draw();

