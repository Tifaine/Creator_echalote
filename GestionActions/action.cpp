#include "action.h"

Action::Action(QString nom):
    _nom(nom),
    blocante(false)
{

}

QString Action::getNom() const
{
    return _nom;
}

void Action::setNom(const QString &value)
{
    _nom = value;
}

bool Action::isBlocante() const
{
    return blocante;
}

void Action::setBlocante(bool value)
{
    blocante = value;
    if(blocante)
    {
        listParam.insert(0, new Parametre);
        listParam.at(0)->name = "Timeout";
        listParam.at(0)->defaultValue = "10000";
    }else
    {
        listParam.removeAt(0);
    }
}

void Action::addParam()
{
    listParam.append(new Parametre);
    listParam.last()->name = "Param";
    listParam.last()->defaultValue = "default";

}

int Action::getNbParam()
{
    return listParam.size();
}

QString Action::getParamName(int indiceParam)
{
    if(indiceParam < listParam.size())
    {
        return listParam.at(indiceParam)->name;
    }
    return "Comment ?";
}

QString Action::getParamDefaultValue(int indiceParam)
{
    if(indiceParam < listParam.size())
    {
        return listParam.at(indiceParam)->defaultValue;
    }
    return "Bravo, mais t'es pas sensé voir ça, enjoy le segfault";
}


void Action::setParamName(int indiceParam, QString name)
{
    if(indiceParam < listParam.size())
    {
        listParam.at(indiceParam)->name = name;
    }
}
void Action::setParamDefaultValue(int indiceParam, QString value)
{
    if(indiceParam < listParam.size())
    {
        listParam.at(indiceParam)->defaultValue = value;
    }
}

void Action::deleteParametre(int indiceParam)
{
    if(indiceParam < listParam.size())
    {
        listParam.removeAt(indiceParam);
    }
}

void Action::addAlias(int indiceParam)
{
    if(indiceParam < listParam.size())
    {
        listParam.at(indiceParam)->listAlias.append(new Alias);
        listParam.at(indiceParam)->listAlias.last()->name = "Alias";
        listParam.at(indiceParam)->listAlias.last()->value = "value";
    }
}

int Action::getNbAlias(int indiceParam)
{
    if(indiceParam < listParam.size())
    {
        return listParam.at(indiceParam)->listAlias.size();
    }
    return 0;
}

QString Action::getAliasName(int indiceParam, int indiceAlias)
{
    if(indiceParam < listParam.size())
    {
        if(indiceAlias < listParam.at(indiceParam)->listAlias.size())
        {
            return listParam.at(indiceParam)->listAlias.at(indiceAlias)->name;
        }
    }
    return "You died.";
}

QString Action::getAliasValue(int indiceParam, int indiceAlias)
{
    if(indiceParam < listParam.size())
    {
        if(indiceAlias < listParam.at(indiceParam)->listAlias.size())
        {
            return listParam.at(indiceParam)->listAlias.at(indiceAlias)->value;
        }
    }
    return "I hear cheh in my oreillette";
}

void Action::setAliasName(int indiceParam, int indiceAlias, QString name)
{
    if(indiceParam < listParam.size())
    {
        if(indiceAlias < listParam.at(indiceParam)->listAlias.size())
        {
            listParam.at(indiceParam)->listAlias.at(indiceAlias)->name = name;
        }
    }
}

void Action::setAliasValue(int indiceParam, int indiceAlias, QString value)
{
    if(indiceParam < listParam.size())
    {
        if(indiceAlias < listParam.at(indiceParam)->listAlias.size())
        {
            listParam.at(indiceParam)->listAlias.at(indiceAlias)->value = value;
        }
    }
}

void Action::deleteAlias(int indiceParam, int indiceAlias)
{
    if(indiceParam < listParam.size())
    {
        if(indiceAlias < listParam.at(indiceParam)->listAlias.size())
        {
            listParam.at(indiceParam)->listAlias.removeAt(indiceAlias);
        }
    }
}
