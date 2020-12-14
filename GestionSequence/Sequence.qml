import QtQuick 2.0
import sequence 1.0
import "../Composants"

Item {
    id:sequence

    Component.onCompleted:
    {

    }

    function addAction(indiceAction, nameAction)
    {
        console.log(indiceAction, nameAction)
        sequenceCpp.addAction(indiceAction)
    }

    SequenceCPP
    {
        id:sequenceCpp
    }

    BlocAction
    {
        x: 147
        y: 97
        width: 200
        height: 199

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
