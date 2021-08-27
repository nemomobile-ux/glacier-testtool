import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtSensors 5.15

Page {
        id: page

        property int passedNumber: (testPortrait.passed ? 1 : 0) + (testLandscape.passed ? 1 : 0)

        signal passedTests(int num);
        onPassedNumberChanged: {
            passedTests(passedNumber)
        }


        headerTools: HeaderToolsLayout {
            title: qsTr("Orientation")
            showBackButton: true
        }

        Column {
            width: parent.width;
            height: parent.height;

            Label {
                id: testLabel
                text: "orient = -"
                width: parent.width;
            }
            Label {
                text: "identifier: " + orient.identifier
            }
            Label {
                text: "type: " + orient.type
            }
            Label {
                text: "rate: " + orient.dataRate
            }


            ListViewItemWithActions {
                id: testPortrait
                property bool passed: false;
                label: qsTr("Portrait")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }

            ListViewItemWithActions {
                id: testLandscape
                property bool passed: false;
                label: qsTr("Landscape")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }


        }


    OrientationSensor {
        id: orient
        active: true
        alwaysOn: true
        onReadingChanged: {
            testLabel.text = "orient = " + reading.orientation
            if (reading.orientation === 1) {
                testPortrait.passed = true
            }
            if (reading.orientation === 4) {
                testLandscape.passed = true
            }
        }
    }

    Component.onCompleted: {
        orient.start();
    }

}
