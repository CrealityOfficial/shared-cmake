# This sets the following variables:
# spdlog target

if(THIRD1_INSTALL_ROOT)
	message(STATUS "Specified THIRD1_INSTALL_ROOT : ${THIRD1_INSTALL_ROOT}")
	set(spdlog_INCLUDE_ROOT ${THIRD1_INSTALL_ROOT}/include/spdlog/)
	set(spdlog_LIB_ROOT ${THIRD1_INSTALL_ROOT}/lib/)
	__search_target_components(spdlog
							   INC spdlog/spdlog.h
							   DLIB spdlog
							   LIB spdlog
							   )							 
else()
endif()

__test_import(spdlog dll)
