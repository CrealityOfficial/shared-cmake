# boost target
if(CONAN_BOOST_ROOT_RELEASE)
	set(BOOST_INCLUDE_DIRS ${CONAN_BOOST_ROOT_RELEASE}/include/)
endif()

set(BOOST_COMPONETS boost_file_system
					boost_iostreams
					boost_nowide
					boost_regex
					boost_system
					boost_thread
					)
					
if(CC_BC_WIN)
	list(APPEND BOOST_COMPONETS boost_log)
endif()

if(BOOST_STATIC)
	__conan_import(boost lib COMPONENT ${BOOST_COMPONETS})
else()
	__conan_import(boost dll COMPONENT ${BOOST_COMPONETS})
endif()

__conan_import(boost lib COMPONENT boost_test)

foreach(_component ${BOOST_COMPONETS} boost_test)
	__add_target_interface(${_component} DEF BOOST_ALL_NO_LIB)
endforeach()
