import QtQuick 2.0
import QtQuick.Controls 2.15

import "../Composants"

Item
{
    id: item1
    width:1500
    height:700
    property bool isModificationManual : true
    property int indiceActionEnCours : -1
    property int indiceParamEnCours : -1
    signal changeNameAction(int indiceAction, string nom)

    Component.onCompleted:
    {
        listParam.clear()
        listAlias.clear()
    }

    function setParam(indiceAction)
    {
        isModificationManual = false
        indiceParamEnCours = -1
        indiceActionEnCours = indiceAction
        tfName.text = gestActions.getNomAction(indiceAction)
        cbBlocante.checked = gestActions.getIsActionBlocante(indiceAction)
        listParam.clear()
        listAlias.clear()

        for(var i = 0; i < gestActions.getNbParam(indiceActionEnCours) ; i++)
        {
            listParam.append({"_x": (115 * listParam.count) , "_y": 5, "_height":40 , "_width":110, _nom:gestActions.getParamName(indiceActionEnCours, i), _valueDefault:gestActions.getParamDefaultValue(indiceActionEnCours, i), index:listParam.count, _color:"#00ffffff"})
        }

        isModificationManual = true
    }

    Text
    {
        id: textName
        color: "#ffffff"
        text: qsTr("Nom de l'action :")
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: 17
        anchors.leftMargin: 10
        anchors.topMargin: 17
        minimumPixelSize: 16
        font.bold: true
    }

    TextField
    {
        id: tfName
        width: 150
        anchors.left: textName.right
        anchors.top: parent.top
        anchors.leftMargin: 12
        anchors.topMargin: 15
        placeholderText: qsTr("ActionName")
        color: "white"
        background: Rectangle {
            color:"#22ffffff"
            radius: 10
            border.color: "#333"
            anchors.fill: parent
            border.width: 1
        }

        onTextChanged:
        {
            if(isModificationManual && indiceActionEnCours !== -1)
            {
                gestActions.modifyName(indiceActionEnCours, text)
                changeNameAction(indiceActionEnCours, text)
            }
        }
    }

    Rectangle
    {
        id: cbBlocante
        property bool checked:false
        width: 24
        height: 30
        radius: 5
        color:"transparent"
        border.color: "white"
        border.width: 1
        anchors.left: tfName.right
        anchors.top: parent.top
        anchors.leftMargin: 35
        anchors.topMargin: 13

        Text {
            id: cbText
            text: cbBlocante.checked === false ? qsTr(" "):qsTr("X")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 5
            anchors.rightMargin: 120
            font.bold: true
            font.pointSize: 15
            color:"white"
        }
        MouseArea
        {
            id:mouseAreaCB
            anchors.fill: parent
            onClicked:
            {
                cbBlocante.checked = !cbBlocante.checked
                gestActions.modifyIsBlocante(indiceActionEnCours, cbBlocante.checked)
                setParam(indiceActionEnCours)
            }
        }
    }

    Button
    {
        id: buttonAddParam
        x: 637
        text: qsTr("Ajouter un paramètre")
        anchors.right: rectangle.left
        anchors.top: parent.top
        font.pointSize: 9
        anchors.rightMargin: 10
        anchors.topMargin: 10
        onPressed:
        {
            listParam.append({"_x": (115 * listParam.count) , "_y": 5, "_height":40 , "_width":110, _nom:"Param", _valueDefault:"default", index:listParam.count, _color:"#00ffffff"})

            if(isModificationManual && indiceActionEnCours !== -1)
            {
                gestActions.addParam(indiceActionEnCours)
            }
        }
    }

    Rectangle
    {
        id: rectangle
        width: 1
        color: "#ffffff"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.leftMargin: item1.width/2
        anchors.topMargin: 15
    }

    Text
    {
        id: text1
        color: "#ffffff"
        text: qsTr("Nom du paramètre")
        anchors.left: parent.left
        anchors.right: rectangle1.left
        anchors.top: tfName.bottom
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        minimumPixelSize: 14
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 20
    }

    Text
    {
        id: text2
        color: "#ffffff"
        text: qsTr("Valeur par défaut")
        anchors.left: rectangle1.right
        anchors.right: rectangle.left
        anchors.top: tfName.bottom
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 20
    }

    Rectangle
    {
        id: rectangle1
        width: 1
        color: "#ffffff"
        anchors.left: parent.left
        anchors.top: tfName.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: item1.width/4
        anchors.topMargin: 50
        anchors.bottomMargin: 5
    }

    Button
    {
        id: buttonSave
        text: qsTr("Sauvegarder modifications")
        anchors.left: rectangle.right
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
        font.pointSize: 9
        ToolTip.delay: 500
        ToolTip.visible: hovered
        ToolTip.text:qsTr("Enregistre l'action dans un fichier json.")
    }

    ListModel
    {
        id:listParam
        ListElement{ _x:0 ; _y:0; _height:40 ; _width:110;_nom:"Deplacement" ; _valueDefault : "0"; index: 0; _color:"#00ffffff"}
    }

    Flickable
    {
        id: flickableParam
        anchors.left: parent.left
        anchors.right: rectangle.left
        anchors.top: text1.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        contentWidth: flickableParam.width; contentHeight: 5000

        ScrollBar.vertical: ScrollBar
        {
            parent: flickableParam.parent
            anchors.right: flickableParam.right
            anchors.top: flickableParam.top
            anchors.bottom: flickableParam.bottom
        }

        Rectangle
        {
            id: rectangle2
            color: "transparent"
            anchors.fill: parent
            Repeater
            {
                id:repeaterParam
                visible: false
                model:listParam
                anchors.fill: parent
                Rectangle
                {
                    color: "transparent"
                    height: 33
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: ((index*1.1 * height) + 5)
                    TextField
                    {
                        id: tfNomParam
                        width: 170
                        height: 33
                        text: _nom
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width/2 + 5
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        color: "white"
                        background: Rectangle {
                            color:"#22ffffff"
                            radius: 10
                            border.color: "#333"
                            anchors.fill: parent
                            border.width: 1
                        }
                        onTextChanged:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1)
                            {
                                gestActions.setParamName(indiceActionEnCours, index, text)
                                listParam.set(index, {"_nom":text})
                            }
                        }
                    }
                    TextField
                    {
                        id: tfValDefParam
                        height: 33
                        text: _valueDefault
                        anchors.right: buttonDelete.left
                        anchors.rightMargin: 5
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 + 5
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        color: "white"
                        background: Rectangle {
                            color:"#22ffffff"
                            radius: 10
                            border.color: "#333"
                            anchors.fill: parent
                            border.width: 1
                        }
                        onTextChanged:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1)
                            {
                                gestActions.setParamDefaultValue(indiceActionEnCours, index, text)
                            }
                        }
                    }

                    Button
                    {
                        id:buttonDelete
                        height:20
                        width:20
                        text:"D"
                        anchors.right:parent.right
                        anchors.rightMargin: 12
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        font.pointSize: 8
                        visible:(index===0 && cbBlocante.checked)?false:true
                        onPressed:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1)
                            {
                                gestActions.deleteParametre(indiceActionEnCours, index)
                                setParam(indiceActionEnCours)
                            }
                        }
                    }
                }
            }
        }
    }


    FlickableList
    {
        id:flickableAlias
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.top: buttonSave.bottom
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        height:55
        model:listParam
        contentWidth: 5000; contentHeight: 50
        onClickGauche:
        {
            indiceParamEnCours = indice;
            updateListAlias(indice)
        }
    }

    function updateListAlias(indiceParam)
    {
        listAlias.clear()
        for(var i = 0; i < gestActions.getNbAlias(indiceActionEnCours, indiceParam); i++)
        {
            listAlias.append({"_nom":gestActions.getAliasName(indiceActionEnCours, indiceParam, i),"_valueDefault":gestActions.getAliasValue(indiceActionEnCours, indiceParam, i),
                                 "index":listAlias.count, "_color":"#00ffffff"})
        }
    }

    ListModel
    {
        id:listAlias
        ListElement{ _nom:"Alias" ; _valueDefault : "value"; index: 0; _color:"#00ffffff"}
    }

    Flickable {
        id: flickableListAlias
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.top: flickableAlias.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 5
        Rectangle {
            id: rectangle3
            color: "#00000000"
            anchors.fill: parent
            Repeater {
                id: repeaterParam1
                visible: false
                anchors.fill: parent
                model: listAlias
                Rectangle {
                    height: 33
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: ((index*1.1 * height) + 5)
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    TextField {
                        id: tfNomAlias
                        width: 170
                        height: 33
                        color: "#ffffff"
                        text: _nom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        background: Rectangle {
                            color: "#22ffffff"
                            radius: 10
                            border.color: "#333333"
                            border.width: 1
                            anchors.fill: parent
                        }
                        anchors.topMargin: 0
                        anchors.leftMargin: 5
                        anchors.rightMargin: parent.width/2 + 5
                        onTextChanged:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1 && indiceParamEnCours !== -1)
                            {
                                gestActions.setAliasName(indiceActionEnCours, indiceParamEnCours, index, text)
                            }
                        }

                    }

                    TextField {
                        id: tfValAlias
                        height: 33
                        color: "#ffffff"
                        text: _valueDefault
                        anchors.left: parent.left
                        anchors.right: buttonDelete1.left
                        anchors.top: parent.top
                        background: Rectangle {
                            color: "#22ffffff"
                            radius: 10
                            border.color: "#333333"
                            border.width: 1
                            anchors.fill: parent
                        }
                        anchors.topMargin: 0
                        anchors.leftMargin: parent.width/2 + 5
                        anchors.rightMargin: 5
                        onTextChanged:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1 && indiceParamEnCours !== -1)
                            {
                                gestActions.setAliasValue(indiceActionEnCours, indiceParamEnCours, index, text)
                            }
                        }
                    }

                    Button {
                        id: buttonDelete1
                        width: 20
                        height: 20
                        text: "D"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        font.pointSize: 8
                        anchors.rightMargin: 12
                        onPressed:
                        {
                            if(isModificationManual && indiceActionEnCours !== -1 && indiceParamEnCours !== -1)
                            {
                                gestActions.deleteAlias(indiceActionEnCours, indiceParamEnCours, index)
                                updateListAlias(indiceParamEnCours)
                            }
                        }
                    }
                }
            }
        }
        contentWidth: flickableListAlias.width
        ScrollBar.vertical: ScrollBar {
            anchors.right: flickableListAlias.right
            anchors.top: flickableListAlias.top
            anchors.bottom: flickableListAlias.bottom
            parent: flickableListAlias.parent
        }
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        contentHeight: 5000
    }

    Button {
        id: buttonAddAlias
        text: qsTr("Ajouter alias")
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.topMargin: 10
        onPressed:
        {
            listAlias.append({_nom:"Alias", _valueDefault:"value", index:listAlias.count, _color:"#00ffffff"})
            gestActions.addAlias(indiceActionEnCours, indiceParamEnCours)
        }
    }

    Text {
        id: text3
        text: qsTr("Action blocante")
        anchors.left: cbBlocante.right
        anchors.top: parent.top
        font.pixelSize: 15
        anchors.leftMargin: 5
        anchors.topMargin: 20
        color:"white"
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#808080";height:700;width:1500}D{i:11;annotation:"1 //;;//  //;;//  //;;// <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Essai ?</p></body></html> //;;// 1605373084";customId:""}
D{i:37}
}
##^##*/
