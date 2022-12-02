macro(__enable_spdlog)
	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/spdlog/CMakeLists.txt)
		add_subdirectory(spdlog)
		set(SPDLOG_FROM_SOURCE 1)
	else()
		__cc_find(Cxlog)
		set(SPDLOG_FROM_SOURCE 0)
	endif()
	
	if(TARGET cxlog)
		message(STATUS "__enable_spdlog success.")
		set(CC_GLOBAL_SPDLOG_ENABLED 1)
		if(SPDLOG_FROM_SOURCE)
			message(STATUS "from source.")
		else()
			message(STATUS "from binary.")
		endif()
	else()
		message(STATUS "__enable_spdlog failed.")
		set(CC_GLOBAL_SPDLOG_ENABLED 0)
	endif()
endmacro()

macro(__enable_shiny)
	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/shiny/CMakeLists.txt)
		add_subdirectory(shiny)
		set(SHINY_FROM_SOURCE 1)
	else()
		__cc_find(shiny)
		set(SHINY_FROM_SOURCE 0)
	endif()
	
	if(TARGET shiny)
		message(STATUS "__enable_shiny success.")
		set(CC_GLOBAL_SHINY_ENABLED 1)
		if(SHINY_FROM_SOURCE)
			message(STATUS "from source.")
		else()
			message(STATUS "from binary.")
		endif()
	else()
		message(STATUS "__enable_shiny failed.")
		set(CC_GLOBAL_SHINY_ENABLED 0)
	endif()
endmacro()