# This sets the following variables:
# FMPEG_INCLUDE_DIRS
# FMPEG_INCLUDE_FOUND

set(FMPEG_INSTALL_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib)
if(FMPEG_INSTALL_ROOT)
	message(STATUS "FMpeg Specified FMPEG_INSTALL_ROOT : ${FMPEG_INSTALL_ROOT}")
	set(FMPEG_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(avcodec_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	set(avformat_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	set(avutil_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	set(swscale_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(swresample_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(avdevice_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(x264_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
							   
else()

	message("Not Set The FMPEG_INSTALL_ROOT ")
endif()
	
#__search_target_components_signle(avcodec
#						   INC libavcodec/avcodec.h
#						   DLIB avcodec
#						   LIB avcodec
#						   )
#__search_target_components_signle(avformat
#						   INC libavformat/avformat.h
#						   DLIB avformat
#						   LIB avformat
#						   )
#__search_target_components_signle(avutil
#						   INC libavutil/avutil.h
#						   DLIB avutil
#						   LIB avutil
#						   )
#__search_target_components_signle(swscale
#						   INC libswscale/swscale.h
#						   DLIB swscale
#						   LIB swscale
#						   )	
#__search_target_components_signle(swresample
#						   INC libswresample/swresample.h
#						   DLIB swresample
#						   LIB swresample
#						   )
#__search_target_components_signle(avdevice
#						   INC libavdevice/avdevice.h
#						   DLIB avdevice
#						   LIB avdevice
#						   )						 
#__search_target_components_signle(x264
#						   INC x264.h
#						   DLIB x264
#						   LIB x264
#						   )	
#
if(WIN32)
	find_library(avcodec_LIBRARIES_DEBUG
				NAMES avcodec
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(avcodec_LIBRARIES_RELEASE
				NAMES avcodec
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("avcodec_LIBRARIES_DEBUG  ${avcodec_LIBRARIES_DEBUG}")
	message("avcodec_LIBRARIES_RELEASE  ${avcodec_LIBRARIES_RELEASE}")
				
	find_library(avformat_LIBRARIES_DEBUG
				NAMES avformat
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(avformat_LIBRARIES_RELEASE
				NAMES avformat
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("avformat_LIBRARIES_DEBUG  ${avcodec_LIBRARIES_DEBUG}")
	message("avformat_LIBRARIES_RELEASE  ${avformat_LIBRARIES_RELEASE}")
				
	find_library(avutil_LIBRARIES_DEBUG
				NAMES avutil
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(avutil_LIBRARIES_RELEASE
				NAMES avutil
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("avutil_LIBRARIES_DEBUG  ${avutil_LIBRARIES_DEBUG}")
	message("avutil_LIBRARIES_RELEASE  ${avutil_LIBRARIES_RELEASE}")
				
	find_library(swscale_LIBRARIES_DEBUG
				NAMES swscale
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(swscale_LIBRARIES_RELEASE
				NAMES swscale
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("swscale_LIBRARIES_DEBUG  ${swscale_LIBRARIES_DEBUG}")
	message("swscale_LIBRARIES_RELEASE  ${swscale_LIBRARIES_RELEASE}")
				
	find_library(swresample_LIBRARIES_DEBUG
				NAMES swresample
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(swresample_LIBRARIES_RELEASE
				NAMES swresample
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("swresample_LIBRARIES_DEBUG  ${swresample_LIBRARIES_DEBUG}")
	message("swresample_LIBRARIES_RELEASE  ${swresample_LIBRARIES_RELEASE}")
				
	find_library(avdevice_LIBRARIES_DEBUG
				NAMES avdevice
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(avdevice_LIBRARIES_RELEASE
				NAMES avdevice
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("avdevice_LIBRARIES_DEBUG  ${avdevice_LIBRARIES_DEBUG}")
	message("avdevice_LIBRARIES_RELEASE  ${avdevice_LIBRARIES_RELEASE}")
				
	find_library(x264_LIBRARIES_DEBUG
				NAMES x264
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")		
	find_library(x264_LIBRARIES_RELEASE
				NAMES x264
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/lib/")
	message("x264_LIBRARIES_DEBUG  ${x264_LIBRARIES_DEBUG}")
	message("x264_LIBRARIES_RELEASE  ${x264_LIBRARIES_RELEASE}")
else()
	message("find cc fmpeg macOS")
	find_library(avcodec_LIBRARIES_DEBUG
				NAMES avcodec.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(avcodec_LIBRARIES_RELEASE
				NAMES avcodec.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("avcodec_LIBRARIES_DEBUG  ${avcodec_LIBRARIES_DEBUG}")
	message("avcodec_LIBRARIES_RELEASE  ${avcodec_LIBRARIES_RELEASE}")
				
	find_library(avformat_LIBRARIES_DEBUG
				NAMES avformat.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(avformat_LIBRARIES_RELEASE
				NAMES avformat.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("avformat_LIBRARIES_DEBUG  ${avformat_LIBRARIES_DEBUG}")
	message("avformat_LIBRARIES_RELEASE  ${avformat_LIBRARIES_RELEASE}")
				
	find_library(avutil_LIBRARIES_DEBUG
				NAMES avutil.56
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(avutil_LIBRARIES_RELEASE
				NAMES avutil.56
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("avutil_LIBRARIES_DEBUG  ${avutil_LIBRARIES_DEBUG}")
	message("avutil_LIBRARIES_RELEASE  ${avutil_LIBRARIES_RELEASE}")
				
	find_library(swscale_LIBRARIES_DEBUG
				NAMES swscale.5
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(swscale_LIBRARIES_RELEASE
				NAMES swscale.5
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("swscale_LIBRARIES_DEBUG  ${swscale_LIBRARIES_DEBUG}")
	message("swscale_LIBRARIES_RELEASE  ${swscale_LIBRARIES_RELEASE}")
				
	find_library(swresample_LIBRARIES_DEBUG
				NAMES swresample.3
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(swresample_LIBRARIES_RELEASE
				NAMES swresample.3
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("swresample_LIBRARIES_DEBUG  ${swresample_LIBRARIES_DEBUG}")
	message("swresample_LIBRARIES_RELEASE  ${swresample_LIBRARIES_RELEASE}")
				
	find_library(avdevice_LIBRARIES_DEBUG
				NAMES avdevice.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(avdevice_LIBRARIES_RELEASE
				NAMES avdevice.58
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("avdevice_LIBRARIES_DEBUG  ${avdevice_LIBRARIES_DEBUG}")
	message("avdevice_LIBRARIES_RELEASE  ${avdevice_LIBRARIES_RELEASE}")
				
	find_library(x264_LIBRARIES_DEBUG
				NAMES x264
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")		
	find_library(x264_LIBRARIES_RELEASE
				NAMES x264
				PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ffmpeglib/bin_osX/")
	message("x264_LIBRARIES_DEBUG  ${x264_LIBRARIES_DEBUG}")
	message("x264_LIBRARIES_RELEASE  ${x264_LIBRARIES_RELEASE}")
endif()						   
						   

__test_import(avcodec dll)
__test_import(avformat dll)
__test_import(swscale dll)
__test_import(swresample dll)
__test_import(x264 dll)
__test_import(avutil dll)
__test_import(avdevice dll)

if(FMPEG_INCLUDE_DIRS)
	set(FMPEG_INCLUDE_FOUND 1)
	set(Fmpeg_INCLUDE_DIRS ${FMPEG_INCLUDE_DIRS})
	message(STATUS "FMPEG_INCLUDE_DIRS : ${FMPEG_INCLUDE_DIRS}")
else()
	message(STATUS "Find FMPEG include Failed")
endif()