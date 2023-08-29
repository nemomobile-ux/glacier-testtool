import QtQuick
import Nemo.Controls
import org.nemomobile.folderlistmodel
import Nemo.Ngf

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
            width: parent.width;
            wrapMode: Text.Wrap
        }

        Label {
            text: qsTr("Event: %1").arg(feedback.event)
            width: parent.width;
            wrapMode: Text.Wrap
        }

        Label {
            text: ngf_status_to_string(feedback.status)
            width: parent.width;
            wrapMode: Text.Wrap
        }

        CheckBox {
            id: soundSheckbox
            text: qsTr("Have you had some feedback?")
        }
    }

    function ngf_status_to_string(s) {
        switch(s) {
        case NonGraphicalFeedback.Stopped: return qsTr("Stopped");
        case NonGraphicalFeedback.Failed:  return qsTr("Failed");
        case NonGraphicalFeedback.Playing: return qsTr("Playing");
        case NonGraphicalFeedback.Paused: return qsTr("Paused");
        default: return qsTr("Unknown");
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
