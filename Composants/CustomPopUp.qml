import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import Qt.labs.folderlistmodel 2.12

Popup {
    id: popup
    width: 200
    height: 100
    modal: true
    focus: true
    property string placeholder : ""
    property string textValidButton : "Valider"
    signal validate(string text)

    background: Rectangle
    {
        anchors.fill: parent
        LinearGradient {
            anchors.right: parent.right
            anchors.rightMargin: parent.width/2
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(0, 0)
            end: Qt.point(parent.width/2, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0d0d0d" }
                GradientStop { position: 1.0; color: "#262626" }
            }
        }

        LinearGradient {
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(parent.width/2, 0)
            end: Qt.point(0, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0d0d0d" }
                GradientStop { position: 1.0; color: "#262626" }
            }
        }
    }
    contentItem:
        Rectangle {
        anchors.fill: parent
        color:"transparent"
        TextField
        {
            id:tfinput
            text:placeholder
            height:40
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            color: "white"
            background: Rectangle {
                color:"#22ffffff"
                radius: 10
                anchors.fill: parent
                implicitWidth: 100
                implicitHeight: 24
                border.color: "#333"
                border.width: 1
            }
        }
        Button
        {
            id:validButton
            text:textValidButton
            anchors.top: tfinput.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2 + 5
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            onClicked:
            {
                validate(tfinput.text)
                popup.close()
            }
        }
        Button
        {
            id:closeButton
            text:"Annuler"
            anchors.top: tfinput.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: parent.width/2 + 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            onClicked:
            {
                popup.close()
            }
        }
    }
}
