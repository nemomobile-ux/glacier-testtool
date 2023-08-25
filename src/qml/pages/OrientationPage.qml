import QtQuick
import Nemo.Controls
import QtSensors

Page {
    id: page

    property int passedNumber: 0

    signal passedTests(int num);
    property int lastOrientation: OrientationReading.Undefined
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Orientation")
        showBackButton: true
    }

    Flickable {
        id: flickable
        anchors.fill: parent;
        anchors.margins: Theme.itemSpacingMedium
        contentHeight: column.height

        Column {
            id: column
            width: parent.width;
            spacing: Theme.itemSpacingSmall

            Label {
                id: testLabel
                text: qsTr("Orientation: ") + orientation_to_string(lastOrientation)
                width: parent.width;
                wrapMode: Text.Wrap

            }
            Label {
                text: qsTr("Identifier: %1").arg(orient.identifier)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Type: %1").arg(orient.type)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Rate: %1").arg(orient.dataRate)
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Repeater {
                model: test_orientations
                ListViewItemWithActions {
                    width: parent.width;
                    label: orientation_to_string(orientation)
                    icon: (passed) ? "image://theme/check" : "image://theme/times";
                    showNext: false
                }
            }

        }
    }
    ScrollDecorator {
        flickable: flickable;
    }

    ListModel {
        id: test_orientations
        ListElement { orientation: OrientationReading.TopUp;    passed: false; }
        ListElement { orientation: OrientationReading.TopDown;  passed: false; }
        ListElement { orientation: OrientationReading.LeftUp;   passed: false; }
        ListElement { orientation: OrientationReading.RightUp;  passed: false; }
        ListElement { orientation: OrientationReading.FaceUp;   passed: false; }
        ListElement { orientation: OrientationReading.FaceDown; passed: false; }
    }

    OrientationSensor {
        id: orient
        active: true
        alwaysOn: true
        onReadingChanged: {
            lastOrientation = reading.orientation;
            updateTestValues(reading.orientation)
        }
    }

    function updateTestValues(reading) {
        console.log("reading " + reading)
        var passedCount = 0;
        for (var i = 0; i < test_orientations.count; i++) {
            var item = test_orientations.get(i)
            if (item.orientation === reading) {
                test_orientations.setProperty(i, "passed", true)
            }
            if (item.passed) {
                passedCount++;
            }
        }
        if (passedCount !== passedNumber) {
            passedNumber = passedCount;
            passedTests(passedNumber)
        }
    }

    function orientation_to_string(o) {
        switch(o) {
        case OrientationReading.Undefined: return qsTr("Undefined");
        case OrientationReading.TopUp:     return qsTr("Top Up");
        case OrientationReading.TopDown:   return qsTr("Top Down");
        case OrientationReading.LeftUp:    return qsTr("Left Up");
        case OrientationReading.RightUp:   return qsTr("Right Up");
        case OrientationReading.FaceUp:    return qsTr("Face Up");
        case OrientationReading.FaceDown:  return qsTr("Face Down");
        default: return qsTr("Unknown");
        }
    }

    Component.onCompleted: {
        orient.start();
    }

}
