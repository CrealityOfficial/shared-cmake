
# Find gtest
#
# This sets the following variables:
# gtest_INCLUDE_DIRS
# gtest_LIBRARIES
# gtest_LIBRARIE_DIRS
# gtest_FOUND

find_path(gtest_INCLUDE_DIR gtest/gtest.h
    HINTS  "$ENV{CX_ANALYSIS_ROOT}/include"
		"$ENV{CX_THIRDPARTY_ROOT}/include"
	PATHS "/usr/include")
	
if(gtest_INCLUDE_DIR)
	set(gtest_INCLUDE_DIRS ${gtest_INCLUDE_DIR})
endif()

find_library(gtest_LIBRARIES_DEBUG
             NAMES gtest
             HINTS "$ENV{CX_ANALYSIS_ROOT}/lib/Debug" 
				"$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(gtest_LIBRARIES_RELEASE
         NAMES gtest
         HINTS "$ENV{CX_ANALYSIS_ROOT}/lib/Release"  
			"$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
		
find_library(gtest_main_LIBRARIES_DEBUG
             NAMES gtest_main
             HINTS "$ENV{CX_ANALYSIS_ROOT}/lib/Debug" 
				"$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(gtest_main_LIBRARIES_RELEASE
         NAMES gtest_main
         HINTS "$ENV{CX_ANALYSIS_ROOT}/lib/Release"  
			"$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
		 
message("gtest_INCLUDE_DIRS  ${gtest_INCLUDE_DIRS}")
message("gtest_LIBRARIES_DEBUG  ${gtest_LIBRARIES_DEBUG}")
message("gtest_LIBRARIES_RELEASE  ${gtest_LIBRARIES_RELEASE}")
message("gtest_main_LIBRARIES_RELEASE  ${gtest_main_LIBRARIES_RELEASE}")

if(gtest_INCLUDE_DIRS AND gtest_LIBRARIES_DEBUG AND gtest_LIBRARIES_RELEASE)
	set(gtest_FOUND "True")
	__import_target(gtest lib)
	__import_target(gtest_main lib)
endif()
