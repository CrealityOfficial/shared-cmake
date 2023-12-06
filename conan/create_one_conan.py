import sys;
sys.path.append(sys.path[0] + '/../python/')

import createUtil
import sys, getopt
import os

if __name__ == "__main__":
    directory = sys.path[0]
    argv = sys.argv[1:]
    xml_file = directory + "/graph/libs.xml"
    
    recipe = ''
    channel = ''
    upload = False
    tchannel = ''
    try:
        opts, args = getopt.getopt(argv,"r:c:u:t:")
    except getopt.GetoptError:
        print("create.py -n <name>")
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-r"):
            recipe = arg
        if opt in ("-c"):
            channel = arg
        if opt in ("-u"):
            if arg == "True":
                upload = True
        if opt in ("-t"):
            tchannel = arg
            
    libs = []
    libs.append(recipe)
    print('create recipes :' + str(libs))
    libDict = createUtil.create_base_libs_from_xml(xml_file)
    if not recipe in libDict.keys():
        sys.exit(-1)
        
    real_channel = createUtil.get_channel_from_type(channel)
    if tchannel != '':
        real_channel = tchannel
    createUtil.build_recipes(libs, real_channel, createUtil.get_profile_from_type(channel), xml_file, upload)