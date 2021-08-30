# This sets the following variables:
# FFMPEG_INCLUDE_DIRS
# FFMPEG_INCLUDE_FOUND

if(FFMPEG_INSTALL_ROOT)
	message(STATUS "FFMpeg Specified FFMPEG_INSTALL_ROOT : ${FFMPEG_INSTALL_ROOT}")
	set(FFMPEG_INCLUDE_DIRS ${FFMPEG_INSTALL_ROOT}/include/)
	
    set(libavformat_INCLUDE_ROOT ${FFMPEG_INSTALL_ROOT}/include/)
	set(libavformat_LIB_ROOT ${FFMPEG_INSTALL_ROOT}/lib/)    
	
	set(libavcodec_INCLUDE_ROOT ${FFMPEG_INSTALL_ROOT}/include/)
	set(libavcodec_LIB_ROOT ${FFMPEG_INSTALL_ROOT}/lib/)
	
	set(libavutil_INCLUDE_ROOT ${FFMPEG_INSTALL_ROOT}/include/)
	set(libavutil_LIB_ROOT ${FFMPEG_INSTALL_ROOT}/lib/)	
	
	set(libswscale_INCLUDE_ROOT ${FFMPEG_INSTALL_ROOT}/include/)
	set(libswscale_LIB_ROOT ${FFMPEG_INSTALL_ROOT}/lib/)	
	
	set(libswresample_INCLUDE_ROOT ${FFMPEG_INSTALL_ROOT}/include/)
	set(libswresample_LIB_ROOT ${FFMPEG_INSTALL_ROOT}/lib/)
else()
	find_path(FFMPEG_INCLUDE_DIRS
			NAMES libavutil/avconfig.h
			HINTS "${FFMPEG_INSTALL_ROOT}"
			PATHS "/usr/include/" "/usr/local/include/" "/usr/local/include/ffmpeg/"
					"$ENV{USR_INSTALL_FFMPEG}/include/" "$ENV{USR_INSTALL_FFMPEG}/include"
			NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			)
endif()

__search_target_components(libavformat
						   INC libavformat/avformat.h
						   DLIB libavformat
						   LIB libavformat
						   )
__search_target_components(libavutil
						   INC libavutil/avutil.h
						   DLIB libavutil
						   LIB libavutil
						   ) 
						   
__search_target_components(libswscale
						   INC libswscale/swscale.h
						   DLIB libswscale
						   LIB libswscale
						   )
__search_target_components(libswresample
						   INC libswresample/swresample.h
						   DLIB libswresample
						   LIB libswresample
						   ) 
__search_target_components(libavcodec
						   INC libavcodec/avcodec.h
						   DLIB libavcodec
						   LIB libavcodec
						   ) 
						   
						   
__test_import(libavformat dll)
__test_import(libavutil dll)
__test_import(libswscale dll)
__test_import(libswresample dll)
__test_import(libavcodec dll)

if(FFMPEG_INSTALL_ROOT)
	set(FFMPEG_INCLUDE_FOUND 1)
	set(FFMpeg_INCLUDE_DIRS ${BOOST_INCLUDE_DIRS})
	message(STATUS "FFMPEG_INCLUDE_FOUND : ${FFMPEG_INCLUDE_FOUND}")
else()
	message(STATUS "Find FFMpeg include Failed")
endif()