cmake_minimum_required(VERSION 3.1)

project(auto_doxygen)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../")
include(ConfigureAllModules) 
		   
if(NOT CMAKE_DOXYGEN_NAME)
	set(CMAKE_DOXYGEN_NAME dummy)
endif()
if(NOT CMAKE_DOXYGEN_BRANCH)
	set(CMAKE_DOXYGEN_BRANCH master)
endif()

set(rep_prefix http://172.20.180.12:8050/)
set(branch master)

file(REMOVE_RECURSE ${CMAKE_SOURCE_DIR}/../../root/)
__execute(git clone -b ${CMAKE_DOXYGEN_BRANCH} ${rep_prefix}${CMAKE_DOXYGEN_NAME} root)
	
set(DOXYGEN_OUT_PATH ${CMAKE_BINARY_DIR}/doxygen)
file(MAKE_DIRECTORY ${DOXYGEN_OUT_PATH})

set(CMAKE_DOXYGEN_INPUT ${CMAKE_BINARY_DIR}/../root/)
set(CMAKE_DOXYGEN_OUTPUT_DIRECTORY ${DOXYGEN_OUT_PATH})

configure_file(${CMAKE_SOURCE_DIR}/DoxyFile.in
           ${DOXYGEN_OUT_PATH}/DoxyFile)
		   
__execute(doxygen ${DOXYGEN_OUT_PATH}/DoxyFile)

set(USER_NAME cxsw@172.16.33.10)

#ssh cxsw@172.16.33.10 "rm -rf /vagrant_data/www/shared/build/doxygen/${repository}/"
#ssh cxsw@172.16.33.10 "mkdir -p /vagrant_data/www/shared/build/doxygen/${repository}/" 
#scp -r  doxygen/html/ cxsw@172.16.33.10:/vagrant_data/www/shared/build/doxygen/${repository}/html/