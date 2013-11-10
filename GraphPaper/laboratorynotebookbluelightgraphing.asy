pen lines_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+white+linewidth(1.2); //lightened royalblue(web)
pen axes_p = rgb(0,0.13725490196078433,0.4)+linewidth(1.4); // royalblue
real paperwidth = 17.5cm;
real paperheight = 22.5cm;
real width = paperwidth - 0cm; // margins
real height = paperheight - 0cm; // margins 
real gridspacing = .5cm;
int nwidth = round(width/gridspacing);
int nheight = round(height/gridspacing);
width = nwidth*gridspacing; 
height = nheight*gridspacing;
size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw((gridspacing*i,0)--(gridspacing*i,height),lines_p);
for(int j = 0; j <= nheight; ++j)
  draw((0,gridspacing*j)--(width,gridspacing*j),lines_p);
draw(scale(gridspacing)*((4,nheight-3)--(4,4)--(nwidth,4)),axes_p,Arrows(DefaultHead,0.6*arrowsize(axes_p))); // makes a 31 by 38 graph

