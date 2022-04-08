#target OpenMP::OpenMP_CXX

macro(__enable_openmp)
if(CC_BC_WIN OR CC_BC_MAC)
	find_package(OpenMP REQUIRED)
	if(OPENMP_FOUND)
		message("__enable_opemmp Find OpenMP.")
		if(ANDROID)
			message(WARNING "OpenMP_CXX_LIBRARIES:  ${OpenMP_CXX_LIBRARIES}")
			message(WARNING "OpenMP_CXX_FLAGS:  ${OpenMP_CXX_FLAGS}")
		endif()
		if(TARGET OpenMP::OpenMP_CXX)
			message(STATUS "OpenMP TARGET OpenMP::OpenMP_CXX Imported.")
		endif()
	endif()
elseif(CC_BC_LINUX)
if(NOT OPENMP_ROOT)
	set(OPENMP_ROOT usr/lib/llvm-10) 
endif()

if(NOT EXISTS ${OPENMP_ROOT}/include/openmp/omp.h)
	message(FATAL_ERROR "OPENMP_ROOT [${OPENMP_ROOT}] error.")
endif()
set(OpenMP::OpenMP_CXX_INCLUDE_DIRS ${OPENMP_ROOT}/include/openmp)

    find_library(OpenMP::OpenMP_CXX_LIBRARIES_DEBUG
				NAMES omp
				PATHS "${OPENMP_ROOT}/lib/")
				
	find_library(OpenMP::OpenMP_CXX_LIBRARIES_RELEASE
			NAMES omp
			PATHS "${OPENMP_ROOT}/lib/")
    set(OpenMP::OpenMP_CXX_LOC_DEBUG ${OpenMP::OpenMP_CXX_LIBRARIES_DEBUG})
	set(OpenMP::OpenMP_CXX_RELEASE ${OpenMP::OpenMP_CXX_LIBRARIES_RELEASE})

	message("OpenMP::OpenMP_CXX_INCLUDE_DIRS  ${OpenMP::OpenMP_CXX_INCLUDE_DIRS}")

	message("OpenMP::OpenMP_CXX_LIBRARIES_DEBUG  ${OpenMP::OpenMP_CXX_LIBRARIES_DEBUG}")
	message("OpenMP::OpenMP_CXX_LIBRARIES_RELEASE  ${OpenMP::OpenMP_CXX_LIBRARIES_RELEASE}")

	if(OpenMP::OpenMP_CXX_INCLUDE_DIRS AND OpenMP::OpenMP_CXX_LIBRARIES_DEBUG AND OpenMP::OpenMP_CXX_LIBRARIES_RELEASE)
		set(OpenMP::OpenMP_CXX_FOUND "True")
		__import_target(OpenMP::OpenMP_CXX dll)
		message("import target OpenMP::OpenMP_CXX +++++")
	endif()
	
endif()
endmacro()

macro(__use_openmp target)
	
endmacro()

#macro(__add_openmp_lib arg1)
#    find_library(OPENOMP_LIBRARIES
#             NAMES omp
#             PATHS "/usr/local/lib")
#    message(STATUS ${OPENOMP_LIBRARIES})
#	if(OPENOMP_LIBRARIES)
#		target_link_libraries(${arg1} PRIVATE ${OPENOMP_LIBRARIES})
#	endif()
#endmacro()

#macro(__disable_openmp)
#	string(REPLACE "-openmp" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
#	string(REPLACE "-openmp" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
#
#	include(AdjustToolFlags)
#	AdjustToolFlags(CMAKE_C_FLAGS REMOVALS "/-openmp")
#	AdjustToolFlags(CMAKE_CXX_FLAGS REMOVALS "/-openmp")
#	AdjustToolFlags(CMAKE_EXE_LINKER_FLAGS REMOVALS "${OpenMP_EXE_LINKER_FLAGS}")
#endmacro()

