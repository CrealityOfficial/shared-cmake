# freeimage target

__cc_find(Png)
if(CC_BC_LINUX)
__conan_import(freeimage dll)
else()
__conan_import(freeImage dll)
endif()
