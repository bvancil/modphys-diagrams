import motionmap;

real s1(real t)
{
  if (t < 4) return 3+t;
  if (t < 6) return 7-3*(t-4);
  if (t < 7) return 1-1*(t-6);
  if (t < 10) return 0;
  return 0+2*(t-10);
}
make_motion_map("1", s1, 12, grayscale=false);
