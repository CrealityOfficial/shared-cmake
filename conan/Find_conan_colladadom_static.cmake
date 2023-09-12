# colladadom_static target
__cc_find(pcre)
__cc_find(zip_static)
__cc_find(minizip_static)
__cc_find(libxml_static)

__conan_import(colladadom_static lib COMPONENT colladadom141 colladadom_static 
									 ILIB libxml_static minizip_static zip_static colladadom141
										pcre_local pcrecpp_local pcreposix_local
									 )

