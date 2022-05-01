import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtSensors 5.15
import QtCharts 2.15

Page {
    id: page

//    property int passedNumber: (testX.passed ? 1 : 0) + (testY.passed ? 1 : 0) + (testZ.passed ? 1 : 0) + (calmStateTest.passed ? 1 : 0) + (twoGTest.passed ? 1 : 0)
    property int passedNumber: 0

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Magnetometers")
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
                id: testLabel
                text: qsTr("x = %1; y = %2; z = %3").arg("-").arg("-").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("identifier: %1").arg(magnet.identifier)
                width: parent.width;
                wrapMode: Text.Wrap

            }
            Label {
                text: qsTr("type: %1").arg(magnet.type)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("description: %1").arg(magnet.description)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("bufferSize: %1").arg(magnet.bufferSize)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("efficientBufferSize : %1").arg(magnet.efficientBufferSize )
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("connected: %1").arg(magnet.connectedToBackend)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("skipDuplicates: %1").arg(magnet.skipDuplicates )
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("error: %1").arg(magnet.error)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("active: %1").arg(magnet.active)
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Label {
                text: qsTr("rate: %1").arg(magnet.dataRate)
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Label {
                text: qsTr("return geo values: %1").arg(magnet.returnGeoValues)
                width: parent.width;
                wrapMode: Text.Wrap
            }


        }


    }

    ScrollDecorator {
        flickable: mainFlickable
    }

    property int chartXVal: 0;

    Magnetometer {
        id: magnet
        active: true
        alwaysOn: true
        dataRate: 100
        skipDuplicates: false
        bufferSize: 100
        onReadingChanged: {
        console.log(reading.x);
            testLabel.text = qsTr("x = %1; y = %2; z = %3; c = %4").arg(Number(reading.x).toFixed(2)).arg(Number(reading.y).toFixed(2)).arg(Number(reading.z).toFixed(2)).arg(Number(reading.calibrationLevel).toFixed(2))
        }
    }

    Component.onCompleted: {
        magnet.start();
    }

}
