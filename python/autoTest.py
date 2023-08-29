import sys
import osSystem

origin_path = sys.path[0] + '/../../'
bin_path = origin_path + 'linux-build/bin/Release/'

def execute_test(name):
    cmd = bin_path + name
    osSystem.system(cmd)