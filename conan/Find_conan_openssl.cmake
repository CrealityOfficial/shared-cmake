if(CONAN_OPENSSL_ROOT_RELEASE)
	set(OPENSSL_INCLUDE_DIR ${CONAN_OPENSSL_ROOT_RELEASE}/include/)
endif()

__conan_import(openssl lib COMPONENT ssl crypto)
