import settings;
//settings.outformat = "png"; // used to include in web pages
settings.outformat = "pdf"; // used for printing and inclusion in word processor files

// replaces shipout() to pause steps in a diagram for snapshots
void myshipout(int set_counter=0) {
  static int counter=1;
  if (set_counter>0) counter = set_counter;
  shipout(outprefix()+"_"+format("%02i",counter));
  ++counter;
}

// Make the graph paper with a 35 by 45 grid.
pen lines_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+white+linewidth(1.2); //lightened royalblue(web)
pen axes_p = rgb(0,0.13725490196078433,0.4)+linewidth(1.4); // royalblue
real paperwidth = 17.5cm;
real paperheight = 22.5cm;
real width = paperwidth - 0cm; // margins
real height = paperheight - 0cm; // margins 
real gridspacing = .5cm;
int nwidth = round(width/gridspacing); // 35
int nheight = round(height/gridspacing); // 45
width = nwidth*gridspacing; 
height = nheight*gridspacing;
transform page_grid_to_coords = scale(gridspacing);
defaultpen(axes_p);

size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw(page_grid_to_coords*((i,0)--(i,nheight)),lines_p);
for(int j = 0; j <= nheight; ++j)
  draw(page_grid_to_coords*((0,j)--(nwidth,j)),lines_p);
//myshipout();


// Make 30 by 38 graph axes.
draw(page_grid_to_coords*((4,nheight-3)--(4,4)--(nwidth-1,4)),axes_p,Arrows(DefaultHead,0.6*arrowsize(axes_p)));
//myshipout();

// Set up graph variables.
transform graph_grid_to_coords = scale(gridspacing)*shift(4,4);
int xmax = nwidth - 4 - 1;
int ymax = nheight - 4 - 3;
real xmid = xmax/2;
real ymid = ymax/2;

// Label the vertical axis with the dependent variable.
label(rotate(90)*"Period\phantom{/s}", graph_grid_to_coords*(-4,ymid), E);
//myshipout();

// Add the dependent variable units.
label(rotate(90)*"Period/s", graph_grid_to_coords*(-4,ymid), E);
//myshipout();

// Add the dependent variable symbol.
label("$T$", graph_grid_to_coords*(0,ymax), N);
//myshipout();

// Label the horizontal axis with the independent variable.
label("Length\phantom{/cm}", graph_grid_to_coords*(xmid,-4), N);
//myshipout();

// Add the independent variable units.
label("Length/cm", graph_grid_to_coords*(xmid,-4), N);
//myshipout();

// Add the independent variable symbol.
label("$L$", graph_grid_to_coords*(xmax,0), E);
//myshipout();


// Write the title.
label("Period v. Length for a Pendulum with a 14.6~g Bob and a 10${}^\circ$ Amplitude", graph_grid_to_coords*(xmid,ymax+3), S);
//myshipout();

void xtick(real x_grid, real x_label, string fmt="%0.02f") {
  static real tickhalflength = .15;
  draw(graph_grid_to_coords*((x_grid,-tickhalflength)--(x_grid,tickhalflength)));
  label(format(fmt,x_label), graph_grid_to_coords*((x_grid,0)), S);
}
void ytick(real y_grid, real y_label, string fmt="%0.02f") {
  static real tickhalflength = .15;
  draw(graph_grid_to_coords*((-tickhalflength,y_grid)--(tickhalflength,y_grid)));
  label(format(fmt,y_label), graph_grid_to_coords*((0,y_grid)), W);
}

// Make a zero tick on each axis.
xtick(0,0);
ytick(0,0);
//myshipout();

// Decide on a scale for the vertical axis.

myshipout(set_counter=11);
