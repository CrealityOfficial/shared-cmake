
# Find protobuf
#
# This sets the following variables:
# grpc_INCLUDE_DIRS
# grpc_LIBRARIES
# grpc_LIBRARIE_DIRS
# grpc_FOUND

find_path(protobuf_INCLUDE_DIR google/protobuf/any.h
    HINTS "$ENV{CX_GRPC_ROOT}/include/"
	PATHS "/usr/include/" "/include/")
	
if(protobuf_INCLUDE_DIR)
	set(protobuf_INCLUDE_DIRS ${protobuf_INCLUDE_DIR})
endif()
	set(protoc_INCLUDE_DIRS ${protobuf_INCLUDE_DIRS})

find_library(libprotobuf_LIBRARIES_DEBUG
             NAMES libprotobuf protobuf
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug" "/include/")
find_library(libprotoc_LIBRARIES_DEBUG
             NAMES libprotoc protoc
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug" "/include/")			 




find_library(libprotobuf_LIBRARIES_RELEASE
             NAMES libprotobuf protobuf
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release" "/include/")
find_library(libprotoc_LIBRARIES_RELEASE
             NAMES libprotoc protoc
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release" "/include/")			 
		 
			 
message("protobuf_INCLUDE_DIR  ${protobuf_INCLUDE_DIR}")
message("protobuf_LIBRARIES_DEBUG  ${protobuf_LIBRARIES_DEBUG}")
message("libprotobuf_LIBRARIES_DEBUG  ${libprotobuf_LIBRARIES_DEBUG}")
message("libprotobuf_LIBRARIES_RELEASE ${libprotobuf_LIBRARIES_RELEASE}")

if(protobuf_INCLUDE_DIRS AND libprotobuf_LIBRARIES_DEBUG AND libprotobuf_LIBRARIES_RELEASE 
                     AND libprotoc_LIBRARIES_DEBUG AND libprotoc_LIBRARIES_RELEASE
					 )
	#message(STATUS " ------------------------------- cxgrpc found")
	set(cxgrpc_FOUND "True")
	__import_target(libprotobuf lib)
	__import_target(libprotoc lib)
	
	set(protobuf libprotobuf libprotoc)
endif()
