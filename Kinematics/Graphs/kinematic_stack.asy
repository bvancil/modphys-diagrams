import graph;

real margin=2mm;
real width = 5;
real height = 5;

picture picx;
scale(picx,Linear,Linear);
xlimits(picx,0,width);
ylimits(picx,0,height);
//xaxis(picx,"clock reading $t$", YZero,Arrow);
xaxis(picx,"$t$", YZero,Arrow);
//yaxis(picx,"position $x$", XZero,Arrow);
yaxis(picx,"$x$", XZero,Arrow);

picture picv;
scale(picx,Linear,Linear);
xlimits(picv,0,width);
ylimits(picv,-height/2,height/2);
//xaxis(picv,"clock reading $t$", YZero,Arrow);
xaxis(picv,"$t$", YZero,Arrow);
//yaxis(picv,"velocity $v$", XZero,Arrow);
yaxis(picv,"$v$", XZero,Arrow);

picture pica;
scale(pica,Linear,Linear);
xlimits(pica,0,width);
ylimits(pica,-height/2,height/2);
//xaxis(pica,"clock reading $t$", YZero,Arrow);
xaxis(pica,"$t$", YZero,Arrow);
//yaxis(pica,"acceleration $a$", XZero,Arrow);
yaxis(pica,"$a$", XZero,Arrow);

//xequals(picx,3,Dotted);
//xequals(picv,3,Dotted);
//xequals(pica,3,Dotted);

size(picx, 100, 100, point(picx,SW),point(picx,NE));
frame fx = picx.fit();
add(fx);
size(picv, 100, 100, point(picv,SW),point(picv,NE));
frame fv = picv.fit();
fv = shift(0,min(fx).y-max(fv).y-margin)*fv;
add(fv);
size(pica, 100, 100, point(pica,SW),point(pica,NE));
frame fa = pica.fit();
fa = shift(0,min(fv).y-max(fa).y-margin)*fa;
add(fa);



