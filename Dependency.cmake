





set(qtuser_inc "/qtuser/3d/" "/qtuser/core/" "/qtuser/qml/")
set(qtuser_lib debug qtuser_qml.lib optimized qtuser_qml.lib)


function(__add_target_dependency target)
	cmake_parse_arguments(target_dependency "" "" "DEP" ${ARGN})
	if(target_dependency_DEP)
		foreach(dep ${target_dependency_DEP})
			foreach(inc ${${dep}_inc})
				target_include_directories(${target} PRIVATE "${CMAKE_SOURCE_DIR}/../${inc}")
			endforeach()
			
			cmake_parse_arguments(libs "" "" "debug;optimized" ${${dep}_lib})
			foreach(lib ${libs_debug})
				target_link_libraries(${target} PRIVATE debug "${LIB_DEBUG_PATH}/${lib}")
			endforeach()
			foreach(lib ${libs_optimized})
				target_link_libraries(${target} PRIVATE optimized "${LIB_RELEASE_PATH}/${lib}")
			endforeach()
		endforeach()
	endif()
endfunction()