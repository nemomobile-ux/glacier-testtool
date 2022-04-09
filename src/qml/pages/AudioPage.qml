import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import QtMultimedia 5.12

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
        title: qsTr("Audio")
        showBackButton: true
    }

    Column {
        width: parent.width;
        anchors.margins: Theme.itemSpacingMedium
        spacing: Theme.itemSpacingSmall

        Button {
            text: qsTr("play sound")
            onClicked: {
                player.play();
            }
        }
        CheckBox {
            id: soundSheckbox
            text: qsTr("Have you heard some sound?")
        }
    }


    Audio {
        id: player;
        source: "file:///usr/share/sounds/glacier/stereo/ring-1.ogg"
    }

}
