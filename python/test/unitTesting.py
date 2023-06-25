import sys;

directory = sys.path[0]
sys.path.append(sys.path[0] + '/../')

import osSystem
import os

script_file = sys.argv[0]
exe_file = sys.argv[1]

print('testing : ' + script_file, flush=True)
print('testing : ' + exe_file, flush=True)

cmd = exe_file
osSystem.system(cmd)

import os
import matplotlib.pyplot as plt

#f = open(r'vertex_duplication.csv','r')
#data = list(f)
#print(data)
#f.close()
#v0 = []
#v1 = []
#for d in data:
#	v0.append(d.split()[0])
#	v1.append(d.split()[1])
#
#print(v0)
#print(v1)
#
#plt.plot(v0)
#plt.plot(v1)
#
#
#plt.savefig("vertex_duplication.png")
#plt.show()