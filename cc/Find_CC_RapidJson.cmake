# This sets the following variables:
# RapidJson_INCLUDE_DIRS
# RapidJson_FOUND

if(HEADER_INSTALL_ROOT)
	message(STATUS "RapidJson Specified HEADER_INSTALL_ROOT : ${HEADER_INSTALL_ROOT}")
	set(RAPIDJSON_INSTALL_ROOT ${HEADER_INSTALL_ROOT}/include/)
	find_path(RAPIDJSON_INCLUDE_DIRS rapidjson/rapidjson.h
				HINTS "${RAPIDJSON_INSTALL_ROOT}"
				PATHS "/usr/local/include/rapidjson/rapidjson.h"
				NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
				)
else()
endif()
	
if(RAPIDJSON_INCLUDE_DIRS)
	set(RapidJson_FOUND 1)
	message(STATUS "RAPIDJSON_INCLUDE_DIRS : ${RAPIDJSON_INCLUDE_DIRS}")
else()
	message(STATUS "Find RapidJson Failed")
endif()