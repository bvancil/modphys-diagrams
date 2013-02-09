import settings;
outformat="png";
import fontsize;
size(10cm,0);
defaultpen(fontsize(24)+linewidth(2));

pair O=(0,0),u=(1,1), v=(2,5), w=(-1,2);

dot(O);
draw(O--u,Arrow);
draw(O--v,Arrow);
draw(O--w,Arrow);
draw(O--(-u),Arrow);
draw(O--unit(-v)*length(u),Arrow);
draw(O--(-w),Arrow);
draw(O--(u-w),Arrow);
label("A",u,unit(u));
label("B",v,unit(v));
label("C",w,unit(w));
label("D",-u,unit(-u));
label("E",unit(-v)*length(u),unit(-v));
label("F",-w,unit(-w));
label("G",u-w,unit(u-w));

