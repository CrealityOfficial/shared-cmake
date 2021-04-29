macro(__enable_openmp)
	find_package(OpenMP)
	if(OPENMP_FOUND)
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
	endif()
endmacro()

macro(__add_openmp_lib arg1)
    find_library(OPENOMP_LIBRARIES
             NAMES omp
             PATHS "/usr/local/lib")
    message(STATUS ${OPENOMP_LIBRARIES})
    target_link_libraries(${arg1} PRIVATE ${OPENOMP_LIBRARIES})
endmacro()

macro(__disable_openmp)
	include(AdjustToolFlags)
	AdjustToolFlags(CMAKE_C_FLAGS REMOVALS "${OpenMP_C_FLAGS}")
	AdjustToolFlags(CMAKE_CXX_FLAGS REMOVALS "${OpenMP_CXX_FLAGS}")
	AdjustToolFlags(CMAKE_EXE_LINKER_FLAGS REMOVALS "${OpenMP_EXE_LINKER_FLAGS}")
endmacro()