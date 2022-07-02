list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/conan/")

if(EXISTS ${CMAKE_BINARY_DIR}/conan_paths.cmake)
	include(${CMAKE_BINARY_DIR}/conan_paths.cmake)
	message(STATUS "Use conan_paths ${CMAKE_BINARY_DIR}/conan_paths.cmake")
else()
	message(STATUS "Disable conan_paths.")
endif()



macro(__conan_find)
	message(STATUS "CONAN ****** Start Find ${ARGN}")
	find_package(_conan_${ARGN})
	message(STATUS "CONAN ****** End Find ${ARGN}")
endmacro()

if(CMAKE_USE_CONAN)
	set(HAVE_CONAN_CACHE 1)
endif()