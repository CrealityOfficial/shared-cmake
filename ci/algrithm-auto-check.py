import sys;

if __name__ == "__main__":
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../python/')

    origin_path = sys.path[0] + '/../../'
    script_path = origin_path + 'auto_scripts/'
    
    print('auto check ....')
    print('origin_path : ' + origin_path)
    print('script_path : ' + script_path)



