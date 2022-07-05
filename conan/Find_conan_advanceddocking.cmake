# advancedocking target

__conan_import(advancedocking dll)
if(TARGET advancedocking AND NOT qtadvanceddocking)
	add_library(qtadvanceddocking ALIAS advancedocking)
endif()
