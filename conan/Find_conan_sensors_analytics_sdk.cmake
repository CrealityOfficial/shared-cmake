#sensors_analytics_sdk target
if(CC_BC_MAC)
__conan_import(sensors_analytics_sdk lib)
else()
__conan_import(sensors_analytics_sdk dll)
endif()