# colladadom target
if(CC_BC_EMCC)
__conan_import(colladadom lib COMPONENT colladadom colladadom141)
else()
__conan_import(colladadom dll)
endif()
