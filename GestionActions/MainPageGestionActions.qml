import QtQuick 2.0
import "../Composants"
import Qt.labs.animation 1.0
import QtQuick.Controls 2.15

Item {
    id: item1
    width:1500
    height:800
    property int actionEnCours:-1

    function addAction(nom)
    {
        gestActions.addAction()
        listAction.append({"_x":(listAction.count%2)==1?(listAction.count==1?0:(Math.floor(listAction.count/2))*115)+5:((listAction.count/2)*115)+5, "_y":(listAction.count%2)==1?50:5, "_height":40 , "_width":110, "_nom":nom , "index" : listAction.count, "_color":"#00ffffff", "isBlocante": 0})
    }

    Component.onCompleted:
    {
        listAction.clear()
        gestActions.openAllAction()
    }

    Connections
    {
        target:gestActions
        function onFinChargementAllActions()
        {
            item1.actionEnCours = -1
            listAction.clear()
            for(var i = 0; i < gestActions.getNbAction(); i++)
            {
                listAction.append({"_x":(listAction.count%2)==1?(listAction.count==1?0:(Math.floor(listAction.count/2))*115)+5:((listAction.count/2)*115)+5,
                                      "_y":(listAction.count%2)==1?50:5, "_height":40 , "_width":110, "_nom":gestActions.getNomAction(i) , "index" : listAction.count,
                                      "_color":"#00ffffff"})
            }
        }
    }

    ListModel
    {
        id:listAction
        ListElement{ _x:0 ; _y:0; _height:40 ; _width:110; _nom:"Deplacement" ; index : 0; _color:"#00ffffff"; isBlocante: 0}
    }

    FlickableList
    {
        id:flickableList
        height:100
        anchors.left: parent.left
        anchors.right: buttonAddAction.left
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.leftMargin: 0
        anchors.topMargin: 2
        model:listAction
        contentWidth: 5000; contentHeight: 100
        onClickGauche:
        {
            actionEnCours = indice
            parametrageAction.setParam(indice)
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

    Rectangle
    {
        id: rect
        height: 1
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: flickableList.bottom
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        anchors.topMargin: 2
    }

    ParametrageAction {
        id: parametrageAction
        visible:actionEnCours!==-1?true:false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        onChangeNameAction:
        {
            listAction.set(indiceAction, {"_nom":nom})
        }
    }

    Button {
        id: buttonAddAction
        x: 1569
        width: 105
        height: 90
        text: qsTr("Nouvelle action")
        anchors.right: parent.right
        anchors.top: parent.top
        font.bold: true
        anchors.rightMargin: 5
        anchors.topMargin: 5
        onPressed:
        {
            addAction("Nouvelle Action ")
        }
    }
}
