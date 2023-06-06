cmake_minimum_required(VERSION 3.1)

project(auto_doxygen)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../")
include(ConfigureAllModules) 
		   
set(DOXYGEN_OUT_PATH ${CMAKE_BINARY_DIR}/doxygen)
file(MAKE_DIRECTORY ${DOXYGEN_OUT_PATH})

set(CMAKE_DOXYGEN_INPUT ${CMAKE_BINARY_DIR}/../rep/)
set(CMAKE_DOXYGEN_OUTPUT_DIRECTORY ${DOXYGEN_OUT_PATH})
if(NOT CMAKE_DOXYGEN_NAME)
	set(CMAKE_DOXYGEN_NAME "dummy")
endif()

configure_file(${CMAKE_SOURCE_DIR}/DoxyFile.in
           ${DOXYGEN_OUT_PATH}/DoxyFile)