
# Find trimesh2
#
# This sets the following variables:
# trimesh2_INCLUDE_DIRS
# trimesh2_LIBRARIES
# trimesh2_LIBRARIE_DIRS
# trimesh2_FOUND

find_path(trimesh2_INCLUDE_DIR trimesh2/TriMesh.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(trimesh2_INCLUDE_DIR)
	set(trimesh2_INCLUDE_DIRS ${trimesh2_INCLUDE_DIR})
endif()

find_library(trimesh2_LIBRARIES_DEBUG
             NAMES trimesh2
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(trimesh2_LIBRARIES_RELEASE
         NAMES trimesh2
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("trimesh2_INCLUDE_DIR  ${trimesh2_INCLUDE_DIR}")
message("trimesh2_LIBRARIES_DEBUG  ${trimesh2_LIBRARIES_DEBUG}")
message("trimesh2_LIBRARIES_RELEASE  ${trimesh2_LIBRARIES_RELEASE}")

if(trimesh2_INCLUDE_DIRS AND trimesh2_LIBRARIES_DEBUG AND trimesh2_LIBRARIES_RELEASE)
	set(trimesh2_FOUND "True")
	__import_target(trimesh2 lib)
endif()
