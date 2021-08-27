import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtFeedback 5.0

Page {
    id: page

    property int passedNumber: hapticalCheckbox.checked ? 1 : 0

    signal passedTests(int num);
    onPassedNumberChanged: {
        passedTests(passedNumber)
        if (passedNumber == 1) {
            pageStack.pop();
        }
    }


    headerTools: HeaderToolsLayout {
        title: qsTr("Vibrations")
        showBackButton: true
    }

    Column {
        width: parent.width;
        anchors.margins: Theme.itemSpacingMedium
        spacing: Theme.itemSpacingSmall

        Button {
            text: qsTr("test")
            onClicked: {
                rumbleEffect.start();  // plays a rumble effect
            }
        }

        Label {
            text: act.name
        }

        Label {
            text: act.valid ? qsTr("Valid") : qsTr("Invalid")
        }

        Label {
            text: act.enabled ? qsTr("Enabled") : qsTr("Disabled")
        }


        Label {
            text: (act.state == Actuator.Busy)
                  ? qsTr("Busy")
                  : (act.state === Actuator.Ready)
                    ? qsTr("Ready") : qsTr("Unknown")

        }


        CheckBox {
            id: hapticalCheckbox
            text: qsTr("Have you had some feedback?")
        }
    }


    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 0.0
        attackTime: 50
        intensity: 1.0
        duration: 500
        fadeTime: 50
        fadeIntensity: 0.0

    }

    Actuator {
        id:act
    }


}
