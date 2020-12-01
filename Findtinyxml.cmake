
# Find tinyxml
#
# This sets the following variables:
# tinyxml_INCLUDE_DIRS
# tinyxml_LIBRARIES
# tinyxml_LIBRARIE_DIRS
# tinyxml_FOUND

find_path(tinyxml_INCLUDE_DIR tinyxml/tinystr.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(tinyxml_INCLUDE_DIR)
	set(tinyxml_INCLUDE_DIRS ${tinyxml_INCLUDE_DIR})
endif()

find_library(tinyxml_LIBRARIES_DEBUG
             NAMES tinyxml
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(tinyxml_LIBRARIES_RELEASE
         NAMES tinyxml
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("tinyxml_INCLUDE_DIR  ${tinyxml_INCLUDE_DIR}")
message("tinyxml_LIBRARIES_DEBUG  ${tinyxml_LIBRARIES_DEBUG}")
message("tinyxml_LIBRARIES_RELEASE  ${tinyxml_LIBRARIES_RELEASE}")

if(tinyxml_INCLUDE_DIRS AND tinyxml_LIBRARIES_DEBUG AND tinyxml_LIBRARIES_RELEASE)
	set(tinyxml_FOUND "True")
	__import_target(tinyxml lib)
endif()
