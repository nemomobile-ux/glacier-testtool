import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtSensors 5.15
import QtCharts 2.15

Page {
    id: page

    property int passedNumber:0;// (testX.passed ? 1 : 0) + (testY.passed ? 1 : 0) + (testZ.passed ? 1 : 0) + (calmStateTest.passed ? 1 : 0) + (twoGTest.passed ? 1 : 0)

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Gyroscope")
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
            }


            Label {
                text: qsTr("identifier: %1").arg(gyro.identifier)
            }
            Label {
                text: qsTr("type: %1").arg(gyro.type)
            }
            Label {
                text: qsTr("description: %1").arg(gyro.description)
            }
            Label {
                text: qsTr("bufferSize: %1").arg(gyro.bufferSize)
            }
            Label {
                text: qsTr("efficientBufferSize : %1").arg(gyro.efficientBufferSize )
            }
            Label {
                text: qsTr("connected: %1").arg(gyro.connectedToBackend)
            }
            Label {
                text: qsTr("skipDuplicates: %1").arg(gyro.skipDuplicates )
            }
            Label {
                text: qsTr("error: %1").arg(gyro.error)
            }
            Label {
                text: qsTr("active: %1").arg(gyro.active)
            }

            Label {
                text: qsTr("rate: %1").arg(gyro.dataRate)
            }



        }


    }

    ScrollDecorator {
        flickable: mainFlickable
    }

    property int chartXVal: 0;

    Gyroscope {
        id: gyro
        active: true
        alwaysOn: true
        dataRate: 10
        onReadingChanged: {
            testLabel.text = qsTr("x = %1; y = %2; z = %3").arg(Number(reading.x).toFixed(2)).arg(Number(reading.y).toFixed(2)).arg(Number(reading.z).toFixed(2))
        }
    }

    Component.onCompleted: {
        gyro.start();
    }

}
