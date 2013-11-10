//pen lines_p = rgb(0.25490196078431371,0.41176470588235292,0.88235294117647056)+white; //lightened royalblue(web)
pen lines_p = white;
//real aspectratio = 1440/900;
real aspectratio = 16/9;
real correction = 293/351; // if projecting 4:3
real correction = 1; // if projecting 16:9
real hgridspacing = .5cm;
real vgridspacing = hgridspacing*correction; // correction for non-square projection
int nheight = 42;
int nwidth = round(nheight*aspectratio*correction);
real height = nheight*vgridspacing;
real width = nwidth*hgridspacing; 
fill(scale(width,height)*unitsquare, black); // black background
size(width, 0);
for(int i = 0; i <= nwidth; ++i)
  draw((hgridspacing*i,0)--(hgridspacing*i,height),lines_p);
for(int j = 0; j <= nheight; ++j)
  draw((0,vgridspacing*j)--(width,vgridspacing*j),lines_p);


