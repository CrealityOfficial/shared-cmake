macro(__files_group dir src)   #support 2 level
	file(GLOB _src ${dir}/*.h ${dir}/*.cpp)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir})
			file(GLOB sub_src ${sub_dir}/*.h ${sub_dir}/*.cpp)
			source_group(${child} FILES ${sub_src})
			set(_src ${_src} ${sub_src})
		endif()
	endforeach()
	set(${src} ${_src})
endmacro()

macro(__files_group_c dir src)   #support 2 level
	file(GLOB _src ${dir}/*.c)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir})
			file(GLOB sub_src ${sub_dir}/*.c)
			source_group(${child} FILES ${sub_src})
			set(_src ${_src} ${sub_src})
		endif()
	endforeach()
	set(${src} ${_src})
endmacro()

function(__recursive_add_subdirectory dir)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir} AND EXISTS ${sub_dir}/CMakeLists.txt)
			add_subdirectory(${sub_dir})
		endif()
	endforeach()
endfunction()

macro(__get_file_name path name)
	STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" ${name} ${path})
endmacro()

macro(__add_all_directory)
	__recursive_add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR})
endmacro()