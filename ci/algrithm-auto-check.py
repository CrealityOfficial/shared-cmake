import sys;
    
if __name__ == "__main__":
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../python/')

    import osSystem;

    origin_path = sys.path[0] + '/../../'
    script_path = origin_path + 'auto_scripts/'
    
    print('AUTO CHECK ....')
    print('origin_path : ' + origin_path)
    print('script_path : ' + script_path)
    
    autogen_path = origin_path + 'autocheck_generate'
    osSystem.mkdirs(autogen_path)
    
    import ReadWrite;
    print('doxygen ....')
    doxygen_config = autogen_path 
    user_config_file = script_path + 'doxygen.cfg'
    user_items = ReadWrite.parse_items(user_config_file, 'default')
    
    for key in user_items:  
        print(key + " : " + user_items[key])
    
    
    
    



