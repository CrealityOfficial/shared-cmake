macro(__add_common_library target)
	if(NOT INTERFACES)
		set(INTERFACES ${CMAKE_CURRENT_SOURCE_DIR})
		if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include")
			list(APPEND INTERFACES ${CMAKE_CURRENT_SOURCE_DIR}/include)
		endif()
	endif()
	
	if(NOT SRCS)
		message(FATAL_ERROR "SRCS is empty.")
	endif()
	
	if(NOT INCS)
		set(INCS ${CMAKE_CURRENT_SOURCE_DIR})
	endif()
	
	if(NOT DEFS)
		set(DEFS)
	endif()
	
	string(TOUPPER ${target} UpperName)
			
	if(CC_GLOBAL_FORCE_STATIC OR ${UpperName}_STATIC)
		__add_real_target(${target} lib SOURCE ${SRCS} 
										LIB ${LIBS}
										INC ${INCS}
										DEF ${DEFS}
										INTERFACE ${INTERFACES}
										${ARGN}
										)
		set_property(TARGET ${target} PROPERTY INTERFACE_COMPILE_DEFINITIONS USE_${UpperName}_STATIC)
	else()
		list(APPEND DEFS ${UpperName}_DLL)
		__add_real_target(${target} dll SOURCE ${SRCS} 
										LIB ${LIBS}
										INC ${INCS}
										DEF ${DEFS}
										INTERFACE ${INTERFACES}
										${ARGN}
										)
		set_property(TARGET ${target} PROPERTY INTERFACE_COMPILE_DEFINITIONS USE_${UpperName}_DLL)
	endif()
endmacro()
