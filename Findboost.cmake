
# Find boost
#
# This sets the following variables:
# boost_INCLUDE_DIRS
# boost_LIBRARIES
# boost_LIBRARIE_DIRS
# boost_FOUND

find_path(boost_INCLUDE_DIR boost/functional.hpp
    HINTS "$ENV{CX_BOOST_ROOT}/boost/"
		  "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/boost/" "/usr/include/")
	
if(boost_INCLUDE_DIR)
	set(boost_INCLUDE_DIRS ${boost_INCLUDE_DIR})
endif()

set(boost_libs system program_options)

macro(__boost_import module)
	set(mod boost_${module})
	find_library(${mod}_LIBRARIES_DEBUG
				NAMES ${mod}
				HINTS "$ENV{CX_BOOST_ROOT}/lib/Debug"
				PATHS "/usr/lib/Debug")
				
	find_library(${mod}_LIBRARIES_RELEASE
			NAMES ${mod}
			HINTS "$ENV{CX_BOOST_ROOT}/lib/Release"
			PATHS "/usr/lib/Release")
		
	set(${mod}_INCLUDE_DIRS ${boost_INCLUDE_DIR})		
	message("${mod}_INCLUDE_DIRS  ${${mod}_INCLUDE_DIRS}")
	message("${mod}_LIBRARIES_DEBUG  ${${mod}_LIBRARIES_DEBUG}")
	message("${mod}_LIBRARIES_RELEASE  ${${mod}_LIBRARIES_RELEASE}")
	
	if (NOT TARGET ${mod})		
		add_library(${mod} SHARED IMPORTED)
		
		set_property(TARGET ${mod} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${${mod}_INCLUDE_DIRS})
		set_property(TARGET ${mod} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Debug")
		set_property(TARGET ${mod} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Release")
		
		set_target_properties(${mod} PROPERTIES IMPORTED_IMPLIB_DEBUG ${${mod}_LIBRARIES_DEBUG})
		set_target_properties(${mod} PROPERTIES IMPORTED_IMPLIB_RELEASE ${${mod}_LIBRARIES_RELEASE})
		
		set_target_properties(${mod} PROPERTIES IMPORTED_LOCATION_DEBUG ${${mod}_LIBRARIES_DEBUG})
		set_target_properties(${mod} PROPERTIES IMPORTED_LOCATION_RELEASE ${${mod}_LIBRARIES_RELEASE})
	endif()
endmacro()

set(boost_FOUND "True")
foreach(_lib ${boost_libs})
	__boost_import(${_lib})
endforeach()
