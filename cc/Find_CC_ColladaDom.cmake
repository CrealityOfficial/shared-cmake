# This sets the following variables:
# collada-dom target

if(NOT TARGET collada-dom)
	__cc_find(Boost)
	__search_target_components(collada-dom
							INC dom/domAny.h
							DLIB collada-dom
							LIB collada-dom
							PRE collada-dom
							)
	
	__test_import(collada-dom dll)
endif()