set(BIN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../../bin")
set(LIB_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../../lib")


#config targets, separate src, lib, bin
set(global_all_targets)

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

macro(configure_all)
foreach(target ${global_all_targets})
configure_target(${target})
endforeach()
endmacro()

#internal target macro
macro(__add_executable target)
message(STATUS ${ARGV0})
message(STATUS ${ARGV1})
message(STATUS ${ARGV2})
message(STATUS ${ARGN})
message(STATUS ${ARGC})
endmacro()
