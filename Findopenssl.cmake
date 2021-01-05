find_path(openssl_INCLUDE_DIR openssl/aes.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/openssl/"
	PATHS "/usr/local/include/openssl/")
	
if(openssl_INCLUDE_DIR)
	set(openssl_INCLUDE_DIRS ${openssl_INCLUDE_DIR})
endif()

find_library(ssl_LIBRARIES_DEBUG
             NAMES libssl
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/debug"
			 PATHS "/usr/local/lib/Debug")
			 
find_library(ssl_LIBRARIES_RELEASE
             NAMES libssl
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/release"
			 PATHS "/usr/local/lib/Release")
		
find_library(crypto_LIBRARIES_DEBUG
             NAMES libcrypto
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/debug"
			 PATHS "/usr/local/lib/Debug")
			 
find_library(crypto_LIBRARIES_RELEASE
             NAMES libcrypto
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/release"
			 PATHS "/usr/local/lib/Release")
	
message(STATUS ${openssl_INCLUDE_DIRS})
message(STATUS ${ssl_LIBRARIES_DEBUG})
message(STATUS ${ssl_LIBRARIES_RELEASE})
message(STATUS ${crypto_LIBRARIES_DEBUG})
message(STATUS ${crypto_LIBRARIES_RELEASE})
	
if(openssl_INCLUDE_DIRS AND ssl_LIBRARIES_DEBUG AND ssl_LIBRARIES_RELEASE
					AND crypto_LIBRARIES_DEBUG AND crypto_LIBRARIES_RELEASE)
	set(openssl_FOUND "True")
	set(ssl_INCLUDE_DIRS ${openssl_INCLUDE_DIR})
	set(crypto_INCLUDE_DIRS ${openssl_INCLUDE_DIR})
	
	if( WIN32 AND NOT CYGWIN )
		set(crypto_LIBRARIES_DEBUG ${crypto_LIBRARIES_DEBUG} ws2_32 crypt32)
		set(crypto_LIBRARIES_RELEASE ${crypto_LIBRARIES_RELEASE} ws2_32 crypt32)
	endif()

	__import_target(ssl lib)
	__import_target(crypto lib)
	set(openssl ssl crypto)
endif()