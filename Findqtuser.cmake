# Find qtuser
#
# This sets the following variables:
# qtuser_INCLUDE_DIRS
# qtuser_LIBRARIES
# qtuser_FOUND
# qtuser_targets

find_path(qtuser_INCLUDE_DIR qtusercore/module/job.h
    HINTS "$ENV{CX_CORELIB_ROOT}/include")
	
if(qtuser_INCLUDE_DIR)
	set(qtuser_INCLUDE_DIRS ${qtuser_INCLUDE_DIR})
endif()

find_library(qtuser_core_LIBRARIES_DEBUG
             NAMES qtuser_core
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/debug")

find_library(qtuser_3d_LIBRARIES_DEBUG
             NAMES qtuser_3d
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/debug")

find_library(qtuser_qml_LIBRARIES_DEBUG
             NAMES qtuser_qml
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/debug")
			 
find_library(qtuser_core_LIBRARIES_RELEASE
             NAMES qtuser_core
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/release")

find_library(qtuser_3d_LIBRARIES_RELEASE
             NAMES qtuser_3d
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/release")

find_library(qtuser_qml_LIBRARIES_RELEASE
             NAMES qtuser_qml
             HINTS "$ENV{CX_CORELIB_ROOT}/lib/release")
			 
if(qtuser_INCLUDE_DIRS AND qtuser_core_LIBRARIES_DEBUG AND qtuser_core_LIBRARIES_RELEASE
	AND qtuser_3d_LIBRARIES_DEBUG AND qtuser_3d_LIBRARIES_RELEASE
	AND qtuser_qml_LIBRARIES_DEBUG AND qtuser_qml_LIBRARIES_RELEASE)
	set(qtuser_FOUND "True")
	__import_target(qtuser)
	__import_target(qtuser_core)
	__import_target(qtuser_3d)
	__import_target(qtuser_qml)
	set(qtuser_targets qtuser qtuser_core qtuser_3d qtuser_qml)
endif()