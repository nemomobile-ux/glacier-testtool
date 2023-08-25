set(SRC
    main.cpp
)

qt_add_resources(RESOURCES qml/glacier-testtool.qrc)

add_executable(glacier-testtool ${SRC} ${RESOURCES})

target_link_libraries(glacier-testtool
	Qt6::Gui
	Qt6::Qml
	Qt6::Quick
	Qt6::Sensors
	Qt6::Charts
	Glacier::App)

install(TARGETS glacier-testtool RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
