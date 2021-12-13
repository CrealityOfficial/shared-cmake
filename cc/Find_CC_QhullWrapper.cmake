# This sets the following variables:
# qhullWrapper target

__search_target_components(qhullWrapper
						   INC qhullWrapper/interface.h
						   DLIB qhullWrapper
						   LIB qhullWrapper
						   PRE qhullWrapper
						   )

__test_import(qhullWrapper dll)