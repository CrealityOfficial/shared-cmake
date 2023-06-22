import sys;

directory = sys.path[0]
sys.path.append(sys.path[0] + '/../')

import osSystem
import os
import SFTP

script_file = sys.argv[0]
exe_file = sys.argv[1]
config_file = sys.argv[2]

print('testing : ' + script_file)
print('testing : ' + exe_file)
print('testing : ' + config_file)

remote_prefix = '/model/'
files = ['dental1.stl', 'cylinder.STL']
local_path = sys.path[0] + '/../../../../data/'

sftp = SFTP.createCXSFTP()

for file in files:
    local_file = local_path + file
    if not os.path.exists(local_file):
        remote_file = remote_prefix + file
        SFTP.getFile(sftp, remote_file, local_file)
    
    cmd = exe_file + ' ' + local_file
    osSystem.system(cmd)