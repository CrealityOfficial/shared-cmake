set(PROTOBUF_COMPONETS libprotobuf
					   libprotobuf-lite
					   libprotoc
					   )

__conan_import(protobuf lib COMPONENT ${PROTOBUF_COMPONETS})
set(protobuf ${PROTOBUF_COMPONETS})