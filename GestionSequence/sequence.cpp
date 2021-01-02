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

void Sequence::addFilleToAction(int indiceActionMere, int indiceActionFille)
{
    if(indiceActionMere < listActionSequence.size() && indiceActionFille < listActionSequence.size())
        listActionSequence.at(indiceActionMere)->addFille(listActionSequence.at(indiceActionFille));
}

void Sequence::addPereToAction(int indiceActionFille, int indiceActionPere)
{
    if(indiceActionFille < listActionSequence.size() && indiceActionPere < listActionSequence.size())
        listActionSequence.at(indiceActionFille)->addPapa(listActionSequence.at(indiceActionPere));
}

void Sequence::addTimeoutToAction(int indiceActionMere, int indiceActionTimeout)
{
    if(indiceActionMere < listActionSequence.size() && indiceActionTimeout < listActionSequence.size())
        listActionSequence.at(indiceActionMere)->addTimeout(listActionSequence.at(indiceActionTimeout));
}

void Sequence::saveSequence(QString fileName)
{
    QFile saveFile("data/Sequence/"+ fileName +".json");
    if(!saveFile.open(QIODevice::ReadWrite))
    {
        qDebug()<<"Failed ! "<<saveFile.fileName();
    }else
    {
        saveFile.flush();
        saveFile.resize(0);
        QJsonArray arraySequence;
        QJsonObject objectSequence;
        for(Action * act : listActionSequence)
        {
            QJsonObject saveObject;
            QJsonArray arrayParam;

            saveObject["indice"] = listActionSequence.indexOf(act);
            saveObject["nomAction"] = act->getNom();
            QString nomParam("nomParam");
            QString defaultValue("defaultValue");
            for(int i = 0; i < act->getNbParam(); i++)
            {
                QJsonObject item_data;
                item_data.insert(nomParam, QJsonValue(act->getParamName(i)));
                item_data.insert(defaultValue, QJsonValue(act->getParamDefaultValue(i)));
                arrayParam.push_back(QJsonValue(item_data));
            }

            QJsonArray arrayPere;
            QString indicePere("indicePere");
            for(int i = 0; i < act->getListPere().size(); i++)
            {
                QJsonObject item_daddy;
                item_daddy.insert(indicePere, listActionSequence.indexOf(act->getListPere().at(i)));
                arrayPere.push_back(QJsonValue(item_daddy));
            }

            QJsonArray arrayFille;
            QString indiceFille("indiceFille");
            for(int i = 0; i < act->getListFille().size(); i++)
            {
                QJsonObject item_girl;
                item_girl.insert(indiceFille, listActionSequence.indexOf(act->getListFille().at(i)));
                arrayFille.push_back(QJsonValue(item_girl));
            }

            QJsonArray arrayTimeout;
            QString indiceTimeout("indiceTimeout");
            for(int i = 0; i < act->getListTimeout().size(); i++)
            {
                QJsonObject item_timeout;
                item_timeout.insert(indiceTimeout, listActionSequence.indexOf(act->getListTimeout().at(i)));
                arrayTimeout.push_back(QJsonValue(item_timeout));
            }
            saveObject["arrayDaddy"] = arrayPere;
            saveObject["arrayGirl"] = arrayFille;
            saveObject["arrayTimeout"] = arrayTimeout;
            saveObject["arrayParam"] = arrayParam;
            saveObject["blocante"] = act->isBlocante();
            //saveObject["xBloc"] = item->getXBloc();
            //saveObject["yBloc"] = item->getYBloc();

            arraySequence.push_back(QJsonValue(saveObject));
        }

        objectSequence["sequence"] = arraySequence;
        QJsonDocument saveDoc(objectSequence);
        saveFile.write(saveDoc.toJson());
        saveFile.close();
    }
}

void Sequence::onFinInitActions()
{

}
