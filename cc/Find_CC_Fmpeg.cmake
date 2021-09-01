# This sets the following variables:
# FMPEG_INCLUDE_DIRS
# FMPEG_INCLUDE_FOUND

if(FMPEG_INSTALL_ROOT)
	message(STATUS "FMpeg Specified FMPEG_INSTALL_ROOT : ${FMPEG_INSTALL_ROOT}")
	set(FMPEG_INCLUDE_DIRS ${FMPEG_INSTALL_ROOT}/include/)
	
	set(avcodec_INCLUDE_ROOT ${FMPEG_INSTALL_ROOT}/include/)
	set(avcodec_LIB_ROOT ${FMPEG_INSTALL_ROOT}/lib/)
							   
else()

	message("Not Set The FMPEG_INSTALL_ROOT ")
endif()
	
__search_target_components_signle(avcodec
						   INC libavcodec/avcodec.h
						   DLIB avcodec
						   LIB avcodec
						   )

__test_import_signle(avcodec dll)

if(FMPEG_INCLUDE_DIRS)
	set(FMPEG_INCLUDE_FOUND 1)
	set(Fmpeg_INCLUDE_DIRS ${FMPEG_INCLUDE_DIRS})
	message(STATUS "FMPEG_INCLUDE_DIRS : ${FMPEG_INCLUDE_DIRS}")
else()
	message(STATUS "Find FMPEG include Failed")
endif()