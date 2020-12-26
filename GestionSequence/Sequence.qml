import QtQuick 2.0
import sequence 1.0
import "../Composants"

Item {
    id:sequence

    Component.onCompleted:
    {
        listAction.clear()
    }

    function addAction(indiceAction, nameAction)
    {
        console.log(indiceAction, nameAction)
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
        id:repeaterAction
        model:listAction
        anchors.fill: parent
        BlocAction
        {
            id:action
            x: _x
            y: _y
            width: 200
            height: 199
            _sequenceCpp:sequenceCpp

            function setAction(indiceAction, indiceInSequence)
            {
                action.indiceAction = indiceAction
                action.indiceInSequence = indiceInSequence
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
