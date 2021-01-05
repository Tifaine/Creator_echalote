import QtQuick 2.0
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.12
import connector 1.0

Item {
    id: item1
    width: 200
    height: 199
    property int indiceAction : -1
    property int indiceInSequence : -1
    property int xEntreeClicked : 0
    property int yEntreeClicked : 0
    property int xSortieClicked : 0
    property int ySortieClicked : 0
    property int xTimeoutClicked : 0
    property int yTimeoutClicked : 0
    property var _sequenceCpp
    property bool _isInit : false

    property var actionsFilles : []
    property var actionsPere : []
    property var actionsTimeOut : []

    signal entreeClicked()
    signal sortieClicked()
    signal timeoutClicked()

    function init()
    {
        listParameterAction.clear()

        if(indiceAction > -1 )
        {
            var taille = 0;

            if(_sequenceCpp.getNomAction(indiceAction) === "Sequence")
            {
                _sequenceCpp.updateAliasSequence()
            }

            for(var i = 0 ; i < _sequenceCpp.getNbParamAction(indiceAction) ; i++)
            {
                var hasAlias = false
                if(_sequenceCpp.getNbAliasParamAction(indiceAction, i) > 0)
                {
                    hasAlias = true
                }
                listParameterAction.append({"index": listParameterAction.count, "_height": taille, "_parameterName": _sequenceCpp.getNomParamAction(indiceAction, i), "_parameterValue": _sequenceCpp.getDefaultValueParamAction(indiceAction, i), "_hasAlias": hasAlias})
                for(var j = 0; j < _sequenceCpp.getNbAliasParamAction(indiceAction, i); j++)
                {
                    repeaterParameterAction.itemAt(listParameterAction.count - 1).addAlias(_sequenceCpp.getNomAliasParamAction(indiceAction, i , j), _sequenceCpp.getValueAliasParamAction(indiceAction, i , j))
                }

                if( _sequenceCpp.getNomParamAction(indiceAction, i) === "Timeout")
                {
                    timeout.visible = true
                    fondEntete.color = "#4d0000"
                }


                taille += 20
                taille += 30
                taille += 10
                if(hasAlias)
                {
                    taille += 50
                }
            }
            height = taille + 32
            _isInit = true
        }

        xEntreeClicked = item1.x + entree.x + entree.width/2
        yEntreeClicked = item1.y + entree.y + entree.height/2
        xSortieClicked = item1.x + sortie.x + sortie.width/2
        ySortieClicked = item1.y + sortie.y + sortie.height/2
        xTimeoutClicked = item1.x + timeout.x + timeout.width/2
        yTimeoutClicked = item1.y + timeout.y + timeout.height/2
        listConnector.clear()


    }



    function addFille(actionFille)
    {
        if(actionsFilles.indexOf(actionFille) === -1)
        {
            actionsFilles.push(actionFille)

            listConnector.append({"_x1":xSortieClicked - item1.x,
                                     "_y1": ySortieClicked - item1.y,
                                     "_x2": actionFille.xEntreeClicked - item1.x,
                                     "_y2": actionFille.yEntreeClicked - item1.y,
                                     "isTimeout":false,
                                     "color":"blue"})

            _sequenceCpp.addFilleToAction(indiceInSequence, actionFille.indiceInSequence)
        }
    }

    function addTimout(actionFille)
    {
        if(actionsTimeOut.indexOf(actionFille) === -1)
        {
            actionsTimeOut.push(actionFille)
            listConnector.append({"_x1":xTimeoutClicked - item1.x,
                                     "_y1": yTimeoutClicked - item1.y,
                                     "_x2": actionFille.xEntreeClicked - item1.x,
                                     "_y2": actionFille.yEntreeClicked - item1.y,
                                     "isTimeout":true,
                                     "color":"yellow"})

            _sequenceCpp.addTimeoutToAction(indiceInSequence, actionFille.indiceInSequence)
        }
    }

    function addPere(actionPere)
    {
        if(actionsPere.indexOf(actionPere) === -1)
        {
            actionsPere.push(actionPere)
            _sequenceCpp.addPereToAction(indiceInSequence, actionPere.indiceInSequence)
        }
    }

    function actualiseConnector()
    {
        if(_isInit)
        {
            var indiceFille = 0
            var indiceTimeout = 0
            for(var i = 0; i < listConnector.count; i++)
            {
                if(listConnector.get(i).isTimeout === false)
                {
                    listConnector.set(i, {"_x1": xSortieClicked - item1.x,
                                          "_y1": ySortieClicked - item1.y,
                                          "_x2": actionsFilles[indiceFille].xEntreeClicked - item1.x,
                                          "_y2": actionsFilles[indiceFille].yEntreeClicked - item1.y})
                    indiceFille++
                }else
                {
                    listConnector.set(i, {"_x1": xTimeoutClicked - item1.x,
                                          "_y1": yTimeoutClicked - item1.y,
                                          "_x2": actionsTimeOut[indiceTimeout].xEntreeClicked - item1.x,
                                          "_y2": actionsTimeOut[indiceTimeout].yEntreeClicked - item1.y})
                    indiceTimeout++
                }
            }
        }
    }

    onXChanged:
    {
        xEntreeClicked = item1.x + entree.x + entree.width/2
        xSortieClicked = item1.x + sortie.x + sortie.width/2
        xTimeoutClicked = item1.x + timeout.x + timeout.width/2
        actualiseConnector()

        for(var i = 0; i < actionsPere.length; i++)
        {
            actionsPere[i].actualiseConnector()
        }
    }
    onYChanged:
    {
        yEntreeClicked = item1.y + entree.y + entree.height/2
        ySortieClicked = item1.y + sortie.y + sortie.height/2
        yTimeoutClicked = item1.y + timeout.y + timeout.height/2
        actualiseConnector()
        for(var i = 0; i < actionsPere.length; i++)
        {
            actionsPere[i].actualiseConnector()
        }
    }

    MouseArea
    {
        anchors.fill: parent
        drag.target: item1;
        propagateComposedEvents:true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed:
        {

        }
    }

    ListModel
    {
        id:listConnector
        ListElement
        {
            _x1:0
            _y1:0
            _x2:0
            _y2:0
            isTimeout:false
            color:"blue"
        }
    }

    Repeater
    {
        anchors.fill: parent
        model:listConnector
        Connector
        {
            x1:_x1
            y1:_y1
            x2:_x2
            y2:_y2
            _color:color
        }
    }



    Rectangle {
        id: entree
        objectName: "entree"
        visible:testNom.text!=="Départ"
        z:1
        width: 12
        height: 12
        color: "#000000"
        radius: 6
        border.color: "#03eb07"
        anchors.right: parent.left
        anchors.top: parent.top
        anchors.rightMargin: -6
        anchors.topMargin: 6
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {

                entreeClicked()
            }
        }
    }

    Rectangle {
        id: sortie
        objectName: "sortie"
        z:1
        visible:testNom.text!=="Fin"
        width: 12
        height: 12
        color: "#000000"
        radius: 6
        border.color: "#0c10d9"
        border.width: 1
        anchors.left: parent.right
        anchors.top: parent.top
        anchors.leftMargin: -6
        anchors.topMargin: 6
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {

                sortieClicked()
            }
        }
    }

    Rectangle {
        id: timeout
        objectName: "timeout"
        z:1
        visible:false
        width: 12
        height: 12
        color: "#000000"
        radius: 6
        border.color: "#ffcc00"
        border.width: 1
        anchors.left: parent.right
        anchors.top: sortie.bottom
        anchors.leftMargin: -6
        anchors.topMargin: 6
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                timeoutClicked()
            }
        }
    }

    Rectangle {
        id: fond
        color: "#0cfdfdfd"
        radius: 10
        border.width: 1
        border.color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: fondEntete
            height: 25
            radius: 10
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.left: parent.left
            anchors.leftMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 1
            color : "transparent"

            Rectangle {
                id: separationHeader
                height: 1
                color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }

            Text {
                id: testNom
                color:"white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.bold: true
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pixelSize: 14
                text:indiceAction===-1?"":_sequenceCpp.getNomAction(indiceAction)
            }
        }

        ListModel
        {
            id:listParameterAction
            ListElement //exemple
            {
                _parameterName:"exemple"
                _parameterValue:"exemple"
                _hasAlias:false
                index: 0
                _height: 0
            }
        }

        Column
        {
            id:column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: fondEntete.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            Repeater
            {
                id:repeaterParameterAction
                model:listParameterAction
                anchors.fill: parent

                Rectangle
                {

                    function addAlias(nom, value)
                    {
                        cbParam.addItem(nom, value)
                    }

                    color:"transparent"
                    Text {
                        id: textNomParam
                        height:20
                        width:180
                        x:5
                        y : _height + 5
                        color: "white"
                        font.bold:true
                        text: _parameterName

                        font.pixelSize: 12

                    }

                    CustomComboBox {
                        id: cbParam
                        x:10
                        width:180
                        height:_hasAlias?30:0
                        anchors.top:textNomParam.bottom
                        anchors.topMargin:5
                        visible:_hasAlias
                        onValueTextChanged: textFieldValueParam.text = text
                    }

                    TextField {
                        id: textFieldValueParam
                        x:10
                        height:30
                        width:180
                        anchors.top:cbParam.bottom
                        anchors.topMargin:_hasAlias?5:0
                        text: _parameterValue
                        color: "white"
                        background: Rectangle
                        {
                            color:"#22ffffff"
                            radius: 10
                            border.color: "#333"
                            anchors.fill: parent
                            border.width: 1
                        }
                        onTextChanged:
                        {
                            if(_isInit)
                            {
                                sequenceCpp.setParamValue(indiceInSequence, index, text)
                            }
                        }
                    }
                }
            }
        }
    }



}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50";formeditorZoom:3}D{i:2}D{i:4}
}
##^##*/
