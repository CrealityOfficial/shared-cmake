# This sets the following variables:
# clipper target

if(THIRD1_INSTALL_ROOT)
elseif(CXCLIPPER_INSTALL_ROOT)
endif()

__search_target_components(clipperz
						   INC clipper_z.hpp
						   DLIB clipperz
						   LIB clipperz
						   PRE clipperz
						   )

__test_import(clipperz lib)