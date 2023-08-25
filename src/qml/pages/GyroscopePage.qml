import QtQuick
import Nemo.Controls
import QtSensors
import QtCharts

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
                wrapMode: Text.Wrap
            }


            Label {
                text: qsTr("Identifier: %1").arg(gyro.identifier)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Type: %1").arg(gyro.type)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Description: %1").arg(gyro.description)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Buffer size: %1").arg(gyro.bufferSize)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Efficient buffer size : %1").arg(gyro.efficientBufferSize )
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Connected: %1").arg(gyro.connectedToBackend)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Skip duplicates: %1").arg(gyro.skipDuplicates )
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Error: %1").arg(gyro.error)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Active: %1").arg(gyro.active)
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Label {
                text: qsTr("Rate: %1").arg(gyro.dataRate)
                width: parent.width;
                wrapMode: Text.Wrap
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
