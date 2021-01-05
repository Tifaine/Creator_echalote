#ifndef SEQUENCE_H
#define SEQUENCE_H
#include <QQuickItem>
#include "../GestionActions/gestionactions.h"


class Sequence : public QQuickItem
{
    Q_OBJECT
public:
    Sequence();

public slots:
    void init();
    int getNbAction();
    int getNbActionInSequence();
    QString getNomAction(int indiceAction);
    void addAction(int indiceAction);
    int getNbParamAction(int indiceAction);
    QString getNomParamAction(int indiceAction, int indiceParam);
    QString getDefaultValueParamAction(int indiceAction, int indiceParam);
    int getNbAliasParamAction(int indiceAction, int indiceParam);
    QString getNomAliasParamAction(int indiceAction, int indiceParam, int indiceAlias);
    QString getValueAliasParamAction(int indiceAction, int indiceParam, int indiceAlias);
    void setParamValue(int indiceAction, int indiceParam, QString value);

    void detailActions();
    void addFilleToAction(int indiceActionMere, int indiceActionFille);
    void addPereToAction(int indiceActionFille, int indiceActionPere);
    void addTimeoutToAction(int indiceActionMere, int indiceActionTimeout);

    void saveSequence(QString fileName);
    void updateAliasSequence();

private slots:
    void onFinInitActions();

signals:

private:
    GestionActions* gestActions;
    QList<Action *> listActionSequence;
};

#endif // SEQUENCE_H
