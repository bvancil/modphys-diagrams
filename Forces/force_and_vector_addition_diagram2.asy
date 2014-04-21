import graph;
import geometry;
import labelpath;
size(20cm,0);


pen grid_p = linewidth(0.8)+gray(0.5);
pen dot_p = linewidth(5);
/*
  Keep track of the markangleradius(C)CW so that it can be incrememented for each vector drawn in a polar fashion.
*/
real arcradiuscounter(bool direction=CCW, bool reset=false) {
  static real arcradiusvalueCCWorig = 1;
  static real arcradiusvalueCWorig = 1.1;  
  static real arcradiusvalueCCW = arcradiusvalueCCWorig;
  static real arcradiusvalueCW =  arcradiusvalueCWorig;  
  static real arcradiusincrement = 0.8;
  if (reset) {
    arcradiusvalueCCW = arcradiusvalueCCWorig;
    arcradiusvalueCW = arcradiusvalueCWorig;
    return 0;
  }
  real radius;
  if (direction==CCW) {
    radius = arcradiusvalueCCW;
    arcradiusvalueCCW += arcradiusincrement;
  } else { // direction==CW
    radius = arcradiusvalueCW;
    arcradiusvalueCW += arcradiusincrement;
  }
  return radius;
}

struct Vector {
  pen p = linewidth(3)+black;
  pen arc_p;
  pen fiducial_p = linewidth(1)+red;
  vector vec;
  string name;
  string units;
  string mode; // "rectangular" or "polar"
  void drawlabel(coordsys R = currentcoordsys, bool value=true) {
    path vec_path = origin(R)--(origin(R)+this.vec);
    string value;
    if (this.mode=="polar") {
      value = format("%.2f", length(this.vec)); // set value of label to show length for statements below.
    } else if (this.mode=="rectangular") {
      value = "\langle"+format("%.2f",xpart(this.vec))+","+format("%.2f",ypart(this.vec))+"\rangle"; // set value of label to show pairwise components for statements below
    }
    if (abs(angle(this.vec))<=pi/2) { // needs label right-side up
      labelpath(shift(labelmargin(this.p)*(-4,1.5))*Label("$"+this.name+"="+value+"\ \textrm{"+this.units+"}$"), vec_path, RightJustified, this.p);
    } else {
      labelpath(shift(labelmargin(this.p)*(4,1.5))*Label("$"+this.name+"="+value+"\ \textrm{"+this.units+"}$"), reverse(vec_path), LeftJustified, this.p);
    }
  }
  void drawarc(coordsys R = currentcoordsys, real radius = 0, bool direction=CCW) { // radius==0 is the signal to use the default counting
    if (radius==0) radius = arcradiuscounter(direction); // use the right counter
    draw(origin(R)--(shift((radius,0))*origin(R)), this.fiducial_p); // draw the fiducial horizontal line (or part of it anyway)
    real final_angle;
    final_angle = (CCW) ? degrees(this.vec) : 360 - degrees(this.vec);
    arc C = arc(circle(origin(R), radius), 0, final_angle, direction);
    draw(L=("$"+format("%.0f",degrees(C))+"^\circ$"), a=C, align=NoAlign, p=this.arc_p, arrow=Arrow);
  }
  void drawvector(coordsys R = currentcoordsys) {
    path vec_path = origin(R)--(origin(R)+this.vec);
    draw(vec_path, this.p, Arrow(SimpleHead, 8));
  }
  void draw(coordsys R = currentcoordsys, bool value=true) {
    this.drawvector(R);
    this.drawlabel(R);
    if ((this.mode=="polar") && value)
      this.drawarc(R,direction=((degrees(this.vec)<=180)?CCW:CW));
  }
  void operator init(string name, string units, pair vec, pair base=(0,0), pen p=black, string mode="polar") {
    this.name = name;
    this.units = units;
    this.vec = vec;
    this.p = this.p+p;
    this.arc_p = p+linewidth(0.7)+fontsize(10);
    this.mode = mode;
  }
}
from Vector unravel Vector;

string fn(string type, string dealer, string feeler) {
  return "\overrightarrow{\textbf{F}}^{"+type+"}({\textrm{"+dealer+" on "+feeler+"}})";
}
string net_force_name() {
  return "\sum \textbf{F}";
}

coordsys C=defaultcoordsys;
dot(origin(C), dot_p);
Vector u = Vector(fn("g","E","O"), "N", (0,-6));
u.draw(C);
Vector v = Vector(fn("n","E","O"), "N", 4*dir(80));
v.draw(C);
Vector w = Vector(fn("n","P","O"), "N", 5*dir(180));
w.draw(C);
Vector Fnet = Vector(net_force_name(), "N", u.vec+v.vec+w.vec, blue);

pair Op = (6,0);
coordsys Cp=cartesiansystem(Op,(1,0),(0,1));
dot(origin(Cp), dot_p);
C = Cp;
arcradiuscounter(reset=true);
u.draw(C);
C = shift(u.vec)*C;
arcradiuscounter(reset=true);
v.draw(C);
C = shift(v.vec)*C;
arcradiuscounter(reset=true);
w.draw(C);
Fnet.draw(Cp);
