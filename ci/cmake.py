import sys;

directory = sys.path[0]
sys.path.append(sys.path[0] + '/../python/')
sys.path.append(sys.path[0] + '/../pmodules/')

import ci_cmake
cmake = ci_cmake.CMake()

cmake.print()
cmake.build()