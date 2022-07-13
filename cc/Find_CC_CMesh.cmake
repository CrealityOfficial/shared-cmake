# This sets the following variables:
# cmesh target

if(NOT TARGET cmesh)
	__cc_find(gmp)
	__cc_find(mpfr)

	__search_target_components(cmesh
							INC cmesh/poly/roof.h
							DLIB cmesh
							LIB cmesh
							PRE cmesh
							)
	
	__test_import(cmesh dll)
endif()
