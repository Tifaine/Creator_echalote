import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13

Item {
    id:selecteurOngletHorizontal
    width:800
    height: 30

    property var model
    signal changeAffichage(var nb)
    property int indiceAffiche:0

    Row {
        id: row
        anchors.fill: parent

        Repeater
        {
            id:repeater
            model:selecteurOngletHorizontal.model
            anchors.fill: parent
            ColumnLayout
            {
                id: rowLayout
                height:30
                width:selecteurOngletHorizontal.width / selecteurOngletHorizontal.model.count
                x:width * index
                y:0
                MouseArea
                {
                    id: mouseArea1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onClicked:
                    {
                        selecteurOngletHorizontal.indiceAffiche=index
                        selecteurOngletHorizontal.changeAffichage(index)
                    }
                    Rectangle {
                        id: rectangle4
                        color:indiceAffiche==index?"#262626":"transparent"
                        anchors.bottomMargin: 1
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Text {
                        id: element2
                        text: _nom
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        font.pixelSize: 12
                        color:indiceAffiche==index?"white":"white"
                    }

                    Rectangle {
                        id: rectangle2
                        width: 1
                        color: "white"
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.top: rectangle4.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                        Layout.preferredHeight: 1
                        Layout.fillWidth: true
                    }

                }
            }
        }
    }

    Rectangle {
        id: rectangle
        y: 164
        height: 1
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 0
    }
}
