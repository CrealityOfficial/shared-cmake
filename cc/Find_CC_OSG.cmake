# This sets the following variables:
# OCC target

set(OSG_LIBS OpenThreads
			 osg
			 osgDB
			 osgGA
			 osgText
			 osgUtil
			 osgViewer
			 )
			 
foreach(item ${OSG_LIBS})
	__search_target_components(${item}
							INC osg/Array
							DLIB ${item}
							LIB ${item}
							PRE OpenSceneGraph
							)
endforeach()

foreach(item ${OSG_LIBS})
	__test_import(${item} dll)
endforeach()