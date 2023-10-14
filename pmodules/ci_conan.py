import sys
import os
import getopt
import platform
import subprocess
from pathlib import Path

class Conan():
    '''
    system
    cmake_path  //cmake module directory
    '''
    def __init__(self, cpath):
        self.system = platform.system()
        self.cmake_path = Path(cpath)   
     
