import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtSensors 5.15

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
                    label: orientation_to_string(value)
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
        ListElement { value: OrientationReading.TopUp; passed: false; }
        ListElement { value: OrientationReading.TopDown; passed: false; }
        ListElement { value: OrientationReading.LeftUp; passed: false; }
        ListElement { value: OrientationReading.RightUp; passed: false; }
        ListElement { value: OrientationReading.FaceUp; passed: false; }
        ListElement { value: OrientationReading.FaceDown; passed: false; }
    }

    function updateTestValues(current) {
        passedCount = 0;
        for (var i = 0; i < test_orientations.count; i++) {
            var o = test_orientations.get(i)
            if (o.value === current) {
                test_orientations.setProperty(i, "passed", true)
            }
            if (o.passed) {
                passedCount++;
            }
        }
        if (passedCount !== passedNumber) {
            passedNumber = passedCount;
            passedTests(passedNumber)
        }
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
