real paperwidth = 8.5inches;
real paperheight = 11inches;
real iwidth = paperwidth - 1inches; // margins
real iheight = (paperheight - 1inches - .5inches) / 2; // margins + spacing
size(iwidth, iheight);
real width = iwidth - 2cm;
real height = iheight - 3cm; // tuned
real xoffset = 2cm;
real yoffset = 2cm;
real titlesize=5cm;
draw(((width-titlesize)/2+xoffset,iheight)--((width+titlesize)/2+xoffset,iheight),yellow);
draw(((width-titlesize)/2+xoffset,iheight-1cm)--((width+titlesize)/2+xoffset,iheight-1cm));
real axislabelsize = 4cm;
draw((0,(height-axislabelsize)/2+yoffset)--(0,(height+axislabelsize)/2+yoffset),yellow);
draw((1cm,(height-axislabelsize)/2+yoffset)--(1cm,(height+axislabelsize)/2+yoffset));
draw(((width-axislabelsize)/2+xoffset,1cm)--((width+axislabelsize)/2+xoffset,1cm),yellow);
draw(((width-axislabelsize)/2+xoffset,0)--((width+axislabelsize)/2+xoffset,0));
real gridspacing = 1cm;
int nwidth = floor(width/gridspacing);
int nheight = floor(height/gridspacing);
width = nwidth*gridspacing; 
height = nheight*gridspacing;

for(int i = 0; i <= nwidth; ++i)
  draw((gridspacing*i+xoffset,yoffset)--(gridspacing*i+xoffset,height+yoffset));
for(int j = 0; j <= nheight; ++j)
  draw((xoffset,gridspacing*j+yoffset)--(width+xoffset,gridspacing*j+yoffset));

