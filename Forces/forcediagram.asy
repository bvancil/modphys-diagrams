pen def_p = linewidth(2)+fontsize(14);
defaultpen(def_p);

struct Force {
  string name;
  pair vec; 
  void operator init(string name, pair vec) { this.name = name;	this.vec = vec; }
}

struct ForceDiagram {
  string feeler;
  string[] names;
  pair[] vectors;
  
  void operator init(string feeler) { this.feeler = feeler; }
  void draw(pen p=black) {
	for (int i=0; i<this.names.length; ++i) {
	  draw((0,0)--this.vectors[i], p, Arrow(10));
	  label(Label(this.names[i],EndPoint), (0,0)--this.vectors[i], p);
	}
	dot((0,0), p);
	label(this.feeler, LeftSide, p);
  }
}
ForceDiagram operator <<(ForceDiagram fd, Force f) {
  fd.names.push(f.name);
  fd.vectors.push(f.vec);
	return fd;
}
void draw(ForceDiagram fd, pen p=black) { fd.draw(p=p); }

struct VectorAdditionDiagram {
  ForceDiagram fd;

  void operator init(ForceDiagram fd) { this.fd = fd; }
  void draw(pen p=black) {
	pair netForce = (0,0);
	for (int i=0; i<this.fd.names.length; ++i) {
	  path vec_path = shift(netForce)*((0,0)--this.fd.vectors[i]);
	  draw(vec_path, p, Arrow(10));
	  label(Label(this.fd.names[i],MidPoint), vec_path, p);
	  netForce += this.fd.vectors[i];
	}
  }
}
void draw(VectorAdditionDiagram vad, pen p=black) { vad.draw(p=p); }
