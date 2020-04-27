macro(__enable_qt5)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS core widgets gui quick qml 3dcore 3drender  3dextras 3dinput 3dlogic 3dquick concurrent REQUIRED)
endmacro()