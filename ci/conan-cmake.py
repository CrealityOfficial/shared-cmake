import sys;

if __name__ == "__main__":
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../python/')

    import osSystem
    osSystem.conan_cmake()
    
    