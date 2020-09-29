SET(CMAKE_PREFIX_PATH $ENV{QT5_DIR})

macro(__enable_qt5)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Core Widgets Gui Quick Qml Xml 3DCore 3DRender 3DExtras 3DInput 3DLogic 3DQuick Concurrent REQUIRED)
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

set(QtQmlQ3dLibs Qt5::Widgets Qt5::Quick Qt5::Qml Qt5::3DExtras)
set(QtQmlLibs Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Qml)

