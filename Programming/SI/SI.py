def Leapfrog(txv0, dt, a):
    "http://en.wikipedia.org/wiki/Leapfrog_integration"
    t, x, v = txv0
    a0 = 0
    while(True):
        yield (t,x,v)
        t += dt
        a0 = a(x)
        x = x + dt*v+.5*dt*dt*a0
        v = v + dt*.5*(a0+a(x))

def SymplecticEuler(txv0, dt, a):
    "k=1 Symplectic Integrator AKA Euler-Cromer or Newton-Stormer-Verlet (NSV)"
    t, x, v = txv0
    while(True):
        yield (t,x,v)
        t += dt
        v += dt*a(x)
        x += dt*v

def Euler(txv0, dt, a):
    "k=0 Numerical Integrator"
    t, x, v = txv0
    while(True):
        yield (t, x, v)
        t += dt
        x, v = x+dt*v, v+dt*a(x)
        
def energy(pt):
    return .5*(pt[1]*pt[1]+pt[2]*pt[2])

def energy_mod(pt, dt):
    return .5*(pt[1]*pt[1]+pt[2]*pt[2]-dt*pt[1]*pt[2])

if __name__ == '__main__':
    def aho(x):
        "acceleration of a harmonic oscillator"
        return -x
    dt = .01
    # Examine energy
    #for pt in Euler((0,1,0),dt,aho):
    #for pt in SymplecticEuler((0,1,0),dt,aho):
    #    print energy(pt), energy_mod(pt,dt)
    
    # Examine instability of Euler's method
    #for pt in Euler((0,1,0),dt,aho):
    #    print pt
    # Examine period (Fro SymplecticEuler, Frequency will be a factor of (1+dt**2/24+O(dt**4)) times bigger, so period should be smaller by (1-dt**2/24+O(dt**4)))
    t = 0
    for pt in Leapfrog((0,1,0),dt,aho):
        if pt[1]>=.99997:
            print pt[0] - t, 2*3.141592653589/(1+dt*dt/24)
            print " .", pt
            print " E", energy(pt), energy_mod(pt,dt) 
            t = pt[0]
       
