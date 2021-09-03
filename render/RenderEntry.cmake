message(STATUS "include render/RenderEntry.cmake")

if(WIN32 OR NOT CC_BUILD_IPHONE_PLATFORM)
	set(FORCE_OPENGL_CORE_PROFILE3 1)
endif()