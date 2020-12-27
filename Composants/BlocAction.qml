import QtQuick 2.0
import QtQuick.Controls 2.15

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
    property var _sequenceCpp
    property bool _isInit : false

    signal entreeClicked()
    signal sortieClicked()

    function init()
    {
        listParameterAction.clear()
        if(indiceAction > -1 )
        {
            //C'est dégeulasse. Trouver autre chose de plus propre.
            var taille = 0;
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

    Rectangle {
        id: entree
        objectName: "entree"
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
                xEntreeClicked = item1.x + entree.x + entree.width/2
                yEntreeClicked = item1.y + entree.y + entree.height/2
                entreeClicked()
            }
        }
    }

    Rectangle {
        id: sortie
        objectName: "sortie"
        z:1
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
                xSortieClicked = item1.x + sortie.x + sortie.width/2
                ySortieClicked = item1.y + sortie.y + sortie.height/2
                sortieClicked()
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
            color : "#4d0000"

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
