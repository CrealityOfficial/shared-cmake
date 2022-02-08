include(ConfigureTarget)

include(ConfigureQt)

include(FileUtil)

include(ConfigureProperty)

include(FindUtil)
include(PackageUtil)

include(Boost)
include(openmp)

include(CXX)
include(pch)
include(Warning)

include(cc)
include(InstallUtil)

include(collect/CollectEntry)
include(qt/QtEntry)
include(render/RenderEntry)

message(STATUS "CMAKE_SYSTEM_NAME ---> ${CMAKE_SYSTEM_NAME}")
if(CMAKE_SYSTEM_NAME)
	if(${CMAKE_SYSTEM_NAME} STREQUAL "Emscripten")
		include(emcc)
	endif()
endif()