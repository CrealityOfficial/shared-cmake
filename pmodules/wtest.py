import ccglobal
t = ccglobal.Tracer()

import pw_trimesh
tt = pw_trimesh.TTracer()

fileName = "C:\\Users\\anoob\\code\\data\\model\\cylinder.STL"
print(pw_trimesh.load(fileName, tt))
print(pw_trimesh.load(fileName, t))
    
# ## test derived
#
#import pw_trimesh
#
#base = pw_trimesh.Base()
#
#class Derived(pw_trimesh.Base):
#    def f(self):
#        pass
#
#derived = Derived()
#
#print(pw_trimesh.useBase())
#print(pw_trimesh.useBase(base))
#print(pw_trimesh.useBase(derived))    