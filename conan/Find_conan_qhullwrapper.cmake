# qhullwrapper target

__conan_import(qhullwrapper dll)
if(TARGET qhullwrapper AND NOT TARGET qhullWrapper)
	add_library(qhullWrapper ALIAS qhullwrapper)
endif()
