import QtQuick
import QtQuick.Window
import Nemo.Controls

import "pages"

ApplicationWindow {
    id: main
    initialPage: AccelerometerPage{}

    ListModel {
        id: testList
        ListElement {
            name: qsTr("Accelerometers")
            total: 5;
            pageUrl: "pages/AccelerometerPage.qml"
        }
        ListElement {
            name: qsTr("Gyroscope")
            total: 1;
            pageUrl: "pages/GyroscopePage.qml"
        }
        ListElement {
            name: qsTr("Orientation sensor")
            total: 6;
            pageUrl: "pages/OrientationPage.qml"
        }
        ListElement {
            name: qsTr("Compass")
            total: 1;
            pageUrl: "pages/CompassPage.qml"
        }
        ListElement {
            name: qsTr("Magnetometer")
            total: 1;
            pageUrl: "pages/MagnetometerPage.qml"
        }
        ListElement {
            name: qsTr("Ambient Light")
            total: 1;
            pageUrl: "pages/LightPage.qml"
        }
        ListElement {
            name: qsTr("Proximity")
            total: 2;
            pageUrl: "pages/ProximityPage.qml"
        }
        ListElement {
            name: qsTr("Audio")
            total: 1;
            pageUrl: "pages/AudioPage.qml"
        }
        ListElement {
            name: qsTr("Haptics")
            total: 1;
            pageUrl: "pages/HapticsPage.qml"
        }
        ListElement {
            name: qsTr("Non graphical feedback")
            total: 1;
            pageUrl: "pages/NgfPage.qml"
        }
        ListElement {
            name: qsTr("Touch test")
            total: 1;
            pageUrl: "pages/TouchPage.qml"
        }
    }

    mainMenu:     ListView {
        model: testList;
        width: parent.width;
        height: parent.height;

        delegate: ListViewItemWithActions {
            property int passed: -1;
            icon: (passed === total) ? "image://theme/check" :
                                       (passed == -1) ? "image://theme/minus" : "image://theme/times";
            width: parent.width;
            label: name
            description: qsTr("passed %1 of %2").arg( (passed < 0) ? 0 : passed ).arg(total)
            onClicked: {
                var itemPage = main.pageStack.push(Qt.resolvedUrl(pageUrl))
                itemPage.passedTests.connect(function(num) {
                    passed = num
                })
            }
        }
    }
}
