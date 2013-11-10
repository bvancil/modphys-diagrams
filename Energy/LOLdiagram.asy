import graph;

texpreamble("\def\sup#1{\textrm{\scriptsize #1}}");

pen base_p = linewidth(1.4)+fontsize(10pt);
pen axis_p = base_p + linewidth(1.8)+gray(0.4);
pen finelydashed = linetype(new real[] {2,2},adjust=true);
pen levels_p = base_p + gray(0.4)+finelydashed;
pen text_p = base_p + black + linewidth(1.0);
pen circle_p = base_p + gray(0.4);

// compute the width of the string
real width_of(string text) {
  Label temp_l = Label(text, (0,0), NE, text_p);
  return (max(texpath(temp_l)).x-min(texpath(temp_l)).x);
  //path temp_path = texpath(temp_l);
  //return (max(temp_path).x-min(temp_path).x);
}

void draw_bargraph(pair lower_left, real width, real height, int levels, string[] labels, string title) {
  // lower_left is the coordinate of the lower_left end of the bargraph
  // width is the width
  // height is the height of the bar graph (not labels)
  // levels is the number of horizontal lines to draw
  // labels are the energy storage forms to include
  // title goes over the labels
  pair LL = lower_left;
  pair UL = LL + (0, height);
  pair LR = LL + (width, 0);
  pair UR = LL + (width, height);
  real dy = height / (levels);
  pair offset;
  for(int i=1; i<=levels; ++i) {
    offset = (0, dy * i);
    draw((LL+offset)--(LR+offset), levels_p);
  }
  draw(UL--LL--LR, axis_p, BeginArrow(arrowhead=HookHead, size=5.0));
  label("$E$", UL, N, text_p);
  
  int num_labels = labels.length;

  // compute the widths of the labels and the total label width
  real labels_width = 0;
  real label_width[] = new real[num_labels];
  for(int i=0; i<num_labels; ++i) {
    label_width[i] = width_of(labels[i]);
    labels_width += label_width[i];
  }

  real xspace = 0.3 cm;
  real yspace = 0.1 cm;
  real dx = (width-1.5*xspace-labels_width) / (num_labels-1);
  real xwidth = fontsize(text_p); // might be able to use this if not for superscripts

  // loop variables:
  pair offset = UL + (xspace,yspace); // where to start printing labels
  pair underline_offset = (.1cm,0);
  for(int i=0; i<num_labels; ++i) {
    label(labels[i], offset , NE, text_p);
    draw(shift(offset+underline_offset)*((0,0)--(label_width[i],0)), text_p); // for the line under the label
    offset += (label_width[i]+dx,0); // set the next offset
  }
  label(title, (UL+UR)/2+(0,lineskip(text_p)), N, text_p);
}

void draw_energy_flow_diagram(pair lower_left, real width) {
  pair center = lower_left + (width/2,width/2);
  draw(Circle(center, width/2), circle_p);
  label("\parbox{3cm}{\centering Energy Flow\par Diagram}", center + (0, width/2), N, text_p);
}

draw_bargraph((0,0), 3 cm, 3 cm, 5, new string[] {"$K$", "$U^\sup{g}$", "$U^\sup{el}$"}, "Initial");
draw_energy_flow_diagram((3.5cm,0), 3cm);
draw_bargraph((7cm,0), 4 cm, 3 cm, 5, new string[] {"$K$", "$U^\sup{g}$", "$U^\sup{el}$", "$E^\sup{therm}$"},"Final");

