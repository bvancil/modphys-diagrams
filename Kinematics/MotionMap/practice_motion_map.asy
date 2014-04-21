import motionmap;

real s1(real t)
{
  if (t<2) return 4-2*t;
  if (t<3) return 0;
  if (t<6) return 0+1*(t-3);
  if (t<8) return 3+1.5*(t-6);
  return 6;
}
//make_motion_map("1", s1, 10, grayscale=true);

real s2(real t)
{
  if (t<5) return 2-t/5;
  if (t<7) return 1-(t-5)/2;
  return 1*(t-7);
}
//make_motion_map("2", s2, 10, grayscale=true);

real s3(real t)
{
  if (t<3) return 4;
  if (t<5) return 4-2*(t-3);
  if (t<8) return 0+(t-5)*5/3;
  return 5;
}
//make_motion_map("3", s3, 10, grayscale=true);

real s4(real t)
{
  if (t<3) return 1+t*2;
  if (t<4) return 7;
  if (t<8) return 7-(t-4)*7/4;
  return 0+(t-8)*1;
}
make_motion_map("4", s4, 10, grayscale=true);

// N.B.  It's having trouble clearing old parts, so just compile one make_motion_map function per fun.
