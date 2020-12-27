import QtQuick 2.0
import sequence 1.0
import "../Composants"

Item {
    id:sequence

    Component.onCompleted:
    {
        listAction.clear()
    }

    function saveSequence()
    {
        sequenceCpp.detailActions()
    }

    function addAction(indiceAction, nameAction)
    {
        sequenceCpp.addAction(indiceAction)

        listAction.append({"_x": 100, "_y": 100})

        //Quand on créé une action, on lui indice son indice d'action global, afin d'obtenir tous les paramètres généraux tel que le nom, le nombre de param...
        //On indique aussi son indice spécifique, pour pouvoir obtenir et modifier ses paramètres relatifs
        //Par exemple les valeurs x,y d'une action Position doivent être relatifs à une action.
        repeaterAction.itemAt(sequenceCpp.getNbActionInSequence() -1).setAction(indiceAction, sequenceCpp.getNbActionInSequence() -1)
    }

    SequenceCPP
    {
        id:sequenceCpp
    }

    Canvas
    {
        id: mycanvas
        anchors.fill: parent
        property int xMousePresent:0
        property int yMousePresent:0
        MouseArea
        {
            id:mouseAreaCanvas
            anchors.fill: parent
            hoverEnabled: true
            preventStealing :true
            onMouseXChanged:
            {
                if(repeaterAction.sortieClicked !== null)
                {
                    console.log(repeaterAction.childAt(mouseX, mouseY))
                    mycanvas.xMousePresent = mouseX
                    mycanvas.requestPaint()
                }
            }
            onMouseYChanged:
            {
                if(repeaterAction.sortieClicked !== null)
                {
                    mycanvas.yMousePresent = mouseY
                    mycanvas.requestPaint()
                }
            }
        }

        onPaint: {


            if(repeaterAction.sortieClicked !== null)
            {
                var ctx = getContext("2d");
                ctx.reset()
                ctx.strokeStyle = Qt.rgba(0, 0, 0.99, 1);
                ctx.lineWidth = 1;
                ctx.beginPath()
                ctx.moveTo(repeaterAction.sortieClicked.xSortieClicked, repeaterAction.sortieClicked.ySortieClicked)
                ctx.lineTo(xMousePresent, yMousePresent)
                ctx.closePath()
                ctx.stroke()
            }
        }
    }

    ListModel
    {
        id:listAction
        ListElement
        {
            _x:0
            _y:0
        }
    }

    Repeater
    {
        property var entreeClicked:0
        property var sortieClicked:0
        id:repeaterAction
        model:listAction
        anchors.fill: parent
        BlocAction
        {
            id:action
            x: _x
            y: _y
            _sequenceCpp:sequenceCpp

            onEntreeClicked:
            {

                if(action !== sortieClicked)
                {
                    repeaterAction.entreeClicked = action
                }
            }
            onSortieClicked:
            {
                repeaterAction.sortieClicked = action
                mycanvas.requestPaint()
            }

            function setAction(indiceAction, indiceInSequence)
            {
                action.indiceAction = indiceAction
                action.indiceInSequence = indiceInSequence
                action.init()
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
