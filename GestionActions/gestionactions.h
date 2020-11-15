#ifndef GESTIONACTIONS_H
#define GESTIONACTIONS_H

#include <QObject>
#include <QList>
#include "action.h"

class GestionActions : public QObject
{
    Q_OBJECT
public:
    explicit GestionActions(QObject *parent = nullptr);

public slots:
    void addAction();
    void modifyName(int indiceAction, QString nom);
    void modifyIsBlocante(int indiceAction, bool blocante);
    QString getNomAction(int indiceAction);
    bool getIsActionBlocante(int indiceAction);
    void addParam(int indiceAction);

    int getNbParam(int indiceAction);
    QString getParamName(int indiceAction, int indiceParam);
    QString getParamDefaultValue(int indiceAction, int indiceParam);
    void setParamName(int indiceAction, int indiceParam, QString name);
    void setParamDefaultValue(int indiceAction, int indiceParam, QString value);
    void deleteParametre(int indiceAction, int indiceParam);

    void addAlias(int indiceAction, int indiceParam);
    int getNbAlias(int indiceAction, int indiceParam);
    QString getAliasName(int indiceAction, int indiceParam, int indiceAlias);
    QString getAliasValue(int indiceAction, int indiceParam, int indiceAlias);
    void setAliasName(int indiceAction, int indiceParam, int indiceAlias, QString name);
    void setAliasValue(int indiceAction, int indiceParam, int indiceAlias, QString value);
    void deleteAlias(int indiceAction, int indiceParam, int indiceAlias);

signals:

private:
    QList<Action *> listActions;
};

#endif // GESTIONACTIONS_H
