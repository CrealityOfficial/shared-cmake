# This sets the following variables:
# BOOST_INCLUDE_DIRS
# BOOST_INCLUDE_FOUND

if(BOOST_INSTALL_ROOT)
	message(STATUS "Boost Specified BOOST_INSTALL_ROOT : ${BOOST_INSTALL_ROOT}")
	set(BOOST_INCLUDE_DIRS ${BOOST_INSTALL_ROOT}/include/)
else()
endif()
	
if(BOOST_INCLUDE_DIRS)
	set(BOOST_INCLUDE_FOUND 1)
	message(STATUS "EIGEN_INCLUDE_DIRS : ${EIGEN_INCLUDE_DIRS}")
else()
	message(STATUS "Find Boost include Failed")
endif()