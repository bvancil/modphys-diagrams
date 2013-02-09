if(!settings.multipleView) settings.batchView=false;
settings.tex="xelatex";
defaultfilename="triangles-2";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import geometry;
void measureangles(triangle t) {
pen absentline = linetype(new real[] {0,50});
real anglecompression = 3;
real radius = markangleradius()/anglecompression;
markangle("\scriptsize$"+format("%.1f",t.alpha())+"^\circ$",t.B,t.A,t.C,absentline, radius=radius);
markangle("\scriptsize$"+format("%.1f",t.beta())+"^\circ$",t.C,t.B,t.A,absentline, radius=radius);
markangle("\scriptsize$"+format("%.1f",t.gamma())+"^\circ$",t.A,t.C,t.B,absentline, radius=radius);
}

unitsize(.5cm);
real a=8;
real b=10;
real c=12;
triangle t = triangleabc(a,b,c);
show(LA="$A'$",LB="$B'$",LC="$C'$",La=format("%f",a),Lb=format("%f",b),Lc=format("%f",c),t);
measureangles(t);
viewportsize=(542.02501pt,0);
