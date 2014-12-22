import forcediagram;

unitsize(1mm); // size of 1N

texpreamble("\usepackage{amsmath}");
string my_label(string interaction, string dealer) {
  return "$\vec{\boldsymbol{\mathbf{F}}}^{\text{"+interaction+"}}(\text{"+dealer+"})$";
}

ForceDiagram fd=ForceDiagram("Object")
  <<Force(my_label("g","A"), 35*dir(0))
  <<Force(my_label("em","B"), 60*dir(120))
  <<Force(my_label("n","C"), 44*dir(240));
//draw(fd, blue);
draw(VectorAdditionDiagram(fd), red);
