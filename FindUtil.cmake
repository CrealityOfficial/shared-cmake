macro(__required_find_package package)
	find_package(${package} REQUIRED)
	if(NOT DEFINED ${package}_FOUND)
		message(FATAL_ERROR "${package} not found!")
	else()
		message(STATUS "${package} include : ${${package}_INCLUDE_DIRS}")
	endif()
endmacro()

macro(__find_gtest)
	__find_one_package(gtest gtest/gtest.h lib CX_ANALYSIS_ROOT)
	__find_one_package(gtest_main gtest/gtest.h lib CX_ANALYSIS_ROOT)
endmacro()

macro(__find_librevenge)
	__find_one_package(librevenge libcdr/libcdr.h librevenge dll CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_trimesh2)
	__find_one_package(trimesh2 trimesh2/TriMesh.h "" lib CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_clipper)
	__find_one_package(clipper clipper/clipper.hpp "" lib CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_zlib)
	__find_one_package(zlib zlib.h zlib dll CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_tinyxml)
	__find_one_package(tinyxml tinyxml/tinystr.h "" lib CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_freetype)
	__find_one_package(freetype ft2build.h freetype2 dll CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_dxflib)
	__find_one_package(dxflib dxf/dl_attributes.h "" lib CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_cura)
	__find_one_package(cura Application.h cura lib CX_THIRDPARTY_ROOT)
endmacro()

macro(__find_quazip)
	__find_one_package(quazip quazip/quazip.h "" dll CX_THIRDPARTY_ROOT)
endmacro()

macro(__include_stb)
	__required_find_package(stb)
	include_directories(${stb_INCLUDE_DIRS})
endmacro()

macro(__include_rapidjson)
	__required_find_package(rapidjson)
	include_directories(${rapidjson_INCLUDE_DIRS})
endmacro()

macro(__include_vcg)
	__required_find_package(vcg)
	include_directories(${vcg_INCLUDE_DIRS})
endmacro()

macro(__include_eigen)
	__required_find_package(eigen)
	include_directories(${eigen_INCLUDE_DIRS})
endmacro()
