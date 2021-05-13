macro(__use_python)
	find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
		
	if(Python3_FOUND AND Python3_Development_FOUND)
		message(STATUS "Find Python3 ${Python3_VERSION}")
		message(STATUS "INCLUDES : ${Python3_INCLUDE_DIRS}")
		message(STATUS "LIBRARIES : ${Python3_LIBRARIES}")
		message(STATUS "LIBRARY DIRS : ${Python3_LIBRARY_DIRS}")
	else()
		message(STATUS "Can't find Python3.")
	endif()
	
	set(PYTHON_INCLUDE_DIR ${Python3_INCLUDE_DIRS})
	list(GET Python3_LIBRARIES 3 Python3_LIBRARIES_DEBUG)
	list(GET Python3_LIBRARIES 1 Python3_LIBRARIES_RELEASE)
	message(STATUS "Python3 Debug LIBRARIES : ${Python3_LIBRARIES_DEBUG}")
	message(STATUS "Python3 Release LIBRARIES : ${Python3_LIBRARIES_RELEASE}")
	__import_target(Python3 dll)
endmacro()

macro(__copy_python_pyc)
	message(STATUS ${PYTHON_ROOT})

	add_custom_target(__copy_python_pyc ALL COMMENT "copy third party dll!")
	__set_target_folder(__copy_python_pyc CMakePredefinedTargets)

	add_custom_command(TARGET __copy_python_pyc PRE_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
		COMMAND ${CMAKE_COMMAND} -E copy_directory "${PYTHON_ROOT}/PYC/"
			"${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
		)	

endmacro()