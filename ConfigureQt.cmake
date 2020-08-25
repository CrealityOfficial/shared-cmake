macro(__enable_qt5)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS core widgets gui quick qml 3dcore 3drender 3dextras 3dinput 3dlogic 3dquick concurrent svg REQUIRED)
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