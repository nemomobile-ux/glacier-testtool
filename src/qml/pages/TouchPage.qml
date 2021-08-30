import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: touchTestPage

    property int columnsCount: 20
    property int itemWidth: 0
    property int itemHeight: 0
    property int itemCount: 0

    property int checkedElements: 0

    signal passedTests(int num);

    Component.onCompleted: {
        itemWidth = checkGrid.width/columnsCount
        itemHeight = checkGrid.height/Math.round(checkGrid.height/itemWidth)
        itemCount = columnsCount*Math.round(checkGrid.height/itemHeight)
    }

    headerTools: HeaderToolsLayout {
        title: qsTr("Touch test")
        showBackButton: true
    }

    Grid{
        id: checkGrid
        anchors.fill: parent
        columns: columnsCount

        Repeater{
            model: itemCount
            delegate: Rectangle{
                id: touchItem
                width: itemWidth
                height: itemHeight
                color: "red"

                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        if(parent.color != "green") {
                            parent.color = "green"
                            checkedElements++
                        }
                    }
                }
            }
        }
    }

    onCheckedElementsChanged: {
        if(checkedElements == itemCount) {
            passedTests(1)
            pageStack.pop();
        }
    }
}
