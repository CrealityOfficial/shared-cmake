# This sets the following variables:
# zlib target

set(OCC_LIBS TKVCAF
			 TKVrml
			 TKStl
			 TKBrep
			 TKIGES
			 TKShHealing
			 TKStep
			 TKXSBase
			 TKBool
			 TKCAF
			 TKCDF
			 TKernel
			 TKFeat
			 TKFillet
			 TKG2d
			 TKG3d
			 TKGeomAlgo
			 TKGeomBase
			 TKHLR
			 TKMath
			 TKOffset
			 TKPrim
			 TKService
			 TKTopAlgo
			 TKV3d
			 TKOpenGl
			 TKLCAF
			 )
if(OCC_INSTALL_ROOT)
	message(STATUS "Specified OCC_INSTALL_ROOT : ${OCC_INSTALL_ROOT}")
	
	foreach(item ${OCC_LIBS})
		set(${item}_INCLUDE_ROOT ${OCC_INSTALL_ROOT}/include/occ/)
		set(${item}_LIB_ROOT ${OCC_INSTALL_ROOT}/lib/)
		__search_target_components(${item}
								INC AIS.hxx
								DLIB ${item}
								LIB ${item}
								)
	endforeach()
else()
endif()

foreach(item ${OCC_LIBS})
	__test_import(${item} dll)
	__assert_target(${item})
endforeach()

set(OCC_BASE_LIBS TKernel TKMath)
set(OCC_IMPORT_LIBS ${OCC_BASE_LIBS} TKIGES TKXSBase)