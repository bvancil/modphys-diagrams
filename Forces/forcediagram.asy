texpreamble("\usepackage{amsmath}");
pen def_p = linewidth(2)+fontsize(14);
defaultpen(def_p);
size(0,10cm);
void force(string interaction, string dealer, pair direction, pen color=black) {
	draw((0,0)--direction, color,Arrow(10));
	label(Label("$\vec{\boldsymbol{\mathbf{F}}}^{\text{"+interaction+"}}(\text{"+dealer+"})$",EndPoint), (0,0)--direction, color);
}

label("tricycle",(0,0),2*NE);
force("g", "Earth", 3*S, 0.7*green);
force("n", "Earth", 3*N, 0.7*blue);
force("f", "Earth", 1.5*W, 0.7*red);
force("n", "air", 1.5*E, 0.7*yellow);
dot((0,0));
