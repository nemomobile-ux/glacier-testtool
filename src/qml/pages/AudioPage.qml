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
            main.pageStack.pop();
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


    MediaPlayer {
        id: player;
        source: "file:///usr/share/sounds/glacier/stereo/ring-1.ogg"
    }

    function audioStatusToString(status) {
        switch(status) {
        case MediaPlayer.NoMedia: return qsTr('No media has been set.')
        case MediaPlayer.LoadingMedia: return qsTr('The media is currently being loaded.')
        case MediaPlayer.LoadedMedia: return qsTr('The media has been loaded.')
        case MediaPlayer.BufferingMedia: return qsTr('The media is buffering data.')
        case MediaPlayer.StalledMedia: return qsTr('Playback has been interrupted while the media is buffering data.')
        case MediaPlayer.BufferedMedia: return qsTr('The media has buffered data.')
        case MediaPlayer.EndOfMedia: return qsTr('The media has played to the end.')
        case MediaPlayer.InvalidMedia: return qsTr('The media cannot be played.')
        default: return qsTr('The status of the media is unknown.')
        }
    }

}
