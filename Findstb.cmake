
# Find stb
#
# This sets the following variables:
# stb_INCLUDE_DIRS
# stb_FOUND

find_path(stb_INCLUDE_DIR stb/stb.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include"
	PATHS "/usr/include")
	
if(stb_INCLUDE_DIR)
	set(stb_INCLUDE_DIRS ${stb_INCLUDE_DIR})
	set(stb_FOUND "True")
endif()