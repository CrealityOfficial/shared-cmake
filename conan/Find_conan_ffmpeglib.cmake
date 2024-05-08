
if(CC_BC_WIN)
	__conan_import_one(ffmpeglib dll NAME avcodec LIB avcodec DLL avcodec-58)
	__conan_import_one(ffmpeglib dll NAME avdevice LIB avdevice DLL avdevice-58)
	__conan_import_one(ffmpeglib dll NAME avfilter LIB avfilter DLL avfilter-7)
	__conan_import_one(ffmpeglib dll NAME avformat LIB avformat DLL avformat-58)
	__conan_import_one(ffmpeglib dll NAME avutil LIB avutil DLL avutil-56)
	__conan_import_one(ffmpeglib dll NAME postproc LIB postproc DLL postproc-55)
	__conan_import_one(ffmpeglib dll NAME swresample LIB swresample DLL swresample-3)
	__conan_import_one(ffmpeglib dll NAME swscale LIB swscale DLL swscale-5)
	__conan_import_one(ffmpeglib lib NAME metartc6 LIB metartc6)
	__conan_import_one(ffmpeglib lib NAME metartccore6 LIB metartccore6)
	__conan_import_one(ffmpeglib lib NAME yangwincodec6 LIB yangwincodec6)
	__conan_import_one(ffmpeglib lib NAME srtp2 LIB srtp2)
	__conan_import_one(ffmpeglib lib NAME usrsctp LIB usrsctp)
	__conan_import_one(ffmpeglib lib NAME opus LIB opus)
	__conan_import_one(ffmpeglib lib NAME speexdsp LIB speexdsp)
	
elseif(CC_BC_LINUX)
	 __conan_import_one(ffmpeglib ndll NAME avcodec LIB libavcodec.so.58 DLL libavcodec.so.58)
        __conan_import_one(ffmpeglib ndll NAME avdevice LIB libavdevice.so.58 DLL libavdevice.so.58)
        __conan_import_one(ffmpeglib ndll NAME avfilter LIB libavfilter.so.7 DLL libavfilter.so.7)
        __conan_import_one(ffmpeglib ndll NAME avformat LIB libavformat.so.58 DLL libavformat.so.58)
        __conan_import_one(ffmpeglib ndll NAME avutil  LIB libavutil.so.56 DLL libavutil.so.56)
        __conan_import_one(ffmpeglib ndll NAME swresample LIB libswresample.so.3 DLL libswresample.so.3)
        __conan_import_one(ffmpeglib ndll NAME swscale  LIB libswscale.so.5 DLL libswscale.so.5)
elseif(CC_BC_MAC)
	__conan_import_one(ffmpeglib dll NAME avcodec LIB avcodec.58 DLL avcodec.58)
	__conan_import_one(ffmpeglib dll NAME avdevice LIB avdevice.58 DLL avdevice.58)
	__conan_import_one(ffmpeglib dll NAME avfilter LIB avfilter.7 DLL avfilter.7)
	__conan_import_one(ffmpeglib dll NAME avformat LIB avformat.58 DLL avformat.58)
	__conan_import_one(ffmpeglib dll NAME avutil  LIB avutil.56 DLL avutil.56)
	__conan_import_one(ffmpeglib dll NAME swresample LIB swresample.3 DLL swresample.3)
	__conan_import_one(ffmpeglib dll NAME swscale  LIB swscale.5 DLL swscale.5)
else()
	__conan_import(ffmpeglib dll COMPONENT avcodec avdevice avfilter avformat avutil postproc swresample swscale)
endif()
