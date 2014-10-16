import "./position-versus-timer_reading_graph" as posgraph;

real s1(real t)
{
  if (t<2) return 4-2*t;
  if (t<3) return 0;
  if (t<6) return 0+1*(t-3);
  if (t<8) return 3+1.5*(t-6);
  return 6;
}
make_pos_graph("1", s1, 0, 10);

real s2(real t)
{
  if (t<5) return 2-t/5;
  if (t<7) return 1-(t-5)/2;
  return 1*(t-7);
}
make_pos_graph("2", s2, 0, 10);

real s3(real t)
{
  if (t<3) return 4;
  if (t<5) return 4-2*(t-3);
  if (t<8) return 0+(t-5)*5/3;
  return 5;
}
make_pos_graph("3", s3, 0, 10);

real s4(real t)
{
  if (t<3) return 1+t*2;
  if (t<4) return 7;
  if (t<8) return 7-(t-4)*7/4;
  return 0+(t-8)*1;
}
make_pos_graph("4", s4, 0, 10);
