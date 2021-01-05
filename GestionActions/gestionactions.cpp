#include "gestionactions.h"
#include <QDebug>

GestionActions::GestionActions(QObject *parent) : QObject(parent)
{

}

Action* GestionActions::getAction(int indiceAction)
{
    return listActions.at(indiceAction);
}

int GestionActions::getNbAction()
{
    return listActions.size();
}

void GestionActions::addAction()
{
    listActions.append(new Action("Nouvelle action"));
}

void GestionActions::modifyName(int indiceAction, QString nom)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->setNom(nom);
    }
}

void GestionActions::modifyIsBlocante(int indiceAction, bool blocante)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->setBlocante(blocante);       
    }
}

QString GestionActions::getNomAction(int indiceAction)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getNom();
    }
    //On est pas sensé arriver là, du coup on est pas poli si on y arrive.
    return "You little piece of shit";
}

bool GestionActions::getIsActionBlocante(int indiceAction)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->isBlocante();
    }
    return false;
}

void GestionActions::addParam(int indiceAction)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->addParam();
    }
}

int GestionActions::getNbParam(int indiceAction)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getNbParam();
    }
    return -1;
}

QString GestionActions::getParamName(int indiceAction, int indiceParam)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getParamName(indiceParam);
    }
    return "You failed this appli";
}

QString GestionActions::getParamDefaultValue(int indiceAction, int indiceParam)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getParamDefaultValue(indiceParam);
    }
    return "Rest in rip";
}

void GestionActions::setParamName(int indiceAction, int indiceParam, QString name)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->setParamName(indiceParam, name);
    }
}

void GestionActions::setParamDefaultValue(int indiceAction, int indiceParam, QString value)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->setParamDefaultValue(indiceParam, value);
    }
}

void GestionActions::deleteParametre(int indiceAction, int indiceParam)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->deleteParametre(indiceParam);
    }
}

void GestionActions::addAlias(int indiceAction, int indiceParam)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->addAlias(indiceParam);
    }
}

int GestionActions::getNbAlias(int indiceAction, int indiceParam)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getNbAlias(indiceParam);
    }
    return -1;
}

QString GestionActions::getAliasName(int indiceAction, int indiceParam, int indiceAlias)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getAliasName(indiceParam, indiceAlias);
    }
    return "WTF MAN";
}

QString GestionActions::getAliasValue(int indiceAction, int indiceParam, int indiceAlias)
{
    if(indiceAction < listActions.size())
    {
        return listActions.at(indiceAction)->getAliasValue(indiceParam, indiceAlias);
    }
    return "gg but not gg";
}

void GestionActions::setAliasName(int indiceAction, int indiceParam, int indiceAlias, QString name)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->setAliasName(indiceParam, indiceAlias, name);
    }
}

void GestionActions::setAliasValue(int indiceAction, int indiceParam, int indiceAlias, QString value)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->setAliasValue(indiceParam, indiceAlias, value);
    }
}

void GestionActions::deleteAlias(int indiceAction, int indiceParam, int indiceAlias)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->deleteAlias(indiceParam, indiceAlias);
    }
}

void GestionActions::saveAction(int indiceAction)
{
    if(indiceAction < listActions.size())
    {
        listActions.at(indiceAction)->save();
    }
}

void GestionActions::updateAliasSequence()
{
    QDir dir("data/Sequence");
    QStringList filters;
    filters << "*.json";
    dir.setNameFilters(filters);
    QFileInfoList list = dir.entryInfoList();

    if(listActions.at(2)->getNom().compare("Sequence") == 0)
    {
        while(listActions.at(2)->getNbAlias(0) > 0)
        {
            listActions.at(2)->deleteAlias(0,0);
        }
    }

    for(int i = 0; i < list.size(); i++)
    {
        listActions.at(2)->addAlias(0);
        listActions.at(2)->setAliasName( 0, i, list.at(i).fileName().left(list.at(i).fileName().length()-5));
        listActions.at(2)->setAliasValue(0, i, list.at(i).fileName().left(list.at(i).fileName().length()-5));
    }
}

void GestionActions::openAllAction()
{
    QDir dir("data/Actions");
    QStringList filters;
    filters << "*.json";
    dir.setNameFilters(filters);
    QFileInfoList list = dir.entryInfoList();

    listActions.clear();
    listActions.append(new Action("Départ"));
    listActions.append(new Action("Fin"));
    listActions.append(new Action("Sequence"));
    listActions.last()->addParam();
    listActions.last()->setParamName(0, "Nom");
    listActions.last()->setParamDefaultValue(0, "init");
    updateAliasSequence();

    for(int i = 0; i < list.size(); i++)
    {
        listActions.append(new Action("boop"));
        listActions.last()->loadAction("data/Actions/"+list.at(i).fileName());
    }
    emit finChargementAllActions();
}
