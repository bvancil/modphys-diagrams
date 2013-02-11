pen grid_p = gray(0.8);
real paperwidth = 8.5inches;
real paperheight = 11inches;
real width = paperwidth - 3inches; // margins
real height = paperheight - 1inches; // margins 
real gridspacing = .5cm;
int nwidth = floor(width/gridspacing);
int nheight = floor(height/gridspacing);
width = nwidth*gridspacing; 
height = nheight*gridspacing;
size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw((gridspacing*i,0)--(gridspacing*i,height),grid_p);
for(int j = 0; j <= nheight; ++j)
  draw((0,gridspacing*j)--(width,gridspacing*j),grid_p);

