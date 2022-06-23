# This sets the following variables:
# gmp target

if(NOT TARGET gmp)
	__search_target_components(gmp
							INC gmp.h
							DLIB libgmp-10
							LIB libgmp-10
							PRE gmp
							)
	
	__test_import(gmp dll)
endif()