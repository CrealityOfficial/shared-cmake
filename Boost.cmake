macro(__add_boost_target module)
	__source_recurse(${CMAKE_CURRENT_SOURCE_DIR} SRC)
	__source_recurse(${boost_includes}boost/${module}/ HEADER)
	
	__add_real_target(boost_${module} dll SOURCE ${SRC} ${HEADER})
	set_property(TARGET boost_${module} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${boost_includes})
endmacro()