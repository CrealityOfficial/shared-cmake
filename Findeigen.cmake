
# Find eigen
#
# This sets the following variables:
# eigen_INCLUDE_DIRS
# eigen_FOUND

find_path(eigen_INCLUDE_DIR Eigen/Cholesky
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/eigen/"
	PATHS "/usr/local/include/eigen"
	NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
	)
	
if(eigen_INCLUDE_DIR)
	set(eigen_INCLUDE_DIRS ${eigen_INCLUDE_DIR})
	set(eigen_FOUND "True")
endif()