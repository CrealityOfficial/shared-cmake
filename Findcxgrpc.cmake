
# Find cxgrpc
#
# This sets the following variables:
# grpc_INCLUDE_DIRS
# grpc_LIBRARIES
# grpc_LIBRARIE_DIRS
# grpc_FOUND

find_path(grpc_INCLUDE_DIR grpc/grpc.h
    HINTS "$ENV{CX_GRPC_ROOT}/include/"
	PATHS "/usr/include/" "/include/")
	
if(grpc_INCLUDE_DIR)
	set(grpc_INCLUDE_DIRS ${grpc_INCLUDE_DIR})
endif()
	set(grpc++_INCLUDE_DIRS ${grpc_INCLUDE_DIRS})
	set(gpr_INCLUDE_DIRS ${grpc_INCLUDE_DIRS})

find_library(grpc_LIBRARIES_DEBUG
             NAMES grpc
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug" "/lib/" )
find_library(grpc++_LIBRARIES_DEBUG
             NAMES grpc++
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug" "/lib/")			 
find_library(gpr_LIBRARIES_DEBUG
             NAMES gpr
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug" "/lib/" )

#find_library(protobuf_LIBRARIES_DEBUG
#             NAMES libprotobuf
#             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
#			 PATHS "/usr/lib/Debug")
#find_library(protoc_LIBRARIES_DEBUG
#             NAMES protoc
#             HINTS "$ENV{CX_GRPC_ROOT}/lib/Debug"
#			 PATHS "/usr/lib/Debug")			 
			 


find_library(grpc_LIBRARIES_RELEASE
             NAMES grpc
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release" "/lib/")
find_library(grpc++_LIBRARIES_RELEASE
             NAMES grpc++
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release" "/lib/")			 
find_library(gpr_LIBRARIES_RELEASE
             NAMES gpr
             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release" "/lib")
#find_library(protobuf_LIBRARIES_RELEASE
#             NAMES libprotobuf
#             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
#			 PATHS "/usr/lib/Release")
#find_library(protoc_LIBRARIES_RELEASE
#             NAMES protoc
#             HINTS "$ENV{CX_GRPC_ROOT}/lib/Release"
#			 PATHS "/usr/lib/Release")			 
			 
message("grpc_INCLUDE_DIR  ${grpc_INCLUDE_DIR}")
message("grpc_LIBRARIES_DEBUG  ${grpc_LIBRARIES_DEBUG}")
message("grpc_LIBRARIES_RELEASE  ${grpc_LIBRARIES_RELEASE}")
message("grpc++_INCLUDE_DIRS ${grpc++_INCLUDE_DIRS}")
if(grpc_INCLUDE_DIRS AND grpc_LIBRARIES_DEBUG AND grpc_LIBRARIES_RELEASE 
                     AND grpc++_LIBRARIES_DEBUG AND grpc++_LIBRARIES_RELEASE
					 AND gpr_LIBRARIES_DEBUG AND gpr_LIBRARIES_RELEASE
					 #AND libprotobuf_LIBRARIES_DEBUG AND libprotobuf_LIBRARIES_RELEASE
					 #AND protoc_LIBRARIES_DEBUG AND protoc_LIBRARIES_RELEASE
					 )
	#message(STATUS " ------------------------------- cxgrpc found")
	set(cxgrpc_FOUND "True")
	__import_target(grpc lib)
	__import_target(grpc++ lib)
	__import_target(gpr lib)
	
	set(cxgrpc grpc grpc++ gpr)
endif()
