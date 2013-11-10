from visual import *

print("""
Two electrons approach each other at right angles.
Is the total E&M force on the two particles equal and opposite?
""")

# http://en.wikipedia.org/wiki/Jefimenko%27s_equations
# http://en.wikipedia.org/wiki/Li%C3%A9nard-Wiechert_Potentials


scene.height = scene.width = 1000
scene.background = color.white
scene.x = scene.y = 0
scene.forward = (-0.2,-0.2,-1)


speed = 0.5 # c (c=1)
e1 = sphere(pos=(-10,0,0), color=color.red, radius=0.4, charge=-1.0)
e1v = vector(1,0,0)
r1=[]
e2 = sphere(pos=(0,-10,0), color=color.blue, radius=0.4, charge=1.0)
e2v = vector(0,1,0)
r2=[]
dt = 0.05

def EB(q, r, t):
    k = 1/4/pi
    dr = q.pos - r
    tr = t - mag(dr)
    n = dr/mag(dr)
    
    
