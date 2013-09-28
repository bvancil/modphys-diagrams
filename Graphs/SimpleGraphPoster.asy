real page_width = 8.5 inch;
real page_height = 11 inch;
real font_size = 24pt;
pen base_p = NewCenturySchoolBook(series="bx")+fontsize(font_size);
pen axis_p = base_p+linewidth(2.0)+black;
pen annotation_p = base_p+linewidth(1.4)+cmyk(0,41,82,56); // sepia
real ymax = 10;
real xmax = 7.5;
real char_height = font_size;
real char_width = font_size*0.8;
pair start_at_zero = (-1.5,-1);
pair make_uniform_scales = (3,3);

usepackage("xcolor", options="usenames,dvipsnames,svgnames,x11names");
texpreamble("\colorlet{description}{RoyalBlue} \colorlet{unit}{ForestGreen} \colorlet{symbol}{red}"); 
size(page_width, page_height, keepAspect=true);


draw((0,ymax)--(0,0)--(xmax,0), axis_p, Arrows(TeXHead));

label("\begin{minipage}[t][3em][c]{4em}\centering{Start at zero.}\end{minipage}", start_at_zero, annotation_p);
label("$0$", (0,0), W, axis_p);
label("$0$", (0,0), S, axis_p);
draw((start_at_zero+(0,.5)){up}..{right}(-0.35,0), annotation_p, Arrow);
draw((start_at_zero+(.6,0)){right}..{up}(0,-0.45), annotation_p, Arrow);

label("\begin{minipage}[t][3em][c]{7em}\centering{Make uniform scales.}\end{minipage}", make_uniform_scales, annotation_p);

draw((make_uniform_scales+(0,1)){up}..{left}(0,ymax/2), annotation_p, Arrow);
draw((make_uniform_scales+(1,0)){right}..{down}(xmax/2,0), annotation_p, Arrow);

label("\textcolor{description}{Horizontal Variable Description}\textcolor{black}{/}\textcolor{unit}{Unit}",(xmax/2+.1,-1.5), annotation_p);
label("\textcolor{symbol}{Symbol}", (xmax,0), E, annotation_p);

label(rotate(90)*"\textcolor{description}{Vertical Variable Description}\textcolor{black}{/}\textcolor{unit}{Unit}", (-2,ymax/2), annotation_p);
label("\textcolor{symbol}{Symbol}", (0,ymax), N, annotation_p);

label("\color{description}\begin{minipage}[t][2.5in][c]{6in}\centering{Vertical Variable Description Versus Horizontal Variable Description Plus Context to Help the Audience Understand}\end{minipage}", (xmax/2,ymax), N, annotation_p);
