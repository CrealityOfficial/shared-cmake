macro(__build_qml_plugin target)
	if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/qmldir)
		message(FATAL_ERROR "${CMAKE_CURRENT_SOURCE_DIR}/qmldir must exist in a qml plugin")
	endif()
	
	set(targetName ${CMAKE_SHARED_LIBRARY_PREFIX}${target}${CMAKE_SHARED_LIBRARY_SUFFIX})
	add_custom_command(TARGET ${target} POST_BUILD
			COMMAND ${CMAKE_COMMAND} -E make_directory "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${target}"
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/qmldir "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${target}"
			COMMAND ${CMAKE_COMMAND} -E copy "$<TARGET_FILE_DIR:${target}>/${targetName}" "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>/${target}"
			)
		
	if(WIN32)
		if(CMAKE_BUILD_TYPE MATCHES "Release")
			set(COPY_DIST_QML_DIR "${Qt5Core_DIR}/../../../qml/${target}")
			add_custom_command(TARGET ${target} POST_BUILD
					COMMAND ${CMAKE_COMMAND} -E copy "$<TARGET_FILE_DIR:${target}>/${targetName}" "${COPY_DIST_QML_DIR}/${targetName}"
					COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/qmldir" "${COPY_DIST_QML_DIR}/qmldir"
					)
		endif()
        endif()
        if(APPLE)
            if(CMAKE_BUILD_TYPE MATCHES "Debug")
                set(COPY_DIST_QML_DIR "${Qt5Core_DIR}/../../../qml/${target}")
                add_custom_command(TARGET ${target} POST_BUILD
                            COMMAND ${CMAKE_COMMAND} -E copy "$<TARGET_FILE_DIR:${target}>/${targetName}" "${COPY_DIST_QML_DIR}/${targetName}"
                            COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/qmldir" "${COPY_DIST_QML_DIR}/qmldir"
                            )
            else()
                add_custom_command(TARGET ${target} POST_BUILD
                                    COMMAND ${CMAKE_COMMAND} -E copy  #copy CrealityUI.dll
                                    "$<TARGET_FILE_DIR:${target}>/${targetName}"
                                    "$<TARGET_FILE_DIR:${target}>/${target}/${targetName}"
                                    COMMAND ${CMAKE_COMMAND} -E copy  #copy qmldir
                                    "${CMAKE_CURRENT_SOURCE_DIR}/qmldir"
                                    "$<TARGET_FILE_DIR:${target}>/${target}/qmldir"
                                    )
        endif()
        endif()
endmacro()
