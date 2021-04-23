# This sets the following variables:
# trimesh2 target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(trimesh2_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/zlib/)
	set(trimesh2_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(trimesh2
							   INC zlib.h
							   DLIB trimesh2
							   LIB trimesh2
							   )
else()
endif()

__test_import(trimesh2 lib)