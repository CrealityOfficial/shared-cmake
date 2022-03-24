SET(CPACK_GENERATOR "DragNDrop")
set(CPACK_SYSTEM_NAME "macx")
#set(prefix "${PROJECT_NAME}.app/Contents")
#set(INSTALL_RUNTIME_DIR "${prefix}/MacOS")
#set(INSTALL_CMAKE_DIR "${prefix}/Resources")
#set(INSTALL_PLUGIN_DIR "${prefix}/PlugIns")
#set(INSTALL_LIB_DIR "${prefix}/Frameworks")
#macro(install_qt5_plugin _qt_plugin_name _qt_plugins_var _prefix)
#    get_target_property(_qt_plugin_path "${_qt_plugin_name}" LOCATION)
#    if(EXISTS "${_qt_plugin_path}")
#get_filename_component(_qt_plugin_file "${_qt_plugin_path}" NAME)
#get_filename_component(_qt_plugin_type "${_qt_plugin_path}" PATH)
#get_filename_component(_qt_plugin_type "${_qt_plugin_type}" NAME)
#set(_qt_plugin_dest "${_prefix}/PlugIns/${_qt_plugin_type}")
#install(FILES "${_qt_plugin_path}"
#    DESTINATION "${_qt_plugin_dest}")
#set(${_qt_plugins_var}
#    "${${_qt_plugins_var}};\$ENV{DEST_DIR}\${CMAKE_INSTALL_PREFIX}/${_qt_plugin_dest}/${_qt_plugin_file}")
#    else()
#message(FATAL_ERROR "QT plugin ${_qt_plugin_name} not found")
#    endif()
#endmacro()
#
#set(LIB_PUGINS)
#install_qt5_plugin("Qt5::QCocoaIntegrationPlugin" LIB_PUGINS ${prefix})
#
#
#
#file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/qt.conf"
#    "[Paths]\nPlugins = ${_qt_plugin_dir}\n")
#install(FILES "${CMAKE_CURRENT_BINARY_DIR}/qt.conf"
#    DESTINATION "${INSTALL_CMAKE_DIR}")
#
#INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}/Release/CrealityDlpUI" DESTINATION ${INSTALL_CMAKE_DIR}/qml)
## Destination paths below are relative to ${CMAKE_INSTALL_PREFIX}
#INSTALL(TARGETS ${INSTALL_LIBS}
#    BUNDLE DESTINATION . COMPONENT Runtime
#    RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR}
#    FRAMEWORK DESTINATION ${INSTALL_LIB_DIR}
#    ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
#      LIBRARY DESTINATION ${INSTALL_LIB_DIR}
#    )
#INSTALL(TARGETS CrealityDlpUI
#    BUNDLE DESTINATION . COMPONENT Runtime
#    RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR}
#    FRAMEWORK DESTINATION ${INSTALL_CMAKE_DIR}/qml/CrealityDlpUI
#    ARCHIVE DESTINATION ${INSTALL_CMAKE_DIR}/qml/CrealityDlpUI
#      LIBRARY DESTINATION ${INSTALL_CMAKE_DIR}/qml/CrealityDlpUI
#    )
#
#
#set(APPS "\$ENV{DESTDIR}\${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app")
#
## Directories to look for dependencies
#set(DIRS "${CMAKE_BINARY_DIR}")
#
## Path used for searching by FIND_XXX(), with appropriate suffixes added
#if(CMAKE_PREFIX_PATH)
#    foreach(dir ${CMAKE_PREFIX_PATH})
#list(APPEND DIRS "${dir}/bin" "${dir}/lib")
#    endforeach()
#endif()
#
## Append Qt's lib folder which is two levels above Qt5Widgets_DIR
#list(APPEND DIRS "${Qt5Widgets_DIR}/../..")
#list(APPEND DIRS "${LIB_OUTPUT_DIR}/Release")
#include(InstallRequiredSystemLibraries)
#
#message(STATUS "APPS: ${APPS}")
#message(STATUS "QT_PLUGINS: ${LIB_PUGINS}")
#message(STATUS "DIRS: ${DIRS}")
#
#set(OSX_CODESIGN_IDENTITY "Developer ID Application" CACHE STRING "Identity to use for code signing")
#
#INSTALL(FILES  /usr/local/opt/libomp/lib/libomp.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicutu.68.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicuuc.68.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicudata.68.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicui18n.68.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicutu.68.2.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicuuc.68.2.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicudata.68.2.dylib DESTINATION "${prefix}/Frameworks/")
#INSTALL(FILES  /usr/local/opt/icu4c/lib/libicui18n.68.2.dylib DESTINATION "${prefix}/Frameworks/")
#
#INSTALL(DIRECTORY  "${CMAKE_SOURCE_DIR}/resources/fonts" DESTINATION "${INSTALL_CMAKE_DIR}/resources/")
#INSTALL(DIRECTORY  "${CMAKE_SOURCE_DIR}/resources/manual" DESTINATION "${INSTALL_CMAKE_DIR}/resources/")
#INSTALL(DIRECTORY  "${CMAKE_SOURCE_DIR}/resources/mesh" DESTINATION "${INSTALL_CMAKE_DIR}/resources/")
#        
#install(CODE "execute_process(COMMAND rm -R \"\${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/MacOS/resources\")")
#install(CODE "execute_process(COMMAND rm -R \"\${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/MacOS/HalotBox.app\")")
# 
#install(CODE "execute_process(COMMAND codesign --force --options=runtime -s \"${OSX_CODESIGN_IDENTITY}\"  \"\${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app/Contents/Resources/qml/CrealityDlpUI/libCrealityDlpUI.dylib\")")
#install(CODE "execute_process(COMMAND codesign --force --options=runtime -s \"${OSX_CODESIGN_IDENTITY}\" --deep \"\${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}.app\")")
#install(CODE "execute_process(COMMAND bash  ${CMAKE_CURRENT_SOURCE_DIR}/package/macx/Notarized-script.sh \${CMAKE_INSTALL_PREFIX} ${PROJECT_NAME} $ENV{MACPASS})")
#set(CPACK_GENERATOR "DragNDrop")
#set(CPACK_PACKAGE_FILE_NAME "${BUNDLE_NAME}-${PROJECT_VERSION}")
#set(CPACK_DMG_VOLUME_NAME "HALOT BOX App")
#set(CPACK_DMG_BACKGROUND_IMAGE "${CMAKE_CURRENT_SOURCE_DIR}/package/macx/CMakeDMGBackground.tif")
#set(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/package/macx/VolumeIcon.icns")
#set(CPACK_DMG_DS_STORE_SETUP_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/package/macx/CMakeDMGSetup.scpt")
