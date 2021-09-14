# This sets the following variables:
# MYSQL_INCLUDE_DIRS
# MYSQL_INCLUDE_FOUND

if(MYSQL_INSTALL_ROOT)
	message(STATUS "Mysql Specified MYSQL_INSTALL_ROOT : ${MYSQL_INSTALL_ROOT}")
	set(MYSQL_INCLUDE_DIRS ${MYSQL_INSTALL_ROOT}/include/)
	
	set(mysqlclient_INCLUDE_ROOT ${MYSQL_INSTALL_ROOT}/include/)
	set(mysqlclient_LIB_ROOT ${MYSQL_INSTALL_ROOT}/lib/)
				   
else()
	find_path(MYSQL_INCLUDE_DIRS
			NAMES mysql.h
			HINTS "${MYSQL_INSTALL_ROOT}"
			PATHS "/usr/include/" "/usr/include/mysql/mysql.h"
					"/usr/local/include/" "/usr/local/include/mysql/mysql.h"
					"$ENV{MYSQL_INSTALL_ROOT}/include/" "$ENV{MYSQL_INSTALL_ROOT}/include/mysql"
			NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			)
endif()
	
__search_target_components_signle(mysqlclient
						   INC mysql.h
						   DLIB mysqlclient
						   LIB mysqlclient
						   )
						   

__test_import(mysqlclient dll)


if(MYSQL_INCLUDE_DIRS)
	set(MYSQL_INCLUDE_FOUND 1)
	set(Mysql_INCLUDE_DIRS ${MYSQL_INCLUDE_DIRS})
	message(STATUS "MYSQL_INCLUDE_DIRS : ${MYSQL_INCLUDE_DIRS}")
else()
	message(STATUS "Find Mysql include Failed maybe not set MYSQL_INSTALL_ROOT")
endif()