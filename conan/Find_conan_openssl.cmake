option(OPENSSL_STATIC "use openssl static" ON)
if(CONAN_OPENSSL_ROOT_RELEASE)
	set(OPENSSL_INCLUDE_DIR ${CONAN_OPENSSL_ROOT_RELEASE}/include/)
endif()
if(OPENSSL_STATIC)
__conan_import(openssl lib COMPONENT ssl crypto)
else()
__conan_import(openssl dll COMPONENT ssl crypto)
endif()
