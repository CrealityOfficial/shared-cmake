# This sets the following variables:
# VCG_INCLUDE_DIRS
# VCG_FOUND

if(HEADER_INSTALL_ROOT)
	message(STATUS "Eigen Specified HEADER_INSTALL_ROOT : ${HEADER_INSTALL_ROOT}")
	set(VCG_INSTALL_ROOT ${HEADER_INSTALL_ROOT}/include/vcglib/)
	find_path(VCG_INCLUDE_DIRS vcg/complex/complex.h
				HINTS "${VCG_INSTALL_ROOT}"
				PATHS "/usr/local/include/eigen"
				NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
				)
else()
endif()
	
if(VCG_INCLUDE_DIRS)
	set(VCG_FOUND 1)
	message(STATUS "VCG_INCLUDE_DIRS : ${VCG_INCLUDE_DIRS}")
else()
	message(STATUS "Find vcg Failed")
endif()