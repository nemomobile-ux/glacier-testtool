set(SRC
    main.cpp
)

qtquick_compiler_add_resources(RESOURCES qml/glacier-testtool.qrc)

add_executable(glacier-testtool ${SRC} ${RESOURCES})

target_link_libraries(glacier-testtool
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::Sensors
	Qt5::Charts
	Glacier::App)

install(TARGETS glacier-testtool RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
