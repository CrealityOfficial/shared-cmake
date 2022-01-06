# This sets the following variables:
# nlopt target

__search_target_components(nlopt
						   INC nlopt.hpp
						   DLIB nlopt
						   LIB nlopt
						   PRE nlopt
						   )

__test_import(nlopt dll)