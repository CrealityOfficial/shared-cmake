macro(__add_boost_target module)
	__source_recurse(${CMAKE_CURRENT_SOURCE_DIR} SRC)
	__source_recurse(${boost_includes}boost/${module}/ HEADER)
	
	__add_real_target(boost_${module} dll SOURCE ${SRC} ${HEADER})
	set_property(TARGET boost_${module} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${boost_includes})
endmacro()

macro(__find_boost_root)
	find_path(boost_INCLUDE_DIR boost/core/typeinfo.hpp
		HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
		PATHS "/usr/include/")
endmacro()