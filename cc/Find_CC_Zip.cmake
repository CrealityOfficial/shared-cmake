# This sets the following variables:
# zip target

__search_target_components(zip
						   INC zip.h
						   DLIB zip
						   LIB zip
						   PRE zip
						   )

__test_import(zip dll)