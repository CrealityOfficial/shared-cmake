# boost target

if(BOOST_STATIC)
	__conan_import(boost lib COMPONENT boost_filesystem
									boost_iostreams
									boost_nowide
									boost_regex
									boost_system
									boost_thread
									)
else()
	__conan_import(boost dll COMPONENT boost_file_system
									boost_iostreams
									boost_nowide
									boost_regex
									boost_system
									boost_thread
									)
endif()
