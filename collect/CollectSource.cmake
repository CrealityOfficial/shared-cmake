
function(__collect_assign_source_group)
	#message(STATUS "__collect_assign_source_group : ${ARGN}")
    foreach(source IN ITEMS ${ARGN})
		#message(STATUS "__collect_assign_source_group item: ${source}")
        if (IS_ABSOLUTE ${source})
            message(WARNING "__collect_assign_source_group must be relative path.")
        endif()
        get_filename_component(SOURCE_PATH ${source} PATH)
        string(REPLACE "/" "\\" SOURCE_PATH_GROUP "${SOURCE_PATH}")
				
        source_group("${SOURCE_PATH_GROUP}" FILES "${source}")
    endforeach()
endfunction()

function(__collect_source_tree_from_directory SOURCE_VAR)
	cmake_parse_arguments(COLLECT "" "" "FILTERS;EXCLUDE" ${ARGN})
	if(NOT COLLECT_FILTERS)
		set(COLLECT_FILTERS ${COLLECT_FILTER_SOURCE_ALL})
	endif()
	
	file(GLOB_RECURSE FILES_VAR RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${COLLECT_FILTERS})
	
	set(FINAL_FILES)
	if(COLLECT_EXCLUDE)
		__filter_string_list(FILES_VAR COLLECT_EXCLUDE FINAL_FILES)
	else()
		set(FINAL_FILES ${FILES_VAR})
	endif()

	message(STATUS "__collect_assign_source_group : ${FINAL_FILES}")
	
	__collect_assign_source_group(${FINAL_FILES})
	set(${SOURCE_VAR} ${FINAL_FILES} PARENT_SCOPE)
endfunction()