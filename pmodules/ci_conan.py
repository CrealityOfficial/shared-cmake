import sys
import os
import platform
import tempfile
import shutil
import executor
from pathlib import Path
from xml.etree import ElementTree as ET
import log
import json

class Conan():
    '''
    system      //Windows , Linux, Darwin
    cmake_path  //cmake module directory
    xml_file    //store the whole recipes
    whole_libs  //libs dict load from xml_file
    conan_path  //conan directory
    use_external_rep  //use github repository
    '''
    def __init__(self, cpath, logger):
        self.system = platform.system()
        self.cmake_path = Path(cpath).resolve()   
        self.xml_file = self.cmake_path.joinpath('conan', 'graph', 'libs.xml')
        self.conan_path = self.cmake_path.joinpath('conan')
        self.external_cmake_rep = 'https://github.com/CrealityOfficial/shared-cmake.git'
        self.use_external_rep = False
        self.logger = logger
        
        self.logger.info('conan context : cmake_path {}, xml_file {}, conan_path {}'.format(str(self.cmake_path), str(self.xml_file), str(self.conan_path)))
        self.whole_libs = self._create_whole_libs()
        self.internal_reps = {}
        self.github_reps = {}
    
    def set_use_external_rep(self, use):
        self.use_external_rep = use
    
    def get_recipe_url(self, name, use_github = False):
        url = ''
        if not use_github and name in self.internal_reps:
            return self.internal_reps[name]
        
        if use_github and name in self.github_reps:
            return self.github_reps[name]
            
        yml_file = self.conan_path.joinpath('recipes', 'trimesh2', 'conandata.yml')
        self.logger.info('open yml file : {}'.format(str(yml_file)))
        with open(str(yml_file), encoding='utf-8') as file:          
            lines = file.readlines()
            for line in lines:
                segs = line.split(':', 1)
                #self.logger.info(segs)
                if len(segs) == 2:
                    if segs[0] == 'repository':
                        self.internal_reps[name] = segs[1].strip()
                    if segs[0] == 'external_repository':
                        self.github_reps[name] = segs[1].strip()               
        if not name in self.internal_reps:
            self.internal_reps[name] = ''
        if not name in self.github_reps:
            self.github_reps[name] = ''
        return self.get_recipe_url(name, use_github)
        
    '''
    load whole libs from conan/graph/libs.xml
    '''    
    def _create_whole_libs(self):
        tree = ET.parse(str(self.xml_file))
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
        
    '''
    input patches, output libs chain 
    '''
    def _collect_sequece_libs(self, libDict, libs):
        result = []
        
        first = libs
        second = []
        while len(first) > 0:
            for value in first:
                nex = libDict[value]
                if len(nex) == 0:
                    result.append(value)
                else:
                    need = False
                    for nvalue in nex:
                        if nvalue not in result:
                            second.append(nvalue)
                            need = True
                    
                    if need == True:
                        second.append(value)
                    else:
                        result.append(value)
                    
            first = second
            second = []
        
        new_result = []
        for r in result:
            if r not in new_result:
                new_result.append(r)
            
        return new_result
    
    '''
    collect libs from a .txt file
    '''
    def _collect_libs_from_txt(self, file_name):
        libs = []
        with open(str(file_name), 'r') as file:
            contents = file.readlines()
            for content in contents:
                libs.append(content.rstrip())
                
            self.logger.info("{0} load recipes: {1}".format(file_name, libs))
            file.close()    
        return libs
        
    '''
    collect libs from a root .txt file, 
    it will interate the children directory
    '''
    def _collect_libs_from_root_txt(self, graph_file):
        libs = self._collect_libs_from_txt(Path(graph_file))
        children = Path(graph_file).parent.iterdir()
        for idx, element in enumerate(children):    
            if element.is_dir():
                child_graph_file = element.joinpath('graph.txt')
                
                if child_graph_file.exists() == True:
                    sub_libs = self._collect_libs_from_txt(child_graph_file)
                    libs.extend(sub_libs)
            
        return libs
    
    def _collect_project_libs(self):
        graph_txt = self.cmake_path.joinpath('..', 'graph.txt')
        subs = self._collect_libs_from_root_txt(graph_txt)
        return list(set(subs))
        
    '''
    upload conan package  recipe@channel
    '''
    def _conan_upload(self, recipe, channel):
        cmd = 'conan upload {}@{} -r artifactory --all -c'.format(recipe, channel)
        executor.run(cmd, False, self.logger)
    
    def recipe_2_name_version(self, recipe):
        segs = recipe.split('/')
        name = 'xxx'
        version = 'x.x.x'
        
        if len(segs) == 2:
            name = segs[0]
            version = segs[1]
            
        return name, version
        
    '''
    collect chain sub libs of one recipe
    '''
    def _collect_chain_sub_libs(self, recipe):
        result = []
        subs = self.whole_libs
        
        first = subs[recipe];
        second = []
        while len(first) > 0:
            for value in first:
                if value not in result:
                    result.append(value)
                    if value in subs:
                        nex = subs[value]
                        for nvalue in  nex:
                            if nvalue not in second:
                                second.append(nvalue)
                
            first = second
            second = []
        
        return result
    
    def _create_conan_1(self, recipe, profile, channel, sub_libs):
        with tempfile.TemporaryDirectory() as temp_directory:
            directory = str(self.conan_path)
            segs = recipe.split('/')
            name = 'xxx'
            version = 'x.x.x'
            
            if len(segs) == 2:
                name = segs[0]
                version = segs[1]
    
            if '{}/{}'.format(name, version) not in self.whole_libs:
                return
                
            self.logger.info("created temporary directory {0}".format(temp_directory))
            
            create_script_src = directory + "/scripts/conanfile.py"
            cmake_script_src = directory + "/scripts/CMakeLists.txt"
            meta_data_src = directory + "/recipes/" + name + "/conandata.yml";
            shutil.copy2(create_script_src, temp_directory)
            shutil.copy2(meta_data_src, temp_directory)
            shutil.copy2(cmake_script_src, temp_directory)
            
            meta_data_dest = temp_directory + "/conandata.yml"
            meta_file = open(meta_data_dest, "a")
            
            meta_file.write("version: " + "\"" + version + "\"\n")
            meta_file.write("name: " + "\"" + name + "\"\n")
            meta_file.write("channel: " + "\"" + channel + "\"\n")
            if self.use_external_rep == True:
                meta_file.write("use_external: true\n")
                meta_file.write("cmake_rep: \"{0}\"\n".format(self.external_cmake_rep))
                            
            meta_file.close()
            cmake_script_dest = temp_directory + "/CMakeLists.txt"
            cmake_file = open(cmake_script_dest, "a")
            cmake_file.write("add_subdirectory(" + name + ")")
            cmake_file.close()       
            sublibs_dest = temp_directory + "/requires.txt"
            subLibs_file = open(sublibs_dest, "w")
            for sub in sub_libs:
                subLibs_file.write(sub)
                subLibs_file.write('\n')
            subLibs_file.close() 
            
            #os.system("pause")
            debug_cmd = 'conan create --profile {} -s build_type=Debug {} {}'.format(profile, temp_directory, channel)
            executor.run(debug_cmd, True, self.logger)
            release_cmd = 'conan create --profile {} -s build_type=Release {} {}'.format(profile, temp_directory, channel)        
            executor.run(release_cmd, True, self.logger)             
        
    '''
    create one conan recipe package
    recipe xxx/x.x.x
    channel 
    '''
    def _create_one_conan_recipe(self, recipe, channel, upload):
        self.logger.info('_create_one_conan_recipe : [{0}]'.format(recipe))
        if recipe not in self.whole_libs:
            return
            
        sub_libs = self._collect_chain_sub_libs(recipe)
        self._create_conan_1(recipe, self._profile(), channel, sub_libs)
        
        if upload == True:
            self._conan_upload(recipe, channel)
    
    '''
    create one conan recipe package
    recipe xxx/x.x.x
    channel 
    '''
    def _create_conan_recipes(self, recipes, channel, upload):
        self.logger.info('_create_conan_recipes : {0}'.format(recipes))
        for recipe in recipes:
            self._create_one_conan_recipe(recipe, channel, upload)
    
    def _remove_packages(self, recipes, channel):
        for recipe in recipes:
            name = '{0}@{1}'.format(recipe, channel)
            if self._check_package(name) == True:
                self.logger.warning('remove package [{}]'.format(name))
                cmd = 'conan remove {0} -f'.format(name)        
                os.system(cmd)
    
    def _check_package(self, name):
        return executor.run('conan search {0}'.format(name))   
        
    '''
    type [linux mac win opensource-mac opensource-win opensource-linux]
    '''
    def _channel(self, channel_name='desktop'):
        '''
        if name == 'linux':
            channel = 'desktop/linux'
        if name == 'mac':
            channel = 'desktop/mac'
        if name == 'opensource-linux':
            channel = 'opensource/linux'
        if name == 'opensource-mac':
            channel = 'opensource/mac'  
        if name == 'opensource-win':
            channel = 'opensource/win' 
        if name == 'jwin':
            channel = 'jwin'
            
        '''
        prof = self._profile()
        prefix = channel_name
            
        channel = '{}/{}'.format(prefix, prof)
        return channel
        
    def _profile(self):
        '''
        profile = 'win'
        if name == 'linux' or name == 'opensource-linux':
            profile = 'linux'
        if name == 'mac' or name == 'opensource-mac':
            profile = 'mac'
        return profile           
        '''
        if self.system == 'Windows':
            return 'win'
        if self.system == 'Linux':
            return 'linux'
        if self.system == 'Darwin':
            return 'mac'
        return 'win'    
    
    def _write_conan_file(self, conanfile, libs, channel):
        '''
        write conan file
        '''
        file = open(str(conanfile), "w")
        file.write('[requires]\n')
        for lib in libs:
            file.write(lib + '@' + channel)
            file.write('\n')
        file.close()
    
    '''
    api , create from one, patches, subs, whole, project
    '''
    def create_from_patch_file(self, file_name, channel_name, upload, remove=False):
        subs = self._collect_libs_from_txt(str(self.conan_path) + file_name)
        if remove == True:
            self._remove_packages(subs, self._channel(channel_name))
            
        self._create_conan_recipes(subs, self._channel(channel_name), upload)

    def create_from_subs_file(self, file_name, channel_name, upload, remove=False):
        subs = self._collect_libs_from_txt(file_name)
        seq_subs = self._collect_sequece_libs(self.whole_libs, subs)
        if remove == True:
            self._remove_packages(seq_subs, self._channel(channel_name))
            
        self._create_conan_recipes(seq_subs, self._channel(channel_name), upload)
        
    def create_one(self, recipe, channel_name, upload, remove=False):
        libs = []
        libs.append(recipe)
        if remove == True:
            self._remove_packages(libs, self._channel(channel_name))        
 
        self._create_conan_recipes(libs, self._channel(channel_name), upload)
        
    def create_whole(self, channel_name, upload, remove=False):
        libs = self._collect_sequece_libs(self.whole_libs, self.whole_libs.keys())
        if remove == True:
            self._remove_packages(libs, self._channel(channel_name)) 
            
        self._create_conan_recipes(libs, self._channel(channel_name), upload)
        
    def create_project_conan(self, channel_name, upload, remove=False):
        graph_txt = self.cmake_path.joinpath('..', 'graph.txt')
        subs = self._collect_libs_from_root_txt(graph_txt)    
        libs = self._collect_sequece_libs(self.whole_libs, subs)
        if remove == True:
            self._remove_packages(libs, self._channel(channel_name)) 
            
        self._create_conan_recipes(libs, self._channel(channel_name), upload)

    def create_circle_conan(self, channel_name, upload):
        libs = self._collect_project_libs()
        creator = ConanCircleCreator(self) 
        creator.create_circle_recipes(libs, self._channel(channel_name)) 
        
    def _install(self, dest_path, libs, channel_name, update_from_remote=False):
        self.logger.info('conan install recipes : {0}'.format(str(libs)))
        conan_file = Path(dest_path).joinpath('conanfile.txt')  
        self.logger.info('conan install output : {}'.format(str(conan_file)))        
        self._write_conan_file(conan_file, libs, self._channel(channel_name))
        
        update_cmd = '--update' if update_from_remote else ''
        
        project_path = str(Path(dest_path))
        if os.path.exists(str(conan_file)):
            cmd = 'conan install  -g cmake_multi -s build_type=Debug --build=missing -if {0} {1} {2}'\
                        .format(project_path, project_path, update_cmd)
            executor.run(cmd, True, self.logger)
            cmd = 'conan install -g cmake_multi -s build_type=Release --build=missing -if {0} {1} {2}'\
                        .format(project_path, project_path, update_cmd)
            executor.run(cmd, True, self.logger)
        else:
            self.logger.error('conan file create error {}'.format(str(conan_file)))
        
        
    def install_from_txt(self, dest_path, source_path, update_from_remote=False, channel_name='desktop'):
        graph_file = Path(source_path).joinpath('graph.txt')
        self.logger.info('conan install input : {}'.format(str(graph_file)))
        
        subs = self._collect_libs_from_root_txt(graph_file)    
        libs = self._collect_sequece_libs(self.whole_libs, subs)
        self._install(dest_path, libs, channel_name, update_from_remote) 

class ConanMetaJson:
    def __init__(self):
        self.build_deps = []
        self.search_deps = []
        
class ConanCircleCreator():
    def __init__(self, conan):
        self.conan = conan
        self.logger = conan.logger
        self.temp_directory = log.get_clear_temp_dir("circle_conan_cache")
        self.logger.info('ConanCircleCreator : {}'.format(str(self.temp_directory)))
        
    def create_circle_recipes(self, recipes, channel):
        for recipe in recipes:
            self.create_circle_recipe(recipe, channel)

    def _create_conan_meta_json(self, meta_json_file):
        meta = ConanMetaJson()
        with open(meta_json_file, 'r') as file:
            content = file.read()
            a = json.loads(content)
            if 'build_deps' in a:
                meta.build_deps = a['build_deps']
            if 'search_deps' in a:
                meta.search_deps = a['search_deps']
        return meta
    
    def _print_meta(self, meta):
        self.logger.warning('build_deps : {}'.format(meta.build_deps))
        self.logger.warning('search_deps : {}'.format(meta.search_deps))
        
    def _clone_meta_json(self, url, output, version):
        cmd = 'git archive --remote={0} --output={1} version-{2} conan.meta.json'.format(url, output, version)
        cmd = cmd.replace('http://', 'ssh://zenggui@')
        cmd = cmd.replace(':8050', ':29418')
        
        executor.run(cmd, True, self.logger)
        
    def create_circle_recipe(self, recipe, channel):
        name, version = self.conan.recipe_2_name_version(recipe)
        url = self.conan.get_recipe_url(name, self.conan.use_external_rep)
        #recipe_temp_directory = log.get_clear_temp_dir("circle_conan_cache/{}-{}".format(name, version))
        meta_json_zip = self.temp_directory / '{}-{}.zip'.format(name, version)
        self._clone_meta_json(url, str(meta_json_zip), version)
        recipe_directory = self.temp_directory/'{}-{}'.format(name, version)
        shutil.unpack_archive(str(meta_json_zip), str(recipe_directory), 'zip')
        meta_json = recipe_directory / 'conan.meta.json'
        recipe_meta = self._create_conan_meta_json(str(meta_json))
        self._print_meta(recipe_meta)
        
        self.logger.info('recipe {0} -> {1}'.format(name, url))
        
        
        