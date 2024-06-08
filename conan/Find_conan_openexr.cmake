#openexr target

if(TARGET OpenEXR::OpenEXR)
	return()
endif()

set(imath_cmake "${CONAN_OPENEXR_ROOT_RELEASE}/lib/cmake/Imath/ImathTargets.cmake")
set(openexr_cmake "${CONAN_OPENEXR_ROOT_RELEASE}/lib/cmake/OpenEXR/OpenEXRTargets.cmake")
if(EXISTS ${imath_cmake} AND EXISTS ${openexr_cmake})
	include(${imath_cmake})
	include(${openexr_cmake})
	
	find_package(Threads)
	__cc_find(zlib_static)
	
	__assert_target(Imath::Imath)
	__assert_target(OpenEXR::Iex)
	__assert_target(OpenEXR::IlmThread)
	__assert_target(OpenEXR::OpenEXRCore)
	__assert_target(OpenEXR::OpenEXR)
	__assert_target(OpenEXR::OpenEXRUtil)
endif()