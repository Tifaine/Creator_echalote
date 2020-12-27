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

int Sequence::getNbActionInSequence()
{
    return listActionSequence.size();
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
}

int Sequence::getNbParamAction(int indiceAction)
{
    return gestActions->getAction(indiceAction)->getNbParam();
}

QString Sequence::getNomParamAction(int indiceAction, int indiceParam)
{
    return gestActions->getParamName(indiceAction, indiceParam);
}

QString Sequence::getDefaultValueParamAction(int indiceAction, int indiceParam)
{
    return gestActions->getParamDefaultValue(indiceAction, indiceParam);
}

int Sequence::getNbAliasParamAction(int indiceAction, int indiceParam)
{
    return gestActions->getNbAlias(indiceAction, indiceParam);
}

QString Sequence::getNomAliasParamAction(int indiceAction, int indiceParam, int indiceAlias)
{
    return gestActions->getAliasName(indiceAction, indiceParam, indiceAlias);
}
QString Sequence::getValueAliasParamAction(int indiceAction, int indiceParam, int indiceAlias)
{
    return gestActions->getAliasValue(indiceAction, indiceParam, indiceAlias);
}

void Sequence::setParamValue(int indiceAction, int indiceParam, QString value)
{
    if(indiceAction < listActionSequence.count())
    {
        listActionSequence.at(indiceAction)->setParamDefaultValue(indiceParam, value);
    }
}

void Sequence::detailActions()
{
    for(Action* act : listActionSequence)
    {
        act->toString();
    }
}

void Sequence::onFinInitActions()
{

}
