
set(OPENCV_VERSION 470)

if(CC_BC_WIN)

	__conan_import(opencv_world470 lib)
	
elseif(CC_BC_LINUX)
	#__conan_import(ffmpeglib dll COMPONENT avcodec avdevice avfilter avformat avutil swresample swscale)
else()
	#__conan_import(ffmpeglib dll COMPONENT avcodec avdevice avfilter avformat avutil postproc swresample swscale)
endif()

