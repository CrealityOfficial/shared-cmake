

set(OPENCASCADE_COMPONETS TKBin
						  TKBinL
						  TKBinTObj
						  TKBinXCAF
						  TKBO
						  TKBool
						  TKBRep
						  TKCAF
						  TKCDF
						  TKD3DHost
						  TKD3DHostTest
						  TKDCAF
						  TKDFBrowser
						  TKDraw
						  TKernel
						  TKExpress
						  TKFeat
						  TKFillet
						  TKG2d
						  TKG3d
						  TKGeomAlgo
						  TKGeomBase
						  TKHLR
						  TKIGES
						  TKIVtk
						  TKIVtkDraw
						  TKLCAF
						  TKMath
						  TKMesh
						  TKMeshVS
						  TKMessageModel
						  TKMessageView
						  TKOffset
						  TKOpenGl
						  TKOpenGles
						  TKOpenGlesTest
						  TKOpenGlTest
						  TKPrim
						  TKQADraw
						  TKRWMesh
						  TKService
						  TKShapeView
						  TKShHealing
						  TKStd
						  TKStdL
						  TKSTEP
						  TKSTEP209
						  TKSTEPAttr
						  TKSTEPBase
						  TKSTL
						  TKTInspector
						  TKTInspectorAPI
						  TKTObj
						  TKTObjDRAW
						  TKToolsDraw
						  TKTopAlgo
						  TKTopTest
						  TKTreeModel
						  TKV3d
						  TKVCAF
						  TKView
						  TKViewerTest
						  TKVInspector
						  TKVRML
						  TKXCAF
						  TKXDE
						  TKXDECascade
						  TKXDEDRAW
						  TKXDEIGES
						  TKXDESTEP
						  TKXMesh
						  TKXml
						  TKXmlL
						  TKXmlTObj
						  TKXmlXCAF
						  TKXSBase
						  TKXSDRAW
					)
					
if(CC_BC_WIN)
	#list(APPEND OPENCASCADE_COMPONETS )


elseif(CC_BC_LINUX)
	#__conan_import(ffmpeglib dll COMPONENT avcodec avdevice avfilter avformat avutil swresample swscale)
else()
	#__conan_import(ffmpeglib dll COMPONENT avcodec avdevice avfilter avformat avutil postproc swresample swscale)
endif()


if(OPENCASCADE_STATIC)
	__conan_import(opencascade lib COMPONENT ${OPENCASCADE_COMPONETS})
else()
	__conan_import(opencascade dll COMPONENT ${OPENCASCADE_COMPONETS})
endif()

#__conan_import(opencascade lib COMPONENT boost_test)