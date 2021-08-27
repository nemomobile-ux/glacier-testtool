set(SRC
    main.cpp
)

add_executable(glacier-testtool ${SRC})

target_link_libraries(glacier-testtool
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Qt5::Sensors
	Qt5::Charts
	Glacier::App)

install(TARGETS glacier-testtool RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-testtool)
