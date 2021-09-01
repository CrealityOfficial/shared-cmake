# This sets the following variables:
# FMPEG_INCLUDE_DIRS
# FMPEG_INCLUDE_FOUND

if(FMPEG_INSTALL_ROOT)
	message(STATUS "FMpeg Specified FMPEG_INSTALL_ROOT : ${FMPEG_INSTALL_ROOT}")
	set(FMPEG_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(avcodec_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(avcodec_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(avformat_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(avformat_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(avutil_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(avutil_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(swscale_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(swscale_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(swresample_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(swresample_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(avdevice_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(avdevice_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
	
	set(x264_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(x264_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
							   
else()

	message("Not Set The FMPEG_INSTALL_ROOT ")
endif()
	
__search_target_components_signle(avcodec
						   INC libavcodec/avcodec.h
						   DLIB avcodec
						   LIB avcodec
						   )
__search_target_components_signle(avformat
						   INC libavformat/avformat.h
						   DLIB avformat
						   LIB avformat
						   )
__search_target_components_signle(avutil
						   INC libavutil/avutil.h
						   DLIB avutil
						   LIB avutil
						   )
__search_target_components_signle(swscale
						   INC libswscale/swscale.h
						   DLIB swscale
						   LIB swscale
						   )	
__search_target_components_signle(swresample
						   INC libswresample/swresample.h
						   DLIB swresample
						   LIB swresample
						   )
__search_target_components_signle(avdevice
						   INC libavdevice/avdevice.h
						   DLIB avdevice
						   LIB avdevice
						   )						 
__search_target_components_signle(x264
						   INC x264.h
						   DLIB x264
						   LIB x264
						   )						   
						   

__test_import_signle(avcodec dll)
__test_import_signle(avformat dll)
__test_import_signle(swscale dll)
__test_import_signle(swresample dll)
__test_import_signle(x264 dll)
__test_import_signle(avutil dll)

if(FMPEG_INCLUDE_DIRS)
	set(FMPEG_INCLUDE_FOUND 1)
	set(Fmpeg_INCLUDE_DIRS ${FMPEG_INCLUDE_DIRS})
	message(STATUS "FMPEG_INCLUDE_DIRS : ${FMPEG_INCLUDE_DIRS}")
else()
	message(STATUS "Find FMPEG include Failed")
endif()