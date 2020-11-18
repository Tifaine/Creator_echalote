import QtQuick 2.0
import "../Composants"
import QtQuick.Controls 2.15

Item {
    id: item1
    width:1500
    height:800

    Component.onCompleted:
    {
        listActionSequence.clear()
        gestActionsSequence.openAllAction()
    }

    Connections
    {
        target:gestActionsSequence
        function onFinChargementAllActions()
        {
            listActionSequence.clear()
            for(var i = 0; i < gestActionsSequence.getNbAction(); i++)
            {
                listActionSequence.append({"_x":5,
                                      "_y":listActionSequence.count * 45, "_height":40 , "_width":110, "_nom":gestActionsSequence.getNomAction(i) , "index" : listActionSequence.count,
                                      "_color":"#00ffffff"})
            }
        }
    }

    ListModel
    {
        id:listActionSequence
        ListElement{ _x:0 ; _y:0; _height:40 ; _width:110; _nom:"Deplacement" ; index : 0; _color:"#00ffffff"; isBlocante: 0}
    }

    FlickableList
    {
        id:flickableList
        width: 120
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 5
        anchors.topMargin: 5

        model:listActionSequence
        vertical: true
        contentWidth: 120; contentHeight: 5000
        onClickGauche:
        {

        }
        onClickDroit:
        {
            console.log("droit", indice, nom)
        }
        onDoubleClick:
        {
            console.log("double", indice, nom)
        }
    }

    Rectangle {
        id: rectangle
        width: 1
        color: "#ffffff"
        anchors.left: flickableList.right
        anchors.top: selecteurSequence.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 5
    }

    SwipeView {
        id: swipeView
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        clip:true
        orientation: Qt.Horizontal
        interactive: false
        currentIndex: selecteurSequence.indiceAffiche

        Item
        {
            id: item00
        }
        Item
        {
            id: item2
        }
        Item
        {
            id: item3
        }
        Item
        {
            id: item4
        }
        Item
        {
            id: item5
        }
        Item
        {
            id: item6
        }
        Item
        {
            id: item7
        }
        Item
        {
            id: item8
        }
    }


    ListModel
    {
        //On remplit la liste des onglets que l'on veut.
        id:listSequence
        ListElement{ _nom:"Init" ;     index : 0 }
    }

    SelecteurOngletHorizontal
    {
        id:selecteurSequence
        anchors.left: rectangle.right
        anchors.right: buttonAddSequence.left
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.leftMargin: 5
        anchors.topMargin: 0
        model:listSequence
    }
    Text
    {
        id: buttonAddSequence
        width: 30
        height: 30
        text:"\ue931"
        color:mouseAreaAddSeq.pressed?Qt.darker("white", 2):"white"
        anchors.right: buttonOpenSequence.left
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pointSize: 15
        anchors.rightMargin: 10
        MouseArea
        {
            id:mouseAreaAddSeq
            anchors.fill: parent
            onReleased:
            {
                listSequence.append({"_nom":"Séquence", "index":listSequence.count})
            }
        }
    }
    Text
    {
        id: buttonOpenSequence
        width: 30
        height: 30
        text:"\ue9c8"
        color:mouseAreaOpenSeq.pressed?Qt.darker("white", 2):"white"
        anchors.right: buttonSaveSequence.left
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pointSize: 15
        anchors.rightMargin: 10
        MouseArea
        {
            id:mouseAreaOpenSeq
            anchors.fill: parent
            onReleased:
            {

            }
        }
    }
    Text
    {
        id: buttonSaveSequence
        width: 30
        height: 30
        text:"\ue962"
        color:mouseAreaSaveSeq.pressed?Qt.darker("white", 2):"white"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pointSize: 15
        anchors.rightMargin: 5
        MouseArea
        {
            id:mouseAreaSaveSeq
            anchors.fill: parent
            onReleased:
            {

            }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50"}D{i:5}D{i:6}
}
##^##*/
