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
        title: qsTr("Compass")
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
                id: azimuthLabel
                text: qsTr("azimuth = %1").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Image {
                id: roseImage
                width: 300
                fillMode: Image.PreserveAspectFit
                source: "../images/compass-rose.png"

            }

            Label {
                id: calibrationLevelLabel
                text: qsTr("Calibration level = %1").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
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

    Compass {
        id: compass
        active: true
        alwaysOn: true
        dataRate: 10


        onReadingChanged: {
            azimuthLabel.text = qsTr("Azimuth = %1").arg(reading.azimuth)
            roseImage.rotation = -reading.azimuth
            calibrationLevelLabel.text = qsTr("Calibration level = %1").arg(reading.calibrationLevel)
        }
    }


    Component.onCompleted: {
        compass.start();
    }

}
