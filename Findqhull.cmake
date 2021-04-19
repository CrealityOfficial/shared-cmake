find_path(qhull_INCLUDE_DIR libqhullcpp/Qhull.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/qhull/"
	PATHS "/usr/local/include/qhull/"
	NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
	)
	
if(qhull_INCLUDE_DIR)
	set(qhull_INCLUDE_DIRS ${qhull_INCLUDE_DIR})
endif()

find_library(qhullcpp_LIBRARIES_DEBUG
             NAMES qhullcpp
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/debug"
			 PATHS "/usr/local/lib/Debug"
			 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			 )
			 
find_library(qhullcpp_LIBRARIES_RELEASE
             NAMES qhullcpp
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/release"
			 PATHS "/usr/local/lib/Release"
			 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			 )
		
find_library(qhullstatic_r_LIBRARIES_DEBUG
             NAMES qhullstatic_r
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/debug"
			 PATHS "/usr/local/lib/Debug"
			 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			 )
			 
find_library(qhullstatic_r_LIBRARIES_RELEASE
             NAMES qhullstatic_r
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/release"
			 PATHS "/usr/local/lib/Release"
			 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			 )
			 
message(STATUS ${qhull_INCLUDE_DIRS})
message(STATUS ${qhullcpp_LIBRARIES_DEBUG})
message(STATUS ${qhullcpp_LIBRARIES_RELEASE})
message(STATUS ${qhullstatic_r_LIBRARIES_DEBUG})
message(STATUS ${qhullstatic_r_LIBRARIES_RELEASE})

if(qhull_INCLUDE_DIRS AND qhullcpp_LIBRARIES_DEBUG AND qhullcpp_LIBRARIES_RELEASE
					AND qhullstatic_r_LIBRARIES_DEBUG AND qhullstatic_r_LIBRARIES_RELEASE)
	set(qhull_FOUND "True")
	set(qhullcpp_INCLUDE_DIRS ${qhull_INCLUDE_DIRS})
	set(qhullstatic_r_INCLUDE_DIRS ${qhull_INCLUDE_DIRS})

	__import_target(qhullcpp lib)
	__import_target(qhullstatic_r lib)
	set(qhull qhullcpp qhullstatic_r)
endif()