# boost target
if(CONAN_BOOST_ROOT_RELEASE)
	set(BOOST_INCLUDE_DIRS ${CONAN_BOOST_ROOT_RELEASE}/include/)
endif()

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
