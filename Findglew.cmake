
# Find glew
#
# This sets the following variables:
# glew_INCLUDE_DIRS
# glew_LIBRARIES
# glew_LIBRARIE_DIRS
# glew_FOUND

find_path(glew_INCLUDE_DIR GL/glew.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
__find_simple_package(glew dll)
	

