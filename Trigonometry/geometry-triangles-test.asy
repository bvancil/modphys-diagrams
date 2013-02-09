import geometry;
size(10cm);

currentcoordsys=cartesiansystem(i=(1,0.5),j=(-.25,.75));
show(currentcoordsys);

triangle t = triangleabc(3,4,5, (1,1));
show(La="3", Lb="4", Lc="5", t);
perpendicularmark(t.CA,t.CB);

triangle t = triangleAbc(-60,2,3,angle=45,(0,6));
show(LA="$X$",LB="$Y$",LC="$Z$",La="$x$",Lb="2",Lc="3",t);
markangle("$60^\circ$",t.C,t.A,t.B, Arrow);
