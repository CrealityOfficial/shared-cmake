# colladadom target
if(CC_BC_EMCC)
__conan_import(colladadom lib COMPONENT colladadom colladadom141)
else if(CC_BC_LINUX)
__conan_import(colladadom lib COMPONENT colladadom colladadom141)
else()
__conan_import(colladadom dll COMPONENT colladadom colladadom141)
endif()
