import sys
import os
import getopt
import platform
import subprocess
from pathlib import Path

class CMake():
    '''
    system
    origin_path
    project_path
    cmake_args  (-DCXX_VLD=ON/OFF vld debug   
                 -DRENDER_DOC=ON/OFF renderdoc debug
                )
    '''
    def __init__(self):
        self.system = platform.system()
        self.origin_path = Path(sys.path[0] + '/../../')
        
        self._parse_args()
        self._calculate_project_path()
        
    def _parse_args(self):
        self.cmake_args = ""
        #parse args
        try:
            opts, args = getopt.getopt(sys.argv[1:], '',['cmake_args='])
            print("getopt.getopt -> :" + str(opts))
        except getopt.GetoptError:
            print("_parse_args error.")
            sys.exit(2)
        for opt, arg in opts:
            if opt in ('--cmake_args'):
                self.cmake_args = arg      
        
    def _calculate_project_path(self):
        suffix = 'win32-build/build/'
        self.project_path = self.origin_path.joinpath(suffix)
        if not self.project_path.exists():
            self.project_path.mkdir()
            
    def print(self):
        print("system : {}".format(self.system))
        print("source root : {}".format(self.origin_path))
        print("project path : {}".format(self.project_path))
        print("cmake args : {}".format(self.cmake_args))
        
    def build(self):
        cmake_str = "cmake -S {} -B {} -DCMAKE_USE_CONAN=ON".format(self.origin_path, self.project_path)
        system_str = ' -G "Visual Studio 16 2019" -T host=x64 -A x64 {}'.format(self.cmake_args)
        cmd = cmake_str + system_str
        
        print("start build: {}".format(cmd))
        os.system(cmd)
    
        
