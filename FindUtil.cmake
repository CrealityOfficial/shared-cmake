macro(__required_find_package package)
	find_package(${package} REQUIRED)
	if(NOT DEFINED ${package}_FOUND)
		message(FATAL_ERROR "${package} not found!")
	else()
		message(STATUS "${package} include : ${${package}_INCLUDE_DIRS}")
	endif()
endmacro()

