# This sets the following variables:
# cxbin target
__cc_find(ColladaDom)
__search_target_components(cxbin
						   INC cxbin/load.h
						   DLIB cxbin
						   LIB cxbin
						   PRE cxbin
						   )

__test_import(cxbin dll)