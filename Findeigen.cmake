
# Find eigen
#
# This sets the following variables:
# eigen_INCLUDE_DIRS
# eigen_FOUND

find_path(eigen_INCLUDE_DIR Eigen/Cholesky
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/eigen/"
	PATHS "/usr/include/eigen")
	
if(eigen_INCLUDE_DIR)
	set(eigen_INCLUDE_DIRS ${eigen_INCLUDE_DIR})
	set(eigen_FOUND "True")
endif()