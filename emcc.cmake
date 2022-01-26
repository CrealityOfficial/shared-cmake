message(STATUS "Build System -> [Emscripten Web]")

set(EMCC_WEB 1)
add_definitions(-D__WEB__)

find_package(Python3 REQUIRED)
if(NOT Python3_EXECUTABLE)
    message(FATAL_ERROR "Python3_EXECUTABLE Must be Set.")
endif()

set(PYTHON ${Python3_EXECUTABLE} CACHE STRING "Python path")
set(EMSCRIPTEN_ROOT $ENV{EMSDK}/upstream/emscripten CACHE STRING "Emscripten path")
set(CMAKE_TOOLCHAIN_FILE ${EMSCRIPTEN_ROOT}/cmake/Modules/Platform/Emscripten.cmake)
set(WEBIDL_BINDER_SCRIPT ${EMSCRIPTEN_ROOT}/tools/webidl_binder.py)
message(STATUS "PYTHON: ${PYTHON}")
message(STATUS "EMSCRIPTEN_ROOT: ${EMSCRIPTEN_ROOT}")
message(STATUS "CMAKE_TOOLCHAIN_FILE: ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "WEBIDL_BINDER_SCRIPT: ${WEBIDL_BINDER_SCRIPT}")

set(CMAKE_BUILD_TYPE Release CACHE STRING "Build Type")

macro(__emcc_idl IDL_FILE GLUE_NAME GLUE_ARG IDL_OBJ IDL_JS)
	add_custom_command(
		OUTPUT ${GLUE_NAME}.cpp ${GLUE_NAME}.js
		BYPRODUCTS parser.out WebIDLGrammar.pkl
		COMMAND ${PYTHON} ${WEBIDL_BINDER_SCRIPT} ${IDL_FILE} ${GLUE_NAME}
		COMMENT "Generating WebIDL bindings"
		VERBATIM)
		
	add_custom_command(
		OUTPUT ${GLUE_NAME}.o
		COMMAND emcc ${GLUE_NAME}.cpp ${${GLUE_ARG}} -o ${GLUE_NAME}.o
		DEPENDS ${GLUE_NAME}.cpp
		COMMENT "Building bindings"
		VERBATIM)

	set(${IDL_OBJ} ${GLUE_NAME}.o)
	set(${IDL_JS} ${GLUE_NAME}.js)
endmacro()

macro(__emcc_wasm WSAM_NAME SOURCE WSAM_ARGS)

	message(STATUS "__emcc_wasm ${${SOURCE}}")
	message(STATUS "__emcc_wasm ${${WSAM_ARGS}}")
	
	add_custom_command(
		OUTPUT ${WSAM_NAME}.js ${WSAM_NAME}.wasm
		COMMAND emcc ${${SOURCE}} ${${WSAM_ARGS}} -o ${WSAM_NAME}.js
		DEPENDS trimesh2
		COMMENT "Building WASM"
		VERBATIM)
	add_custom_target(${WSAM_NAME} 
		ALL 
		DEPENDS ${WSAM_NAME}.js ${WSAM_NAME}.wasm)
endmacro()

function(__add_emcc_target target)
	cmake_parse_arguments(target "" "IDLS;IDLINCS" "CSOURCE;LIBRARIES;WSAM_ARGS;" ${ARGN})
	set(LIBRARIES)
	if(target_LIBRARIES)
		#message(STATUS "__add_emcc_target LIBRARIES : ${target_LIBRARIES}")
		
		foreach(LIB ${target_LIBRARIES})
			list(APPEND LIBRARIES $<TARGET_FILE:${LIB}>)
		endforeach()
	endif()
	
	if(target_CSOURCE)
		#message(STATUS "__add_emcc_target CSOURCE : ${target_CSOURCE}")
		set(INTERFACE_LIBS)
		if(target_LIBRARIES)
			set(INTERFACE_LIBS ${target_LIBRARIES})
		endif()
		__add_real_target(${target}_interface lib SOURCE ${target_CSOURCE}
												  LIB ${INTERFACE_LIBS}
												  )
												  
		list(APPEND LIBRARIES $<TARGET_FILE:${target}_interface>)
	endif()
	
	message(STATUS "__add_emcc_target LIBRARIES : ${LIBRARIES}")
	
	set(EXTRA_ARGS -s EXPORT_NAME="${target}")
	if(target_IDLS)
		message(STATUS "__add_emcc_target IDLS : ${target_IDLS}")
		
		set(GLUE_ARGS -c
					  -I${CMAKE_BINARY_DIR}
					  -I${CMAKE_CURRENT_BINARY_DIR}
					  -I${CMAKE_CURRENT_SOURCE_DIR}
					  -I${CMAKE_SOURCE_DIR}/cmake
					  )
		
		if(target_IDLINCS)
			message(STATUS "__add_emcc_target IDLINCS : ${target_IDLINCS}")
			list(APPEND GLUE_ARGS -include${target_IDLINCS})
		endif()
		
		if(target_LIBRARIES)
			foreach(LIB ${target_LIBRARIES})
				get_target_property(INCLUDE_DIRS ${LIB} INTERFACE_INCLUDE_DIRECTORIES)
				if(INCLUDE_DIRS)
					foreach(inc ${INCLUDE_DIRS})
						list(APPEND GLUE_ARGS -I${inc})
					endforeach()
				endif()
			endforeach()
		endif()
		
		message(STATUS "__add_emcc_target GLUE_ARGS : ${GLUE_ARGS}")
		add_custom_command(
			OUTPUT ${target_IDLS}.cpp ${target_IDLS}.js
			BYPRODUCTS parser.out WebIDLGrammar.pkl
			COMMAND ${PYTHON} ${WEBIDL_BINDER_SCRIPT} ${CMAKE_CURRENT_SOURCE_DIR}/${target_IDLS} ${target_IDLS}
			COMMENT "Generating ${target_IDLS} WebIDL bindings"
			VERBATIM)
		
		add_custom_command(
			OUTPUT ${target_IDLS}.o
			COMMAND emcc ${target_IDLS}.cpp ${GLUE_ARGS} -o ${target_IDLS}.o
			DEPENDS ${target_IDLS}.cpp
			COMMENT "Building bindings"
			VERBATIM)	
		
		list(APPEND LIBRARIES ${target_IDLS}.o)
		set(EXTRA_ARGS --post-js ${target_IDLS}.js ${EXTRA_ARGS})
	endif()
	
	set(WARGS  #default args
		--source-map-base http://localhost:8081/
		-s MODULARIZE=1
		-s ALLOW_MEMORY_GROWTH=1
		-s ALLOW_TABLE_GROWTH=1
		-s EXPORTED_RUNTIME_METHODS=["addFunction"]
		-s DISABLE_EXCEPTION_CATCHING=1
		-s USE_SDL=0
		-s ENVIRONMENT=web
		-s NO_FILESYSTEM=1)
		
	if(target_WSAM_ARGS)
		#message(STATUS "__add_emcc_target WSAM_ARGS : ${target_WSAM_ARGS}")
		set(WARGS ${target_WSAM_ARGS})
	endif()
	
	add_custom_command(
		OUTPUT ${target}.js ${target}.wasm
		COMMAND emcc ${LIBRARIES} ${EXTRA_ARGS} ${WARGS} -o ${target}.js
		DEPENDS ${LIBRARIES}
		COMMENT "Building ${target} WASM"
		VERBATIM)
	add_custom_target(${target} 
		ALL 
		DEPENDS ${target}.js ${target}.wasm)
	
	add_custom_command(
		TARGET ${target}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.js
			${BIN_OUTPUT_DIR}/Release/${target}.js
		COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.wasm
			${BIN_OUTPUT_DIR}/Release/${target}.wasm
		#COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.wasm.map
		#	${CMAKE_CURRENT_LIST_DIR}/${target}.wasm.map	    
		)
endfunction()