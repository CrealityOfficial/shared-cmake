# This sets the following variables:
# trimesh2 target

if(THIRD1_INSTALL_ROOT)
	message(STATUS "Specified THIRD1_INSTALL_ROOT : ${THIRD1_INSTALL_ROOT}")
	set(trimesh2_INCLUDE_ROOT ${THIRD1_INSTALL_ROOT}/include/)
	set(trimesh2_LIB_ROOT ${THIRD1_INSTALL_ROOT}/lib/)
elseif(CXTRIMESH2_INSTALL_ROOT)
	message(STATUS "Specified CXTRIMESH2_INSTALL_ROOT : ${CXTRIMESH2_INSTALL_ROOT}")
	set(trimesh2_INCLUDE_ROOT ${CXTRIMESH2_INSTALL_ROOT}/include/)
	set(trimesh2_LIB_ROOT ${CXTRIMESH2_INSTALL_ROOT}/lib/)	
endif()

__search_target_components(trimesh2
						   INC trimesh2/TriMesh.h
						   DLIB trimesh2
						   LIB trimesh2
						   PRE trimesh2
						   )

__test_import(trimesh2 lib)