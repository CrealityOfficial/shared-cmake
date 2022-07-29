if(CONAN_OPENSSL_ROOT_RELEASE)
	set(OPENSSL_INCLUDE_DIR ${CONAN_OPENSSL_ROOT_RELEASE}/include/openssl/openssl/ ${CONAN_OPENSSL_ROOT_RELEASE}/include/openssl/crypto/ ${CONAN_OPENSSL_ROOT_RELEASE}/include/openssl/internal/)
endif()

__conan_import(openssl dll COMPONENT ssl crypto)
