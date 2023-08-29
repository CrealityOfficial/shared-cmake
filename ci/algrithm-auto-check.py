import sys;
    
if __name__ == "__main__":
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../python/')
    
    origin_path = sys.path[0] + '/../../'
    bin_path = origin_path + 'linux-build/bin/Release/'
    
    print("algrithm auto check")
    print("origin_path: " + origin_path)
    
    import osSystem
    def execute_test(name):
        cmd = bin_path + name
        osSystem.system(cmd)
        
    sys.path.append(origin_path)
    import demo.test
    

    
    
    
    



