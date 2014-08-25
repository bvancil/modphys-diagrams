import fontsize;
import settings;
//settings.outformat = "png"; // used to include in web pages
settings.outformat = "pdf"; // used for printing and inclusion in word processor files

// replaces shipout() to pause steps in a diagram for snapshots
void myshipout(int set_counter=0) {
  static int counter=1;
  if (set_counter>0) counter = set_counter;
  shipout("graphing_VIP_sequence"+"_"+format("%02i",counter));
  ++counter;
}

// Make the graph paper with a 35 by 45 grid.
pen lines_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+white+linewidth(1.2); //lightened royalblue(web)
pen axes_p = rgb(0,0.13725490196078433,0.4)+linewidth(1.4); // royalblue
pen bfsl_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+linewidth(1.4); // royalblue (web)
pen silver_p = rgb(0.75294117647058822,0.75294117647058822,0.75294117647058822)+linewidth(1.4); // silver
pen burnt_orange_p = rgb(0.8,0.3333333333333333,0)+linewidth(1.4)+fontsize(20); // burnt orange
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
defaultpen(axes_p+AvantGarde()+fontsize(20));

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
label(rotate(90)*"Period squared\phantom{/s${}^2$}", graph_grid_to_coords*(-4,ymid), E);
//myshipout();

// Add the dependent variable units.
label(rotate(90)*"Period squared/s${}^2$", graph_grid_to_coords*(-4,ymid), E);
//myshipout();

// Add the dependent variable symbol.
label("\mathversion{bold}$T^2$", graph_grid_to_coords*(0,ymax), NW);
//myshipout();

// Label the horizontal axis with the independent variable.
label("Length\phantom{/cm}", graph_grid_to_coords*(xmid,-4), N);
//myshipout();

// Add the independent variable units.
label("Length/cm", graph_grid_to_coords*(xmid,-4), N);
//myshipout();

// Add the independent variable symbol.
label("\mathversion{bold}$L$", graph_grid_to_coords*(xmax+1,0), NW); // W of page instead of E of axis
//myshipout();


// Write the title.
label(minipage("\centering Period Squared v. Length for a Pendulum\\ with a 14.6~g Bob and a 10${}^\circ$ Amplitude", (graph_grid_to_coords*(xmax,0)).x), graph_grid_to_coords*(xmid,ymax+3), S);
//myshipout();

void xtick(real x_grid, real x_label, string fmt="%f") {
  static real tickhalflength = .15;
  draw(graph_grid_to_coords*((x_grid,-tickhalflength)--(x_grid,tickhalflength)));
  label(format(fmt,x_label), graph_grid_to_coords*((x_grid,-tickhalflength)), S);
}
void ytick(real y_grid, real y_label, string fmt="%.2g") {
  static real tickhalflength = .15;
  draw(graph_grid_to_coords*((-tickhalflength,y_grid)--(tickhalflength,y_grid)));
  label(format(fmt,y_label), graph_grid_to_coords*((0,y_grid)), W, defaultpen()+fontsize(16));
}

// Make a zero tick on each axis.
xtick(0,0);
ytick(0,0);
//myshipout();

// Decide on a scale for the vertical axis. 38 grid boxes; max value = 
int vert_grid_skip = 3;
real vert_var_skip = .4;

for(int y=vert_grid_skip; y < ymax; y+=vert_grid_skip) {
  ytick(y, y*vert_var_skip/vert_grid_skip);
}
//myshipout();

// Decide on a scale for the horizontal axis. 30 grid boxes; max value = 
int hori_grid_skip = 5;
real hori_var_skip = 20;
for(int x=hori_grid_skip; x < xmax; x+=hori_grid_skip) {
  xtick(x, x*hori_var_skip/hori_grid_skip);
}
//myshipout();

// Setup graph scale
transform graph_to_coords = graph_grid_to_coords*scale(hori_grid_skip/hori_var_skip,vert_grid_skip/vert_var_skip);

// Plot points
real y;
write("Length/cm\tPeriod squared/s^2");
write("---------\t------------------");
for(real x=10; x<=115; x+=10) {
  y = (2*pi)*(2*pi)*(x/100)/9.8; // formula for pendulum periodsquared for small angle amplitude.
  write(format(x,"%.3f")+"\t"+format(y,"%.3f"));
  dot(graph_to_coords*(x,y),defaultpen()+linewidth(4));
}
//myshipout();

// Draw vertical error bars
path vertical_error_bars = (0,-1)--(0,1);
real dy=0;
for(real x=10; x<=115; x+=10) {
  y = 2*pi*sqrt((x/100)/9.8); // formula for pendulum period for small angle amplitude.
  dy = 2*y*.03;
  draw(graph_to_coords*shift(x,y*y)*scale(dy)*vertical_error_bars,Bars(barsize(defaultpen())/4));
}
//myshipout();


// Draw horizontal error bars
path horizontal_error_bars = (-1,0)--(1,0);
for(real x=10; x<=115; x+=10) {
  y = 2*pi*sqrt((x/100)/9.8); // formula for pendulum period for small angle amplitude.
  draw(graph_to_coords*shift(x,y*y)*scale(1)*horizontal_error_bars,Bars(barsize(defaultpen())/4));
}
//myshipout();
myshipout(set_counter=16);

// Draw best-fit straight line
draw(graph_to_coords*((0,0)--(124,(124.0/100)*(2*pi)*(2*pi)/9.8)),bfsl_p);
myshipout();

// Mark two points at grid intersections
draw(circle(graph_to_coords*(0,0),0.125cm),burnt_orange_p);
draw(circle(graph_to_coords*(116,4.66666666666),0.125cm),burnt_orange_p);
myshipout();

// Write the mathematical model
label("\mathversion{bold}$T^2=\left(0.0402\,\textbf{s}^2\cdot\textbf{cm}^{-1}\right)L+0\,\textbf{s}^2$",graph_to_coords*(30,1),SE,burnt_orange_p);
myshipout(set_counter=21);
