import QtQuick
import Nemo.Controls

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
            id: repeater;
            model: itemCount
            delegate: Rectangle{
                id: touchItem
                property bool checked: false
                width: itemWidth
                height: itemHeight
                color: checked ? "green" : "red"
            }
        }

    }

    MouseArea{
        anchors.fill: checkGrid
        onPositionChanged:  {

            if ((mouse.x >= width) || (mouse.x < 0)) {
                return;
            }
            if ((mouse.y >= height) || (mouse.y < 0)) {
                return;
            }

            var coordX = parseInt(mouse.x / itemWidth)
            var coordY = parseInt(mouse.y / itemHeight)

            if (coordX >= columnsCount) {
                // outside of grid (overflow to next row)
                return;
            }
            var index = coordY * columnsCount + coordX

            if (!repeater.itemAt(index).checked) {
                repeater.itemAt(index).checked = true;
                checkedElements++
            }
        }
    }


    onCheckedElementsChanged: {
        if(checkedElements == itemCount) {
            passedTests(1)
            main.pageStack.pop();
        }
    }
}
