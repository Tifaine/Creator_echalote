#include "sequence.h"

Sequence::Sequence():
    gestActions(new GestionActions())
{
    connect(gestActions, SIGNAL(finChargementAllActions()), SLOT(onFinInitActions()));
    init();
}


void Sequence::init()
{
    gestActions->openAllAction();
}

int Sequence::getNbAction()
{
    return gestActions->getNbAction();
}

QString Sequence::getNomAction(int indiceAction)
{
    return gestActions->getNomAction(indiceAction);
}

void Sequence::addAction(int indiceAction)
{
    listActionSequence.append(gestActions->getAction(indiceAction));
    QString nameToPrint;
    for(int i = 0; i < listActionSequence.size(); i++)
    {
        nameToPrint.append(listActionSequence.at(i)->getNom());
        nameToPrint.append(" ");
    }

    qDebug()<<listActionSequence.size()<<" "<<nameToPrint;
}

void Sequence::onFinInitActions()
{

}
