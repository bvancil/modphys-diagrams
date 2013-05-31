# Run under VIDLE3.2
from visual import * #VPython
from visual.graph import * # import graphing features 
import numpy # to use "arange" and "linspace"

def derivative(f):
    "returns a function that evaluates to the numerical 2nd derivative of the given function"
    dt = 1e-2 #seconds: numerical step
    def _Df(t):
        #return (f(t+dt)-f(t))/dt # one-sided
        return (f(t+dt)-f(t-dt))/dt/2 # order O(dt^2)
        #return (-f(t+2*dt)+8*f(t+dt)-8*f(t-dt)+f(t-2*dt)) # order O(dt^4)
    return _Df
def derivative2(f):
    "returns a function that evaluates to the numerical 2nd derivative of the given function"
    dt = 1e-2 #seconds: numerical step
    def _DDf(t):
        #return (f(t+dt)+f(t-dt)-2*f(t))/(dt*dt) # order O(dt^2)
        #return (-f(t+2*dt)+16*f(t+dt)-30*f(t)+16*f(t-dt)-f(t-2*dt))/(12*dt*dt) # order O(dt^4)
        Df = derivative(f); return (Df(t+dt)-Df(t))/dt #one-sided
    return _DDf
    #TODO: still has problems with constant velocity motion at the boundary to intervals

class AnimatedPositionGraph(object):
    t_domain = (0, 10)
    t_interval = 1 # for points
    path_t_interval = 0.05
    num_points = round((t_domain[1]-t_domain[0])/t_interval)+1
    t_array = numpy.linspace(t_domain[0], t_domain[1], num=num_points)
    # axes
    t_axis_text = "timer reading"
    pos_axis_text = "position"
    axis_c = color.gray(0.8)
    axis_shaftwidth = 0.02
    axis_opacity = 0.2
    # graph path
    path_c = color.white
    path_radius = 0.01
    # marked points on graph
    point_c = (0.5,0.5,1) # light blue
    point_radius = 0.1
    # velocity vectors
    vector_shaftwidth = 0.1
    vector_c = (0,0.6,0) # green
    displacement_t_interval = 0.6 # for drawing velocity arrows
    # homotopy parameters
    a = 1 # horizontal homotopy parameter
    b = 1 # vertical homotopy parameter
    def __init__(self, position_function):
        self.pos_f = position_function
        self.vel_f = derivative(self.pos_f)
        self.acc_f = derivative2(self.pos_f)
        self.pos_array = list(map(self.pos_f, self.t_array))
        self.vel_array = list(map(self.vel_f, self.t_array))
        self.acc_array = list(map(self.acc_f, self.t_array))
        self.point_array = []
        for t in self.t_array:
            self.point_array.append(self.point(t))
        #self.draw_gdisplay_all()
        #self.draw_display_all()
        self.animate_all()
    def point(self,t):
        return (self.a*t, self.b*self.pos_f(t), 0)
    def draw_gdisplay_all(self):
        "draw on the gdisplay graph"
        self.path = gcurve(color=self.path_c)
        for t in arange(self.t_domain[0], self.t_domain[1], self.path_t_interval):
            self.path.plot(pos=self.point(t))
        self.dots = gdots(color=self.point_c, size=10)
        self.point_array = []
        #self.sphere_array = []
        for t in self.t_array:
            point = self.point(t)
            self.point_array.append(point)
            #self.sphere_array.append(sphere(pos=point, radius=self.point_radius, color=self.point_c))
            self.dots.plot(pos=self.point(t))
    def draw_axes(self):
        self.t_axis = arrow(pos=(0,0,0), axis=(11,0,0), shaftwidth=self.axis_shaftwidth, color=self.axis_c, opacity=self.axis_opacity)
        self.t_axis_label = label(pos=(11.1,0,0), text=self.t_axis_text, xoffset=1, line=False, box=False)
        self.pos_axis = arrow(pos=(0,0,0), axis=(0,11,0), shaftwidth=self.axis_shaftwidth, color=self.axis_c, opacity=self.axis_opacity)
        self.pos_axis_label = label(pos=(0,11.3,0), text=self.pos_axis_text, xoffset=1, line=False, box=False)
    def animate_path(self, points=True, animation_rate=0):
        self.path = sphere(radius=self.path_radius,color=self.path_c,make_trail=True)
        self.point_array = []
        self.sphere_array = []
        next_point_n = 0
        next_point_t = self.t_array[next_point_n]
        for t in arange(self.t_domain[0], self.t_domain[1], self.path_t_interval):
            self.path.pos=self.point(t)
            if t >= next_point_t:
                point = self.point(next_point_t)
                self.point_array.append(point)
                self.sphere_array.append(sphere(pos=point, radius=self.point_radius, color=self.point_c))
                next_point_n += 1
                next_point_t = self.t_array[next_point_n]
        if t < next_point_t: # in case arange does something weird and doesn't get to the last point
            point = self.point(next_point_t)
            self.point_array.append(point)
            self.sphere_array.append(sphere(pos=point, radius=self.point_radius, color=self.point_c))    
    def draw_path(self):
        self.path = sphere(radius=self.path_radius,color=self.path_c,make_trail=True)
        for t in arange(self.t_domain[0], self.t_domain[1], self.path_t_interval):
            self.path.pos=self.point(t)
    def draw_display_all(self):
        # Draw on the display:
        self.draw_axes()
        self.animate_path()
        self.draw_vectors()
    def draw_points(self,animation_rate=0):
        self.sphere_array = []
        for t in self.t_array:
            if animation_rate>0: rate(animation_rate)
            point = self.point(t)
            self.sphere_array.append(sphere(pos=point, radius=self.point_radius, color=self.point_c, make_trail=True))
    def update_point(self, i):
        t = self.t_array[i]
        self.sphere_array[i].pos = self.point(t)
    def update_points(self,animation_rate=0):
        for i in range(0,self.num_points):
            if animation_rate>0: rate(animation_rate)
            self.update_point(i)
    def draw_vectors(self,animation_rate=0):
        self.vector_array = []
        self.vector_tip_array = []
        for i in range(0,self.num_points):
            if animation_rate>0: rate(animation_rate)
            t = self.t_array[i]
            point = self.point(t)
            vec = (self.a*self.displacement_t_interval, self.b*self.displacement_t_interval*self.vel_array[i],0)
            tip = tuple(array(point)+array(vec))
            self.vector_array.append(arrow(pos=point, axis=vec, shaftwidth=self.vector_shaftwidth, color=self.vector_c))
            self.vector_tip_array.append(sphere(pos=tip, radius=0, color=self.vector_c, make_trail=True))
    def update_vector(self, i):
        t = self.t_array[i]
        vector = self.vector_array[i]
        point = self.point(t)
        vec = (self.a*self.displacement_t_interval, self.b*self.displacement_t_interval*self.vel_array[i], 0)
        tip = tuple(array(point)+array(vec))
        vector.pos = point
        vector.axis = vec
        self.vector_tip_array[i].pos=tip
    def update_vectors(self,animation_rate=0):
        for i in range(0,self.num_points):
            if animation_rate>0: rate(animation_rate)
            self.update_vector(i)
    def animate_all(self):
        self.narration = label(pos=(6,-4,0),text='To make a Motion Map from a Position-vs-Timer-reading Graph...', color=color.red, xoffset=1, yoffset=1, line=False, box=False, border=0)
        self.draw_axes()
        self.draw_path()
        # Mark time axis uniformly
        self.narration.text += "\n1. Mark off the timer reading axis uniformly."
        self.a = 1 # starting horizontal scale
        self.b = 0 # squish flat vertically
        self.draw_points(animation_rate=1.5)
        # Mark the corresponding points on the graph
        self.narration.text += "\n2. Mark points on the graph for those timer readings."
        # Raise all at once
##        for self.b in arange(0,1,0.01):
##            rate(50)
##            self.update_points()
##        self.b = 1 #should be 1 already
##        self.update_points()
        # OR
        # Raise one point at a time:
        for i in range(0,self.num_points):
            for self.b in arange(0,1,0.01):
                rate(100)
                self.update_point(i)
            self.b = 1 #should be 1 already
            self.update_point(i)
        # Draw velocity vectors
        self.narration.text += "\n3. Draw little slope vectors with equal horizontal components."
        self.b = 0
        self.draw_vectors()
        for self.b in arange(0,1,0.01):
            rate(30)
            self.update_vectors()
        self.b = 1 #should be 1 already
        self.update_vectors()
        # Push the points to the vertical axis:
        self.narration.text += "\n4. Read off the positions for those points."
        # Shift one point at a time:
        for i in range(0,self.num_points):
            for self.a in arange(1,0,-0.01):
                rate(100)
                self.update_point(i)
            self.a = 0 #should be 0 already
            self.update_point(i)         
        # Push the vectors to the vertical axis:
        self.narration.text += "\n5. Read off the vertical components of each vector."
        for self.a in arange(1,0,-0.01):
            rate(30)
            self.update_vectors()
        self.a = 0 #should be 0 already
        self.update_vectors()
        # Get rid of the rest of the graph and rotate:
        self.narration.text += "\n6. Rotate the position axis to get a motion map."
        
        
##gd = gdisplay(x=5, y=5, width=600, height=400, 
##      title='Position versus timer reading', xtitle='time/s', ytitle='position/m', 
##      foreground=color.white, background=color.black, 
##      xmax=10, xmin=0, ymax=10, ymin=0)
scene = display(title='Creating a Motion Map from a Position-vs-Timer-reading graph', width=600, height=700, center=(6.5,4,0), range=(8,8,10))

# Use the machinery:
def position1(t):
    "Speeding up from rest then constant velocity, then slowing down."
    d=10 #meters total distance
    t1=t3=4 #seconds
    t2=2 #seconds
    T=t1+t2+t3# seconds total
    v_avg = d/T #m/s
    v_max = d/(0.5*(t2+T)) #m/s: from the area of the trapezoid v-t graph
    a1 = v_max/t1
    a3 = -v_max/t3
    if t<=t1:
        return 0.5*a1*t*t
    s1 = 0.5*a1*t1*t1
    t -= t1
    if t<=t2:
        return s1+v_max*t
    s2 = s1+v_max*t2
    t -= t2
    return s2+v_max*t+0.5*a3*t*t

g = AnimatedPositionGraph(position1)


