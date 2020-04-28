set(BIN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../../bin")
set(LIB_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../../lib")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#config targets, separate src, lib, bin

set(global_all_targets)
set(global_all_targets "" CACHE STRING INTERNAL FORCE)

if(${CMAKE_VERSION} VERSION_LESS 3.4)
include(CMakeParseArguments)
endif()

macro(configure_target target)
set_target_properties(${target} PROPERTIES
					LIBRARY_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
					ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
					RUNTIME_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
					LIBRARY_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
					ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
					RUNTIME_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
					)
endmacro()

macro(add_top_target target)
list(APPEND global_all_targets ${target})
list(REMOVE_DUPLICATES global_all_targets)
endmacro()

macro(add_target target)
list(APPEND global_all_targets ${target})
list(REMOVE_DUPLICATES global_all_targets)
set(global_all_targets ${global_all_targets} CACHE STRING INTERNAL FORCE)
endmacro()

macro(__configure_all)
foreach(target ${global_all_targets})
configure_target(${target})
endforeach()
endmacro()

#target function
function(build_inner target)
add_target(${target})
cmake_parse_arguments(build_inner "" "" "SOURCE;LIB;DEF" ${ARGN})
if(build_inner_LIB)
foreach(lib ${build_inner_LIB})
target_link_libraries(${target} PRIVATE ${lib})
#message(STATUS ${lib}) 	
endforeach()
endif()
if(build_inner_DEF)
foreach(def ${build_inner_DEF})
target_compile_definitions(${target} PRIVATE ${def})
#message(STATUS ${def}) 	
endforeach()
endif()
endfunction()

function(__add_executable target)
cmake_parse_arguments(target_description "" "" "SOURCE;LIB;DEF" ${ARGN})
if(target_description_SOURCE)
#message(STATUS ${target_description_SOURCE})
add_executable(${target} ${target_description_SOURCE})
build_inner(${target} ${ARGN})
else(target_description_SOURCE)
message(FATAL_ERROR "add target ${target} without sources")
endif()
endfunction()

function(__add_shared_lib target)
cmake_parse_arguments(target_description "" "" "SOURCE;LIB;DEF" ${ARGN})
if(target_description_SOURCE)
add_library(${target} SHARED ${target_description_SOURCE})
build_inner(${target} ${ARGN})
else(target_description_SOURCE)
message(FATAL_ERROR "add target ${target} without sources")
endif()
endfunction()

