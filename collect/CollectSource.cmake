

macro(__collect_source_tree_from_directory DIR SOURCE_VAR)
	file(GLOB_RECURSE ${SOURCE_VAR} RELATIVE ${DIR} "*.cpp" "*.h" "*.c" "*.cc" "*.hpp" "*.CPP" "*.hxx" "*.cxx")
endmacro()