
# Find alibabacloud
#
# This sets the following variables:
# alibabacloud_INCLUDE_DIRS
# dxflib_LIBRARIES
# dxflib_LIBRARIE_DIRS
# alibabacloud_FOUND

find_path(AliyunOss_INCLUDE_DIR alibabacloud/oss/Config.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/oss/"
	PATHS "/usr/include/oss/")
	
if(AliyunOss_INCLUDE_DIR)
	set(AliyunOss_INCLUDE_DIRS ${AliyunOss_INCLUDE_DIR})
endif()

find_library(AliyunOss_LIBRARIES_DEBUG
             NAMES AliyunOss
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(AliyunOss_LIBRARIES_RELEASE
         NAMES AliyunOss
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("AliyunOss_INCLUDE_DIR  ${AliyunOss_INCLUDE_DIR}")
message("AliyunOss_LIBRARIES_DEBUG  ${AliyunOss_LIBRARIES_DEBUG}")
message("AliyunOss_LIBRARIES_RELEASE  ${AliyunOssLIBRARIES_RELEASE}")

if(AliyunOss_INCLUDE_DIRS AND AliyunOss_LIBRARIES_DEBUG AND AliyunOss_LIBRARIES_RELEASE)
	set(alibabacloud_FOUND "True")
	__import_target(AliyunOss lib)
endif()
