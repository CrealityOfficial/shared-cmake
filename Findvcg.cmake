
# Find vcg
#
# This sets the following variables:
# vcg_INCLUDE_DIRS
# vcg_FOUND

find_path(vcg_INCLUDE_DIR vcg/complex/base.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/vcglib/"
	PATHS "/usr/include/vcglib")
	
if(vcg_INCLUDE_DIR)
	set(vcg_INCLUDE_DIRS ${vcg_INCLUDE_DIR})
	set(vcg_FOUND "True")
endif()