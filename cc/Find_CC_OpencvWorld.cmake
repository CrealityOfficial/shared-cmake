

if(NOT TARGET opencv_world)
	set(opencv_world_INCLUDE_DIRS "${OPENCV_INSTALL_ROOT}/install/include")
	set(opencv_world_LIBRARIES_DEBUG 	"${OPENCV_INSTALL_ROOT}/install/lib/opencv_world455d.lib")
	set(opencv_world_LIBRARIES_RELEASE 	"${OPENCV_INSTALL_ROOT}/install/lib/opencv_world455.lib")
	MESSAGE(STATUS "**********************${opencv_world_INCLUDE_DIRS}")
	MESSAGE(STATUS "**********************${opencv_world_LIBRARIES_DEBUG}")
	MESSAGE(STATUS "${opencv_world_LIBRARIES_RELEASE}")
	__test_import(opencv_world dll)
endif()







