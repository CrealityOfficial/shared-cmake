SET(CMAKE_PREFIX_PATH $ENV{QT5_DIR})

macro(__enable_qt5)
	set(CMAKE_AUTOMOC ON)
	set(CMAKE_AUTORCC ON)

	find_package(Qt5 COMPONENTS Core Widgets Gui Quick Qml Xml 3DCore 3DRender 3DExtras 3DInput 3DLogic 3DQuick Concurrent OpenGL REQUIRED)
	include(qml)
	
	set(QT5_ENABLED 1)
endmacro()


macro(__target_copyqt_plugins target)
if(Qt5Core_DIR)
	set(COPY_SOURCE_DLL_DIR "${Qt5Core_DIR}/../../../plugins/platforms/")
	add_custom_command(TARGET ${target} POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E copy_directory
				${COPY_SOURCE_DLL_DIR}
				"$<TARGET_FILE_DIR:${target}>/platforms/"
				)
else()
	message("Qt5Core_DIR not exits.  __enable_qt5 first")
endif()
endmacro()

set(QtQmlQ3dLibs Qt5::Widgets Qt5::Quick Qt5::Qml Qt5::3DExtras Qt5::OpenGL)
set(QtQmlLibs Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Qml)
set(QtGuiLibs Qt5::Core Qt5::Gui Qt5::Widgets)
set(qtuser qtuser_core qtuser_3d qtuser_qml)

macro(__qt5_translate RES DIR)
	file(GLOB TS_FILES ${DIR}/*.ts)
	qt5_add_translation(QM_FILES ${TS_FILES})
	
	configure_file(translations.qrc ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)
	qt5_add_resources(${RES} ${CMAKE_CURRENT_BINARY_DIR}/translations.qrc)
endmacro()

macro(__remap_qt_debug_2_release)
	set(REMAP_LIBS Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Network Qt5::Xml
		Qt5::Qml Qt5::Quick Qt5::3DCore Qt5::3DRender Qt5::3DCore Qt5::3DExtras
		Qt5::OpenGL Qt5::3DInput Qt5::3DLogic Qt5::3DQuick Qt5::Concurrent Qt5::Gamepad)
	
	__remap_target_debug_2_release(REMAP_LIBS)
endmacro()

