import QtQuick
import Nemo.Controls
import QtSensors
import QtCharts

Page {
    id: page

    property int passedNumber: (testX.passed ? 1 : 0) + (testY.passed ? 1 : 0) + (testZ.passed ? 1 : 0) + (calmStateTest.passed ? 1 : 0) + (twoGTest.passed ? 1 : 0)

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Accelerometers")
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
                id: vectorLabel
                text: qsTr("vector = %1 m/s²").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                id: movementLabel
                text: qsTr("movement = %2 m/s²").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("identifier: %1").arg(accel.identifier)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("type: %1").arg(accel.type)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("rate: %1").arg(accel.dataRate)
                width: parent.width;
                wrapMode: Text.Wrap
            }


            ChartView {
                title: qsTr("Accelerometers")
                width: parent.width
                height: page.height/2
                antialiasing: true

                LineSeries {
                    id: xSeries
                    name: "X"

                    axisX: ValueAxis {
                        id: xAxisSettings
                        min: 0
                        max: 100
                    }

                    axisY: ValueAxis {
                        min: -20
                        max: 20
                    }

                }


                LineSeries {
                    id: ySeries
                    name: "Y"
                }


                LineSeries {
                    id: zSeries
                    name: "Z"

                }

            }

            ListViewItemWithActions {
                id: testX
                property bool passed: false;
                label: qsTr("X axis > 9 m/s²")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }

            ListViewItemWithActions {
                id: testY
                property bool passed: false;
                label: qsTr("Y axis > 9 m/s²")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }

            ListViewItemWithActions {
                id: testZ
                property bool passed: false;
                label: qsTr("Z axis > 9 m/s²")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }

            ListViewItemWithActions {
                id: calmStateTest
                property bool passed: false;
                label: qsTr("Lying on the table")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }

            ListViewItemWithActions {
                id: twoGTest
                property bool passed: false;
                label: qsTr("More than > 20  m/s² (2G)")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }


        }


    }

    ScrollDecorator {
        flickable: mainFlickable
    }

    property int chartXVal: 0;

    Accelerometer {
        id: accel
        active: true
        alwaysOn: true
        dataRate: 10
        onReadingChanged: {
            testLabel.text = qsTr("x = %1; y = %2; z = %3").arg(Number(reading.x).toFixed(2)).arg(Number(reading.y).toFixed(2)).arg(Number(reading.z).toFixed(2))
            var size = Math.sqrt(reading.x*reading.x + reading.y*reading.y + reading.z*reading.z)
            var size_minus_gravity = size - 9.81;
            vectorLabel.text = qsTr("vector = %1 m/s²").arg(Number(size).toFixed(2))
            movementLabel.text = qsTr("movement = %2 m/s²").arg(Number(size_minus_gravity).toFixed(2))
            if (xSeries.count > 100) {
                xSeries.remove(0);
                ySeries.remove(0);
                zSeries.remove(0);
            }
            xSeries.append(chartXVal, reading.x)
            ySeries.append(chartXVal, reading.y)
            zSeries.append(chartXVal, reading.z)
            chartXVal = (chartXVal + 1);
            xAxisSettings.max = chartXVal
            xAxisSettings.min = chartXVal - 100

            if (Math.abs(reading.x) > 9.0) {
                testX.passed = true;
            }

            if (Math.abs(reading.y) > 9.0) {
                testY.passed = true;
            }

            if (Math.abs(reading.z) > 9.0) {
                testZ.passed = true;
            }

            if (size_minus_gravity < 1.0) {
                calmStateTest.passed = true;
            }

            if (size > 20.0) {
                twoGTest.passed = true;
            }
        }
    }

    Component.onCompleted: {
        accel.start();
    }

}
