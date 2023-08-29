import sys;
    
if __name__ == "__main__":
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../python/')
    
    origin_path = sys.path[0] + '/../../'
    print("algrithm auto check")
    print("origin_path: " + origin_path)
    
    import origin_path + '/demo/test.py'
    

    
    
    
    



