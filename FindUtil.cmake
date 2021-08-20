macro(__required_find_package package)
	find_package(${package} REQUIRED)
	if(NOT DEFINED ${package}_FOUND)
		message(FATAL_ERROR "${package} not found!")
	else()
		message(STATUS "${package} include : ${${package}_INCLUDE_DIRS}")
	endif()
endmacro()

macro(__assert_parameter param)
	if(NOT ${param})
		message(FATAL_ERROR "${param} NOT DEFINED!")
	else()
		message(STATUS "${param} DEFINED! ---> ${${param}}")
	endif()
endmacro()

macro(__find_gtest)
	__cc_find(Gtest)
	__assert_target(gtest)
	__assert_target(gtest_main)
endmacro()

macro(__find_librevenge)
	__cc_find(LibRevenge)
	__assert_target(librevenge)
endmacro()

macro(__find_trimesh2)
	__cc_find(Trimesh2)
	__assert_target(trimesh2)
endmacro()

macro(__find_clipper)
	__cc_find(Clipper)
	__assert_target(clipper)
endmacro()

macro(__find_zlib)
	__cc_find(Zlib)
	__assert_target(zlib)
endmacro()

macro(__find_qhull)
	__cc_find(QHull)
	__assert_target(qhullcpp)
	__assert_target(qhullstatic_r)
endmacro()

macro(__find_openssl)
	__cc_find(OpenSSL)
	__assert_target(ssl)
	__assert_target(crypto)
endmacro()

macro(__find_tinyxml)
	__cc_find(TinyXml)
	__assert_target(tinyxml)
endmacro()

macro(__find_freetype)
	__cc_find(Freetype)
	__assert_target(freetype)
endmacro()

macro(__find_dxflib)
	__cc_find(Dxflib)
	__assert_target(dxflib)
endmacro()

macro(__find_spdlog)
	__cc_find(Spdlog)
	__assert_target(spdlog)
endmacro()

macro(__find_alibabacloud)
	__cc_find(AliyunOss)
	__assert_target(AliyunOss)
endmacro()

macro(__find_cura)
	__cc_find(Cura)
	__assert_target(cura)
endmacro()

macro(__find_quazip)
	__cc_find(Quazip)
	__assert_target(quazip)
endmacro()

macro(__find_mysql)
	__find_one_package(mysqlclient mysql.h "mysql" lib MY_SQL_ROOT)
endmacro()

macro(__include_stb)
	__cc_find(Stb)
	__assert_parameter(STB_INCLUDE_DIRS)
	include_directories(${STB_INCLUDE_DIRS})
endmacro()

macro(__include_rapidjson)
	__cc_find(RapidJson)
	__assert_parameter(RAPIDJSON_INCLUDE_DIRS)
	include_directories(${RAPIDJSON_INCLUDE_DIRS})
endmacro()

macro(__include_vcg)
	__cc_find(VCG)
	__assert_parameter(VCG_INCLUDE_DIRS)
	include_directories(${VCG_INCLUDE_DIRS})
endmacro()

macro(__include_eigen)
	__cc_find(Eigen)
	__assert_parameter(EIGEN_INCLUDE_DIRS)
	include_directories(${EIGEN_INCLUDE_DIRS})
endmacro()
