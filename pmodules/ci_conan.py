import sys
import os
import platform
from pathlib import Path
from xml.etree import ElementTree as ET

class Conan():
    '''
    system
    cmake_path  //cmake module directory
    xml_file    //store the whole recipes
    whole_libs  //libs dict load from xml_file
    '''
    def __init__(self, cpath):
        self.system = platform.system()
        self.cmake_path = Path(cpath)   
        self.xml_file = self.cmake_path.joinpath("/conan/graph/libs.xml")
        
        self.whole_libs = _create_whole_libs()
        
        
    def _create_whole_libs(self):
        tree = ET.parse(self.xml_file)
        root = tree.getroot()
        
        libs = root.findall("lib")
        subs = {}
        for lib in libs:
            sublibs = lib.findall("sublib")
            subss = []
            for sub in sublibs:
                subss.append(sub.attrib["name"])
            
            subs[lib.attrib["name"]] = subss
        return subs
        
    def build_recipes(recipes, channel, profile, xml_file, upload = True):
        params = {'name':'xxx', 'version':'0.0.0', 'profile':'linux', 'channel':'desktop/linux'}
        for recipe in recipes:
            seg = recipe.split('/')
            if len(seg) == 2:
                name = seg[0]
                version = seg[1]
                params['name'] = name
                params['version'] = version
                params['profile'] = profile
                params['channel'] = channel
                
                subs = create_sub_libs_from_xml(xml_file, name, version)
                invoke_conan_build(params, subs)
                if upload == True:
                    invoke_conan_upload(recipe, params['channel'])
    
     
