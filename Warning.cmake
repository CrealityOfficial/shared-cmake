if(WIN32)    #disable some common vs warnning
	add_compile_options(/W4)
	add_compile_options(/wd4100)
	add_compile_options(/wd4005)
	add_compile_options(/wd4201)
	add_compile_options(/wd4244)
	add_compile_options(/wd4267)
	add_compile_options(/wd4251)
	add_compile_options(/wd4127)
else(WIN32)
endif(WIN32)