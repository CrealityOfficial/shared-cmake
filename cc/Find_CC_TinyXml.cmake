# This sets the following variables:
# tinyxml target

if(THIRD1_INSTALL_ROOT)
	message(STATUS "Specified THIRD1_INSTALL_ROOT : ${THIRD1_INSTALL_ROOT}")
	set(trimesh2_INCLUDE_ROOT ${THIRD1_INSTALL_ROOT}/include/)
	set(trimesh2_LIB_ROOT ${THIRD1_INSTALL_ROOT}/lib/)
	__search_target_components(trimesh2
							   INC trimesh2/TriMesh.h
							   DLIB trimesh2
							   LIB trimesh2
							   )
elseif(CXTINYXML_INSTALL_ROOT)
	message(STATUS "Specified CXTINYXML_INSTALL_ROOT : ${CXTINYXML_INSTALL_ROOT}")
	set(tinyxml_INCLUDE_ROOT ${CXTINYXML_INSTALL_ROOT}/include/)
	set(tinyxml_LIB_ROOT ${CXTINYXML_INSTALL_ROOT}/lib/)
	__search_target_components(tinyxml
							   INC tinyxml/tinyxml.h
							   DLIB tinyxml
							   LIB tinyxml
							   )
endif()

__test_import(tinyxml lib)