cmake_minimum_required(VERSION 3.6.0)

project(glacier-testtool
	VERSION 0.1.2
	DESCRIPTION "The hardware test wrapped into glacier ui")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_INSTALL_PREFIX /usr)

include(FeatureSummary)
include(GNUInstallDirs)

set(QT_MIN_VERSION "5.6.0")
find_package(Qt5 COMPONENTS Gui Qml Quick Sensors Charts LinguistTools REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

# Translations
file(GLOB TS_FILES translations/*.ts)
qt5_add_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(glacier-testtool translations)

install(FILES ${QM_FILES}
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-testtool/translations)

install(FILES glacier-testtool.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)
install(DIRECTORY icons
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-testtool)
