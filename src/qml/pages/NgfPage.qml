import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import org.nemomobile.folderlistmodel 1.0
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
        title: qsTr("Non graphical feedback")
        showBackButton: true
    }

    Column {
        width: parent.width;
        anchors.margins: Theme.itemSpacingMedium
        spacing: Theme.itemSpacingSmall


        GlacierRoller {
            id: simpleRoller
            width: parent.width

            clip: true
            model: dirModel
            label: qsTr("Select event")

            onCurrentIndexChanged: {
                var event = dirModel.data(currentIndex, "fileName").replace(/.ini$/g, "")
                console.log(currentIndex + " " + event);
                feedback.event = event
            }

            delegate: GlacierRollerItem{
                Text{
                    height: simpleRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: fileName.replace(/.ini$/g, "");
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (simpleRoller.activated && simpleRoller.currentIndex === index)
                }
            }
        }


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
            text: feedback.connected ? qsTr("Connected") : qsTr("Not connected")
        }

        Label {
            text: qsTr("Event: %1").arg(feedback.event)
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


    FolderListModel {
        id: dirModel
        path: "/usr/share/ngfd/events.d"
    }



    NonGraphicalFeedback {
        id: feedback
        event: "sms"
    }

}
