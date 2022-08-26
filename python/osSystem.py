import os
import sys, getopt
import tempfile
import shutil
import createUtil

def mkdirs(path_dir):
    if not os.path.exists(path_dir):
        os.makedirs(path_dir)
    
def system(cmd):
    os.system(cmd)

def working_path_from_ci(path):
    return path[0:-8]
    
def conan_install(working_path, project_path, channel):
    conan_file = project_path + '/conanfile.txt'
    graph_file = working_path + '/graph.txt'
    base_graph_file = working_path + '/cmake/conan/graph/libs.xml'
    
    createUtil.create_conan_file_from_graph(base_graph_file, graph_file, conan_file, channel)
    
    if os.path.exists(conan_file):
        cmd = 'conan install -g cmake_multi -s build_type=Debug -if ' + project_path + ' ' + project_path
        os.system(cmd)
        cmd = 'conan install -g cmake_multi -s build_type=Release -if ' + project_path + ' ' + project_path
        os.system(cmd)    
    
def win_conan_cmake(working_path):
    project_path = working_path + '/win32-build/build/'
    mkdirs(project_path)
      
    print("[cmake/ci] project path :" + project_path)
    conan_install(working_path, project_path, 'desktop/win')
    cmd = 'cmake -G "Visual Studio 16 2019" -DCMAKE_USE_CONAN=ON -S ' + working_path + ' -B ' + project_path
        
    os.system(cmd)
    
def conan_cmake():
    argv = sys.argv[1:]
    working_path = working_path_from_ci(sys.path[0])
    print("[cmake/ci] working path :" + working_path)
    
    work_type = 'win'
    try:
        opts, args = getopt.getopt(argv,"t:")
    except getopt.GetoptError:
        print("create.py -t <type>")
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-t"):
            work_type = arg
    
    if work_type == 'win':
        win_conan_cmake(working_path)
    elif work_type == 'linux':
        pass
    else:
        pass

#   
#