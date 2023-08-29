import QtQuick
import Nemo.Controls

import QtMultimedia

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
        anchors.fill: parent;
        anchors.margins: Theme.itemSpacingMedium
        spacing: Theme.itemSpacingSmall

        Button {
            text: qsTr("play sound")
            width: parent.width
            onClicked: {
                player.play();
            }
        }
        CheckBox {
            id: soundSheckbox
            text: qsTr("Have you heard some sound?")
            width: parent.width
        }

        Label {
            text:  audioStatusToString(player.status)
            width: parent.width
            wrapMode: Text.WordWrap
        }

        Label {
            text: player.errorString
            width: parent.width
            wrapMode: Text.WordWrap
        }

    }


    Audio {
        id: player;
        source: "file:///usr/share/sounds/glacier/stereo/ring-1.ogg"
    }

    function audioStatusToString(status) {
        switch(status) {
        case Audio.NoMedia: return qsTr('No media has been set.')
        case Audio.Loading: return qsTr('The media is currently being loaded.')
        case Audio.Loaded: return qsTr('The media has been loaded.')
        case Audio.Buffering: return qsTr('The media is buffering data.')
        case Audio.Stalled: return qsTr('Playback has been interrupted while the media is buffering data.')
        case Audio.Buffered: return qsTr('The media has buffered data.')
        case Audio.EndOfMedia: return qsTr('The media has played to the end.')
        case Audio.InvalidMedia: return qsTr('The media cannot be played.')
        case Audio.UnknownStatus:
        default: return qsTr('The status of the media is unknown.')
        }
    }

}
