macro(__build_qml_plugin target)
	if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/qmldir)
		message(FATAL_ERROR "${CMAKE_CURRENT_SOURCE_DIR}/qmldir must exist in a qml plugin")
	endif()
	set_target_properties(${target} PROPERTIES QML_PLUGIN_DIR_NAME ${CMAKE_CURRENT_SOURCE_DIR}/qmldir)
	
	if(CC_BC_WIN)
		set(targetName ${CMAKE_SHARED_LIBRARY_PREFIX}${plugin}${CMAKE_SHARED_LIBRARY_SUFFIX})
		get_target_property(DIR_NAME ${plugin} QML_PLUGIN_DIR_NAME)
		add_custom_command(TARGET ${target} POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E make_directory "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${plugin}/"
				COMMAND ${CMAKE_COMMAND} -E copy ${DIR_NAME} "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${plugin}"
				COMMAND ${CMAKE_COMMAND} -E copy "$<TARGET_FILE_DIR:${plugin}>/${targetName}" "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${plugin}"
				)
	endif()
endmacro()