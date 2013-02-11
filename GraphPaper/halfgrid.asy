real paperwidth = 8.5inches;
real paperheight = 11inches;
real width = paperwidth - 1inches; // margins
real height = (paperheight - 1inches - .5inches) / 2; // margins + spacing
real gridspacing = 1cm;
int nwidth = floor(width/gridspacing);
int nheight = floor(height/gridspacing);
width = nwidth*gridspacing; 
height = nheight*gridspacing;
size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw((gridspacing*i,0)--(gridspacing*i,height));
for(int j = 0; j <= nheight; ++j)
  draw((0,gridspacing*j)--(width,gridspacing*j));

