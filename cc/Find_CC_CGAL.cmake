# This sets the following variables:
# CGAL_INCLUDE_DIRS

__cc_find(Boost)
__cc_find(Eigen)

if(NOT BOOST_INCLUDE_DIRS)
	message(FATAL_ERROR "Please Specified BOOST_INCLUDE_DIRS")
endif()

if(NOT EIGEN_INCLUDE_DIRS)
	message(FATAL_ERROR "Please Specified EIGEN_INCLUDE_DIRS")
endif()

include_directories(${BOOST_INCLUDE_DIRS})
include_directories(${EIGEN_INCLUDE_DIRS})
add_definitions(-DCGAL_NO_GMP=1)
add_definitions(-DCGAL_NO_MPFR=1)

macro(__cc_cgal_include package)
	if(NOT CGAL_INCLUDE_DIRS)
		message(FATAL_ERROR "Please Specified CGAL_INCLUDE_DIRS")
	endif()
	include_directories(${CGAL_INCLUDE_DIRS}/${package})
endmacro()

if(CGAL_INSTALL_ROOT)
	message(STATUS "Eigen Specified CGAL_INSTALL_ROOT : ${CGAL_INSTALL_ROOT}")
	set(CGAL_INCLUDE_DIRS ${CGAL_INSTALL_ROOT}/include/CGAL/)
else()
endif()

__cc_cgal_include(Installation)
__cc_cgal_include(STL_Extension)

__cc_cgal_include(Kernel_23)
