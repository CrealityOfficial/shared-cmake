# trimesh2 target

if(NOT TARGET trimesh2)
	__assert_parameter(CONAN_TRIMESH2_ROOT_RELEASE)
	set(trimesh2_INCLUDE_DIRS ${CONAN_TRIMESH2_ROOT_RELEASE}/include/)
	
    if(CC_BC_WIN)
		set(trimesh2_LIBRARIES_DEBUG "${CONAN_TRIMESH2_ROOT_DEBUG}/lib/Debug/trimesh2.lib")
	    set(trimesh2_LIBRARIES_RELEASE "${CONAN_TRIMESH2_ROOT_RELEASE}/lib/Release/trimesh2.lib")
	elseif(CC_BC_LINUX)	
	endif()
	
	__test_import(trimesh2 lib)
endif()
