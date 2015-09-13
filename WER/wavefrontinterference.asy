import graph;

real separation = 4.3 cm;
real wavelength = 1 cm;
pen S1_p = gray;
pen S2_p = black;

real width = 8.5 inch - 2 cm;
real height = 11 inch - 2 cm;

path boundary = (0,0)--(width,0)--(width,height)--(0,height)--cycle;

// Wave sources
pair S1 = (width/2+separation/2, height/2);
pair S2 = (width/2-separation/2, height/2);
dot(S1);
dot(S2);
for(real r=wavelength; r<height; r=r+wavelength) {
  draw(Circle(S1, r), S1_p); // crest for S1
  draw(Circle(S1, r-wavelength/2), S1_p+dashed); // trough for S1
  draw(Circle(S2, r), S2_p); // crest for S2
  draw(Circle(S2, r-wavelength/2), S2_p+dashed); // trough for S2
}

clip(boundary);
