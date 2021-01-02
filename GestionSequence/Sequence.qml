import QtQuick 2.12
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import sequence 1.0
import "../Composants"
import connector 1.0

Item {
    id:sequence

    Component.onCompleted:
    {
        listAction.clear()
    }

    function saveSequence(nomSequence)
    {
        sequenceCpp.saveSequence(nomSequence)
    }

    function addAction(indiceAction, nameAction)
    {
        sequenceCpp.addAction(indiceAction)

        listAction.append({"_x": 100, "_y": 100})

        //Quand on créé une action, on lui indique son indice d'action global, afin d'obtenir tous les paramètres généraux tel que le nom, le nombre de param...
        //On indique aussi son indice spécifique, pour pouvoir obtenir et modifier ses paramètres relatifs
        //Par exemple les valeurs x,y d'une action Position doivent être relatifs à une action.
        repeaterAction.itemAt(sequenceCpp.getNbActionInSequence() -1).setAction(indiceAction, sequenceCpp.getNbActionInSequence() -1)
    }

    SequenceCPP
    {
        id:sequenceCpp
    }

    Keys.onReleased:
    {
        if (event.key === Qt.Key_Control)
        {
            ctrl_pressed = false
            event.accepted = true;
        }
    }

    property var mXScale:1
    property var mYScale:1
    Rectangle
    {
        anchors.fill: parent
        id:rectParent
        color:"transparent"

        Flickable
        {
            clip:true
            id: flickable
            flickableDirection: Flickable.HorizontalAndVerticalFlick
            anchors.fill: parent
            contentWidth: 15000; contentHeight: 15000
            contentX: 0
            contentY:0

            ScrollBar.vertical: ScrollBar {
                parent: flickable.parent
                anchors.top: flickable.top
                anchors.right: flickable.right
                anchors.bottom: flickable.bottom
            }
            ScrollBar.horizontal: ScrollBar {
                parent: flickable.parent
                anchors.left: flickable.left
                anchors.right: flickable.right
                anchors.bottom: flickable.bottom
            }

            Rectangle
            {
                anchors.fill: parent
                color:"transparent"

                transform: Scale { origin.x: 0; origin.y: 0; xScale: mXScale; yScale: mYScale}

                Connector
                {
                    id:connector
                    x1:0
                    y1:0
                    x2:0
                    y2:0
                    _color:"red"
                }

                MouseArea
                {
                    id:mouseAreaCanvas
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true
                    onMouseXChanged:
                    {
                        if(repeaterAction.sortieClicked !== 0)
                        {
                            connector.x2 = mouseX
                        }
                    }
                    onMouseYChanged:
                    {
                        if(repeaterAction.sortieClicked !== 0)
                        {
                            connector.y2 = mouseY
                        }
                    }
                    onClicked:
                    {
                        connector.x1 = 0
                        connector.y1 = 0
                        connector.x2 = 0
                        connector.y2 = 0
                        repeaterAction.sortieClicked = 0

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
                            if(action !== repeaterAction.sortieClicked)
                            {
                                if(connector._color === "red") //add timeout
                                {
                                    repeaterAction.sortieClicked.addTimout(action)
                                }else //add fille
                                {
                                    repeaterAction.sortieClicked.addFille(action)
                                }


                                action.addPere(repeaterAction.sortieClicked)

                                connector.x1 = 0
                                connector.y1 = 0
                                connector.x2 = 0
                                connector.y2 = 0
                                repeaterAction.sortieClicked = 0
                            }
                        }
                        onSortieClicked:
                        {
                            connector.x1 = action.xSortieClicked
                            connector.y1 = action.ySortieClicked
                            connector.x2 = action.xSortieClicked
                            connector.y2 = action.ySortieClicked
                            repeaterAction.sortieClicked = action
                            connector._color = "green"
                        }

                        onTimeoutClicked:
                        {
                            connector.x1 = action.xTimeoutClicked
                            connector.y1 = action.yTimeoutClicked
                            connector.x2 = action.xTimeoutClicked
                            connector.y2 = action.yTimeoutClicked
                            repeaterAction.sortieClicked = action
                            connector._color = "red"
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
        }
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
