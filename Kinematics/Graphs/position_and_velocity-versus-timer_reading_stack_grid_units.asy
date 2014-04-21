/*******************************************************************************
Makes a position-versus-timer reading graph stacked on a velocity-versus
timer-reading graph from a list of $(\Delta t, v)$ pairs interpreted as
instructions to go for a duration $\Delta t$ at the constant velocity (CV)
$v$.
*******************************************************************************/
import math;
import graph;

/*******************************************************************************
 *******************************************************************************/

/*******************************************************************************
  CVInstruction holds one CV (constant velocity) instruction:
 a time_interval
 a velocity
 This is interpreted at traveling with a constant velocity for a time interval.
 *******************************************************************************/
struct CVInstruction {
  real time_interval;
  real velocity;
  
  void operator init(real time_interval, real velocity) {
	this.time_interval = time_interval;
	this.velocity = velocity;
  }
  void operator init(pair p) {
	// Interpret p.x as timer_interval and p.y as velocity
	this.time_interval = p.x;
	this.velocity = p.y;
  }
  real displacement() { return this.time_interval*this.velocity; }
  
}
/*
CVInstruction CVInstruction_from_pair(pair p) { // basic function to convert a pair to a CVInstruction
  
CVInstruction operator cast(pair p) { // enable casts from pair to CVInstruction
  return CVInstruction(p.x, p.y);
}
CVInstruction operator ecast(pair p) { // enable explicit casts from pair to CVInstruction
  return CVInstruction(p.x, p.y);
}
CVInstruction[] operator cast(pair[] ps) { // enable casts from pair[] to CVInstruction[]
  return map(new CVInstruction(pair p) { return CVInstruction(p.x, p.y); }, ps);
}
CVInstruction[] operator ecast(pair[] ps) { // enable explicit casts from pair[] to CVInstruction[]
  return map(new CVInstruction(pair p) { return CVInstruction(p.x, p.y); }, ps);
}
*/
/*******************************************************************************
Functions that operate on CVInstruction[]
 *******************************************************************************/
real[] shift(real[] xs, real a)
/* Return an array resulting from adding a to all elements of xs */
{
  return map(new real(real x) { return (x+a); }, xs);
}

struct PiecewiseCVTrip {
  real initial_position;
  CVInstruction[] instructions;
  // right now useful variables are dynamically generated, which is inefficient
  
  void operator init(real initial_position, CVInstruction[] instructions) {
	this.initial_position = initial_position;
	this.instructions = instructions;
  }
  
  real[] time_intervals() {
	return map(new real(CVInstruction instruction) { return instruction.time_interval; }, this.instructions);
  }
  real[] displacements() {
	return map(new real(CVInstruction instruction) { return instruction.displacement(); }, this.instructions);
  }
  real net_time_interval() {
	return sum(this.time_intervals());
  }
  real net_displacement() {
	return sum(this.displacements());
  }
  real[] timer_readings() {
	return partialsum(this.time_intervals());
  }
  real[] cumulative_displacements() {
	return partialsum(this.displacements());
  }
  real[] positions() {
	return shift(this.cumulative_displacements(), this.starting_position());
  }
  real final_position() {
	return this.initial_position + this.net_displacement();
  }
  real max_position() {
	return max(this.positions);
  }
  real min_positions() {
	return min(this.positions);
  }
	
}



/*******************************************************************************
*******************************************************************************/
typedef real realfunction(real); // "realfunction" is now the type of a function real(real), i.e. real->real
  
realfunction velocity_function(CVInstruction[] instructions) {
  real[] ending_timer_readings = timer_readings(instructions);
  real[] boundary_timer_readings = (new real[] {0}).insert(1,ending_timer_readings); // copy of ending_timer_readings but starting with 0
  return new real(real t) {
	int current_time_interval = search(boundary_timer_readings, t);
	
	int current_instruction = 0;
	int current_velocity;
	int current_time_interval;
	while (current_instruction < instructions.length) {
	  current_velocity = instructions[current_instruction].velocity;
	  current_time_interval = instructions[current_instruction].time_interval;
	  if (t < current_time_interval) {
		return current_velocity;
	  } else {
		t -= current_time_interval; // Set t to the offset past the current time interval.
	  }
	  ++current_instruction;
	}
  };
}

/*******************************************************************************
 *******************************************************************************/

realfunction position_function(pair[] instructions, real starting_position) {
  real[] starting_positions;
  
  return new real(real t) {

  };
}	

/*******************************************************************************
*******************************************************************************/
// boring code for stacking the graphs.  The only interesting part is the htick/vtick settings, which can be used to change the size of the horizontal and vertical units of the graphs.
void stack(picture pics[]) {
  real margin=0mm;
  real htick = .4cm;
  real vtick = .25cm;
  frame[] frames = new frame[pics.length];
  for(int i=0; i<pics.length; ++i) {
    unitsize(pics[i], htick, vtick);
    frames[i] = pics[i].fit();
    if (i>0) {
      frames[i] = shift(0,min(frames[i-1]).y-max(frames[i]).y-margin)*frames[i];
    }
    add(frames[i]);
  }
}

/*******************************************************************************
A small utility routine so that I can forget about the syntax of shipout calls.
 *******************************************************************************/
void myship(string suffix) {
  shipout(outprefix()+"_"+suffix); // outprefix() takes its name from the filename
}

/* Originally from a Geogebra to Asymptote conversion, documentation at artofproblemsolving.com/Wiki, go to User:Azjps/geogebra */
real xmin = 0, xmax = 10, ymin = 0, ymax = 6;  /* image dimensions */
real gridx = 1, gridy = 1; /* grid intervals */
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(14); defaultpen(dps); /* default pen style */
pen ticklabel_p = defaultpen+fontsize(12);
pen dotstyle = black; /* point style */ 
pen wqwqwq = rgb(0.3764705882352946,0.3764705882352946,0.3764705882352946); 
 /* draw grid of horizontal/vertical lines */
pen grid_p = linewidth(1.4) + wqwqwq + linetype("2 2");
pen worldline_p = linewidth(3.6);
pen axis_p = defaultpen+black+linewidth(1.4);


axis VZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.x.T(pic.scale.x.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 1; // relative position of axis label
    axis.side = left;
    axis.align = 1.5*E;
    axis.extend = extend;
    };
}
axis VZero = VZero();

axis HZero(bool extend=true) {
  return new void(picture pic, axisT axis) {
    axis.type = 0; // Value
    axis.value = pic.scale.y.T(pic.scale.y.scale.logarithmic ? 1 : 0); // I'm good with Linear 0
    axis.position = 1; // relative position of axis label
    axis.side = right;
    axis.align = W;
    axis.extend = extend;
    };
}
axis HZero = HZero();

/*******************************************************************************
 *******************************************************************************/
void kingraph(picture pic, Label vL="", real vMin=-6, real vMax=6, Label hL=Label("$t$/s",embed=Shift, align=4*E), real hMin=0, real hMax=12) {
  scale(pic, Linear, Linear);
  xlimits(pic, hMin, hMax);
  ylimits(pic, vMin, vMax);
  real[] hTicks_a = sequence(1, floor(hMax));
  real[] vTicks_a = sequence(floor(vMin), ceil(vMax));
  ticks hTicks = LeftTicks(format=Label(" ", align=E, p=ticklabel_p), Ticks=hTicks_a, extend=true, pTick=grid_p); // The space clears the labels on the ticks.
  ticks vTicks = RightTicks(format=Label(" ", align=W, p=ticklabel_p), Ticks=vTicks_a, extend=true, pTick=grid_p);
  xaxis(pic=pic, L="", axis=BottomTop, p=grid_p, ticks=hTicks);
  yaxis(pic=pic, L="", axis=LeftRight, p=grid_p, ticks=vTicks);
  xaxis(pic=pic, L=hL, axis=VZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(4), above=true);
  yaxis(pic=pic, L=vL, axis=HZero(false), p=axis_p, ticks=NoTicks, arrow=Arrow(4), above=true);
}

/*******************************************************************************
 *******************************************************************************/
void make_all_kinematic_stacks(string suffix, CVInstruction[] instructions, real starting_position, Label tL=Label("$t$/s", embed=Shift, align=4*E), Label positionL=rotate(0)*Label("$\vec{s}$/m",align=3*N), Label velocityL=rotate(0)*Label("$\vec{v}$/(m/s)", align=3*N))
{
  for(bool draw_position: new bool[] {false, true}) {
	for(bool draw_velocity: new bool[] {false, true}) {
	  make_kin_stack(suffix, instructions, starting_position, tL, positionL, velocityL, draw_position, draw_velocity);
	}
  }
}

							   
void make_kin_stack(string suffix, CVInstruction[] instructions, real starting_position, Label tL=Label("$t$/s", embed=Shift, align=4*E), Label positionL=rotate(0)*Label("$\vec{s}$/m", align=3*N), Label velocityL=rotate(0)*Label("$\vec{v}$/(m/s)",align=3*N), bool draw_position = true, bool draw_velocity = true)
{
  string new_suffix = suffix;
  if (draw_position) suffix += "_pos";
  if (draw_velocity) suffix += "_vel";
  picture pos_pic;
  picture vel_pic;
  pos_function = position_function(instructions, starting_position);
  vel_function = velocity_function(instructions);
  erase();
  size(10.91310503944411cm);
  
  make_kin_graph(pos_pic,suffix=suffix, graph_function=pos_function, t0, t1, hL=tL, vL=positionL, draw_graph = draw_position);
  make_kin_graph(vel_pic,suffix=suffix, graph_function=pos_function, t0, t1, hL=tL, vL=velocityL, draw_graph = draw_velocity);

  stack(new picture[] {pos_pic, vel_pic});
  myship(new_suffix);
}

void make_kin_graph(picture pic, string suffix, realfunction graph_function, real t0, real t, Label hL=Label("$t$/s", embed=Shift, align=4*E), Label vL=rotate(0)*Label("$\vec{s}$/m",align=3*N), bool draw_graph = true)
{
  erase();
  draw(graph(graph_function, t0, t1), worldline_p);

  ticks hTicks = LeftTicks(format=Label(" ", align=E, p=ticklabel_p), Step=1, extend=true, pTick=grid_p); // The space clears the labels on the ticks.
  ticks vTicks = RightTicks(format=Label(" ", align=W, p=ticklabel_p), Step=1, extend=true, pTick=grid_p);
  xaxis(L="", axis=BottomTop, xmin=0, p=grid_p, ticks=hTicks);
  yaxis(L="", axis=LeftRight, ymin=0, p=grid_p, ticks=vTicks);
  hTicks = Ticks(format=Label("", align=E, p=ticklabel_p), ticklabel=null, Step=1, Size=2);
  vTicks = Ticks(format=Label("", align=W, p=ticklabel_p), ticklabel=null, Step=1, Size=2);
  xaxis(L=hL, axis=VZero(false), xmin=0, p=axis_p, ticks=hTicks, arrow=Arrow(6), above=true);
  yaxis(L=vL, axis=HZero(false), ymin=0, p=axis_p, ticks=vTicks, arrow=Arrow(6), above=true);
  
  return;
}


	
/*
Usage:

We'd like to give instructions as $(\Delta t, v)$ pairs, which are coerced into CVInstruction's.

CVInstruction[] p1 = {(2,5),(3,-3)}; // CVPM $(\Delta t,v)$ pairs
make_all_kinematic_stacks("1", p1);

*/


