
# Find rapidjson
#
# This sets the following variables:
# rapidjson_INCLUDE_DIRS
# rapidjson_FOUND

find_path(rapidjson_INCLUDE_DIR rapidjson/rapidjson.h
    HINTS "$ENV{CXSDK_ROOT}/include")
	
if(rapidjson_INCLUDE_DIR)
	set(rapidjson_INCLUDE_DIRS ${rapidjson_INCLUDE_DIR})
	set(rapidjson_FOUND "True")
endif()