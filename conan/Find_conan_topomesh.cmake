# topomesh target
__cc_find(trimesh2)
__cc_find(eigen)
__cc_find(clipper)

__conan_import(topomesh dll INTERFACE_DEF USE_TOPOMESH)