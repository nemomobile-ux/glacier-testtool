import QtQuick
import Nemo.Controls
import QtSensors

Page {
    id: mainPage

    headerTools: HeaderToolsLayout {
        showBackButton: false;
        title: qsTr("Hardware tests")
    }

    ListModel {
        id: testList
        ListElement {
            name: qsTr("Accelerometers")
            total: 5;
            pageUrl: "AccelerometerPage.qml"
        }
        ListElement {
            name: qsTr("Gyroscope")
            total: 1;
            pageUrl: "GyroscopePage.qml"
        }
        ListElement {
            name: qsTr("Orientation sensor")
            total: 6;
            pageUrl: "OrientationPage.qml"
        }
        ListElement {
            name: qsTr("Compass")
            total: 1;
            pageUrl: "CompassPage.qml"
        }
        ListElement {
            name: qsTr("Magnetometer")
            total: 1;
            pageUrl: "MagnetometerPage.qml"
        }
        ListElement {
            name: qsTr("Ambient Light")
            total: 1;
            pageUrl: "LightPage.qml"
        }
        ListElement {
            name: qsTr("Proximity")
            total: 2;
            pageUrl: "ProximityPage.qml"
        }

        ListElement {
            name: qsTr("Audio")
            total: 1;
            pageUrl: "AudioPage.qml"
        }
        ListElement {
            name: qsTr("Haptics")
            total: 1;
            pageUrl: "HapticsPage.qml"
        }
        ListElement {
            name: qsTr("Non graphical feedback")
            total: 1;
            pageUrl: "NgfPage.qml"
        }
        ListElement {
            name: qsTr("Touch test")
            total: 1;
            pageUrl: "TouchPage.qml"
        }
    }

    ListView {
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

    ScrollDecorator {
        flickable: testList
    }


     Component.onCompleted: {
         var types = QmlSensors.sensorTypes();
         console.log(types.join(", "));
     }
}
