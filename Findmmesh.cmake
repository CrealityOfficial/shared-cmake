
# This sets the following variables:
# mmesh_INCLUDE_DIRS
# mmesh_LIBRARIES
# mmesh_FOUND
# mmesh_targets

find_path(mmesh_INCLUDE_DIR mmesh/trimesh/meshtopo.h
    HINTS "$ENV{CX_CORELIB_ROOT}/include")
	
if(mmesh_INCLUDE_DIR)
	set(mmesh_INCLUDE_DIRS ${mmesh_INCLUDE_DIR})
endif()

find_library(mmesh_LIBRARIES_DEBUG
             NAMES mmesh
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/debug")

find_library(mmesh_LIBRARIES_RELEASE
             NAMES mmesh
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/release")
			 
if(mmesh_INCLUDE_DIRS AND mmesh_LIBRARIES_DEBUG AND mmesh_LIBRARIES_RELEASE)
	set(mmesh_FOUND "True")
	__import_target(mmesh lib)
endif()