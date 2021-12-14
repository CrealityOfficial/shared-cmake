# This sets the following variables:
# cmesh target

__search_target_components(cmesh
						   INC cmesh/mesh/roof.h
						   DLIB cmesh
						   LIB cmesh
						   PRE cmesh
						   )

__test_import(cmesh dll)