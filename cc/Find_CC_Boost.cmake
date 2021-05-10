# This sets the following variables:
# BOOST_INCLUDE_DIRS
# BOOST_INCLUDE_FOUND

if(BOOST_INSTALL_ROOT)
	message(STATUS "Boost Specified BOOST_INSTALL_ROOT : ${BOOST_INSTALL_ROOT}")
	set(BOOST_INCLUDE_DIRS ${BOOST_INSTALL_ROOT}/include/)
	
	set(boost_file_system_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_file_system_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_file_system
							   INC boost/filesystem.hpp
							   DLIB boost_file_system
							   LIB boost_file_system
							   )
							   
	set(boost_thread_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_thread_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_thread
							   INC boost/thread.hpp
							   DLIB boost_thread
							   LIB boost_thread
							   )
							   
	set(boost_program_options_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_program_options_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_program_options
							   INC boost/program_options.hpp
							   DLIB boost_program_options
							   LIB boost_program_options
							   )

	set(boost_regex_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_regex_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_regex
							   INC boost/regex.hpp
							   DLIB boost_regex
							   LIB boost_regex
							   )

	set(boost_system_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_system_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_system
							   INC boost/system/error_code.hpp
							   DLIB boost_system
							   LIB boost_system
							   )	

	set(boost_python_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_python_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_python
							   INC boost/python.hpp
							   DLIB boost_python
							   LIB boost_python
							   )

	set(boost_serialization_INCLUDE_ROOT ${BOOST_INSTALL_ROOT}/include/)
	set(boost_serialization_LIB_ROOT ${BOOST_INSTALL_ROOT}/lib/)
	__search_target_components(boost_serialization
							   INC boost/serialization/access.hpp
							   DLIB boost_serialization
							   LIB boost_serialization
							   )								   
else()
endif()
	
add_definitions(-DBOOST_DYN_LINK)
add_definitions(-DBOOST_ALL_NO_LIB)

__test_import(boost_file_system dll)
__test_import(boost_thread dll)
__test_import(boost_program_options dll)
__test_import(boost_regex dll)
__test_import(boost_system dll)
__test_import(boost_python dll)
__test_import(boost_serialization dll)

if(BOOST_INCLUDE_DIRS)
	set(BOOST_INCLUDE_FOUND 1)
	set(Boost_INCLUDE_DIRS ${BOOST_INCLUDE_DIRS})
	message(STATUS "BOOST_INCLUDE_DIRS : ${BOOST_INCLUDE_DIRS}")
else()
	message(STATUS "Find Boost include Failed")
endif()