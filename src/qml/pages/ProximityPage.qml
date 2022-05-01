import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtSensors 5.15
import QtCharts 2.15

Page {
    id: page

    property int passedNumber: (nearTest.passed ? 1 : 0) + (farTest.passed ? 1 : 0)

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Proximity")
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
                text: qsTr("Identifier: %1").arg(proximitySensor.identifier)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Type: %1").arg(proximitySensor.type)
                width: parent.width;
                wrapMode: Text.Wrap
            }
            Label {
                text: qsTr("Rate: %1").arg(proximitySensor.dataRate)
                width: parent.width;
                wrapMode: Text.Wrap
            }

            Label {
                id: proximityLabel
                text: qsTr("Proximity = %1").arg("-")
                width: parent.width;
                wrapMode: Text.Wrap
            }


            ListViewItemWithActions {
                id: nearTest
                property bool passed: false;
                label: qsTr("Near")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }


            ListViewItemWithActions {
                id: farTest
                property bool passed: false;
                label: qsTr("Far")
                icon: (passed) ? "image://theme/check" : "image://theme/times";
                showNext: false
            }


        }


    }

    ScrollDecorator {
        flickable: mainFlickable
    }

    ProximitySensor {
        id: proximitySensor
        active: true
        alwaysOn: true
        dataRate: 10


        onReadingChanged: {
            proximityLabel.text = qsTr("proximity = %1").arg(reading.near)
            if (reading.near == 1) {
                nearTest.passed = true;
            }
            if (reading.near == 0) {
                farTest.passed = true;
            }
        }

    }


    Component.onCompleted: {
        proximitySensor.start();
    }

}
