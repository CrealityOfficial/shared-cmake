cmake_minimum_required(VERSION 3.1)

project(auto_doxygen)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../")
include(ConfigureAllModules) 

configure_file(${CMAKE_SOURCE_DIR}/DoxyFile.in
           ${CMAKE_BINARY_DIR}/DoxyFile)
		   
