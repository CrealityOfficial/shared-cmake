function(__get_main_git_hash _git_hash)
	if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
		execute_process(
			COMMAND git rev-parse HEAD
			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
			OUTPUT_VARIABLE GIT_HASH
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)
	endif()
	if(NOT GIT_HASH)
		set(GIT_HASH "NO_GIT_COMMIT_HASH_DEFINED")
	endif()
	if(BUILD_VERSION_HASH)
		set(GIT_HASH "${BUILD_VERSION_HASH}")
	endif()
	set(${_git_hash} "${GIT_HASH}" PARENT_SCOPE)
endfunction()

function(__get_usr_binary_git_hash _git_hash)
	if(EXISTS "$ENV{USR_INSTALL_ROOT}/.git")
		execute_process(
			COMMAND git rev-parse HEAD
			WORKING_DIRECTORY $ENV{USR_INSTALL_ROOT}
			OUTPUT_VARIABLE GIT_HASH
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)
		set(${_git_hash} "${GIT_HASH}" PARENT_SCOPE)
	endif()
endfunction()

macro(__write_usr_binary_git_hash _hash)
	if(${_hash})
		message(STATUS "Write Binary GIT_COMMIT_HASH -> [${${_hash}}]") 
		if(CC_BC_WIN)
			set(FILENAME "usr-binary-win.hash")
			file(WRITE ${FILENAME} ${${_hash}})
		elseif(CC_BC_MAC)
			set(FILENAME "usr-binary-mac.hash")
			file(WRITE ${FILENAME} ${${_hash}})
		elseif(CC_BC_LINUX)
			set(FILENAME "usr-binary-linux.hash")
			file(WRITE ${FILENAME} ${${_hash}})
		endif()
	else()
		message(STATUS "Usr Binary NO_GIT_COMMIT_HASH_DEFINED")
	endif()
endmacro()

function(__bind_usr_binary)
	__get_usr_binary_git_hash(USR_BINARY_HASH)
	message(STATUS "__get_usr_binary_git_hash [${USR_BINARY_HASH}]")
			
	__write_usr_binary_git_hash(USR_BINARY_HASH)
endfunction()

__bind_usr_binary()