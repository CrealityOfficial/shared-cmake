# This sets the following variables:
# QtAdvancedDocking target

__search_target_components(qtadvanceddocking
						   INC DockManager.h
						   DLIB qtadvanceddocking
						   LIB qtadvanceddocking
						   PRE advancedDocking
						   )

__test_import(qtadvanceddocking dll)