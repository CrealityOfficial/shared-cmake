# ovdbutil target
if(CC_BC_EMCC)
__conan_import(ovdbutil lib COMPONENT ovdbutil openvdb)
else()
__conan_import(ovdbutil dll COMPONENT ovdbutil openvdb)
endif()
