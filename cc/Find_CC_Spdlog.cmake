# This sets the following variables:
# spdlog target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(spdlog_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/)
	set(spdlog_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(spdlog
							   INC spdlog/spdlog.h
							   DLIB spdlog
							   LIB spdlog
							   )							 
else()
endif()

__test_import(spdlog lib)
