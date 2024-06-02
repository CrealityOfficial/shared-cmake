#embree target

set(embree_cmake "${CONAN_EMBREE_ROOT_RELEASE}/lib/cmake/embree-3.13.5/embree-targets.cmake")
if(EXISTS ${embree_cmake})
	include(${embree_cmake})
	__copy_find_targets(embree)
endif()