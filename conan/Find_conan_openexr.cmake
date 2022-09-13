
set(EXR_COMPONENTS Iex IexMath IlmThread Imath OpenEXR OpenEXRUtil)

__conan_import(openexr dll COMPONENT ${EXR_COMPONENTS})

__add_target_interface(Imath DEF IMATH_DLL)