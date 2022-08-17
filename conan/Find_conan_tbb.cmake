# tbb target
if(CC_BC_EMCC)
	__conan_import(tbb lib)
else()
__conan_import_one(tbb dll NAME tbb
						   LIB  tbb
						   DLL  tbb
						   INTERFACE_DEF __TBB_NO_IMPLICIT_LINKAGE
						   )
endif()
