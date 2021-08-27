import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import Nemo.Ngf 1.0

Page {
    id: page

    property int passedNumber: soundSheckbox.checked ? 1 : 0

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
                if (feedback.status !== NonGraphicalFeedback.Playing) {
                    feedback.play();
                } else {
                    feedback.stop();
                }
            }
        }

        Label {
            text: (feedback.status === NonGraphicalFeedback.Stopped)
                  ? qsTr("Stopped") :
                    (feedback.status === NonGraphicalFeedback.Failed)
                    ? qsTr("Failed") :
                      (feedback.status === NonGraphicalFeedback.Playing)
                      ? qsTr("Playing") :
                        (feedback.status === NonGraphicalFeedback.Paused)
                        ? qsTr("Paused") : qsTr("Unknown")

        }

        CheckBox {
            id: soundSheckbox
            text: qsTr("Have you had some feedback?")
        }
    }


    NonGraphicalFeedback {
        id: feedback
    }

}
