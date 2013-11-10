pen lines_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+white; //lightened royalblue(web)
real paperwidth = 17.5cm;
real paperheight = 22.5cm;
real width = paperwidth - 0cm; // margins
real height = paperheight - 0cm; // margins 
real gridspacing = .5cm;
int nwidth = round(width/gridspacing);
int nheight = round(height/gridspacing);
width = nwidth*gridspacing; 
height = nheight*gridspacing;
fill(scale(width,height)*unitsquare, black); // black background
size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw((gridspacing*i,0)--(gridspacing*i,height),lines_p);
for(int j = 0; j <= nheight; ++j)
  draw((0,gridspacing*j)--(width,gridspacing*j),lines_p);


