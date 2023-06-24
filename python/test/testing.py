import sys;

directory = sys.path[0]
sys.path.append(sys.path[0] + '/../')

import osSystem
import os
import SFTP

script_file = sys.argv[0]
target = sys.argv[1]
exe_file = sys.argv[2]
config_file = sys.argv[3]

print('testing : ' + script_file, flush=True)
print('testing : ' + target, flush=True)
print('testing : ' + exe_file, flush=True)
print('testing : ' + config_file, flush=True)

remote_prefix = ''
files = []

import json
with open(config_file, 'r') as f:
    data = json.load(f)
    if data.get("remote_prefix") != None:
        remote_prefix = data["remote_prefix"]
    
    if data.get("files") != None:
        files += data["files"]
        
    if data.get("range") != None:
        exec("values = " + data["range"])
        for i in values:
            files.append(str(i))
               

local_path, local_file_name = os.path.split(exe_file)
print('testing data path -> ' + local_path)

sftp = SFTP.createCXSFTP()

for file in files:
    local_file = local_path + '/' + file
    if not os.path.exists(local_file):
        remote_file = remote_prefix + file
        SFTP.getFile(sftp, remote_file, local_file)
    
    cmd = exe_file + ' ' + local_file
    osSystem.system(cmd)