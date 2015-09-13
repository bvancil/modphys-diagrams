import graph;

defaultpen(fontsize(10));
pen thick_p = linewidth(1);
pen circle_p = thick_p+black;
pen radial_p = black;
pen radial_accent_p = linewidth(1)+radial_p;
pen degree_p = black;

real r1 = 4 cm;
real r2 = 2 cm;
real r3 = 1.5 cm;
real r4 = 0.5 cm;
real r5 = 0.1 cm;

real tick_factor = 1.03;
real small_tick_factor = sqrt(tick_factor);

pen thin=linewidth(0.5*linewidth());

int reduced_angle(int angle) {
  return abs(90-abs(90-abs(90-abs(90-angle))));
}
string angle_label;
for(int angle = 0; angle < 360; ++angle) {
  
  if (angle % 5 > 0) { // multiple of 1 but not a multiple of 5 
	draw(r2*dir(angle)--r1*small_tick_factor*dir(angle),radial_p); // outer ticks
  }
  if (angle % 5 == 0) { // multiple of 5
	angle_label = format("%2d",reduced_angle(angle))+"${}^{\circ}$";
	draw(r2/tick_factor*dir(angle)--r1*tick_factor*dir(angle),radial_accent_p); // outer ticks
	label(rotate(angle)*Label(angle_label),tick_factor*r1*dir(angle),dir(angle),degree_p); // outer labels
  }
  if ((angle % 5 == 0) && !(angle % 10 == 0)) { // multiple of 5 but not 10
	draw(r4*dir(angle)--r3*dir(angle),radial_p);
  }
  if (angle % 10 == 0) { // multiple of 10
	label(rotate(angle)*Label(angle_label),tick_factor*r3*dir(angle),dir(angle)/5,degree_p+fontsize(6)); // middle labels
	draw(r4*dir(angle)--r3*tick_factor*dir(angle),radial_accent_p);	
  }
  if ((angle % 30 == 0) && !(angle % 90 == 0)) { // multiple of 30 but not 90
   	draw(r5/tick_factor*dir(angle)--r4*tick_factor*dir(angle),radial_p);
  }
  if (angle % 90 == 0) { // multiple of 90
   	draw((0,0)--r5/tick_factor*dir(angle),radial_p);
   	draw(r5/tick_factor*dir(angle)--r4*tick_factor*dir(angle),radial_accent_p);
  }
}

draw(Circle((0,0),r1),circle_p);
draw(Circle((0,0),r2),circle_p);
draw(Circle((0,0),r3),circle_p);
draw(Circle((0,0),r4),circle_p);
draw(Circle((0,0),r5),circle_p);


