import QtQuick
import Nemo.Controls
import QtSensors
import QtCharts

Page {
    id: page

    property int passedNumber: 0

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Ambient Light")
        showBackButton: true
    }

    Flickable {
        id: mainFlickable
        width: parent.width;
        height: parent.height;
        anchors.margins: Theme.itemSpacingMedium
        contentHeight: flickableColumn.height
        Column {
            id: flickableColumn
            width: parent.width;
            spacing: Theme.itemSpacingSmall

            Label {
                text: qsTr("identifier: %1").arg(ambientLightSensor.identifier)
            }
            Label {
                text: qsTr("type: %1").arg(ambientLightSensor.type)
            }
            Label {
                text: qsTr("rate: %1").arg(ambientLightSensor.dataRate)
            }


            Label {
                id: ambientLightSensorLabel
                text: qsTr("lightLevel = %1").arg("-")
                width: parent.width;
            }


/*
            ListViewItemWithActions {
                id: twoGTest
                property bool passed: false;
                label: qsTr("More than > 20  m/s² (2G)")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }
*/

        }

    }

    ScrollDecorator {
        flickable: mainFlickable
    }

    AmbientLightSensor {

        id: ambientLightSensor;
        active: true
        alwaysOn: true
        dataRate: 10

        onReadingChanged: {
            ambientLightSensorLabel.text = qsTr("lightLevel = %1").arg(reading.lightLevel )
        }

    }


    Component.onCompleted: {
        ambientLightSensor.start();
    }

}
