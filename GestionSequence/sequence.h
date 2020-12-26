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
    Action* getActionAt(int indiceAction);

private slots:
    void onFinInitActions();

signals:

private:
    GestionActions* gestActions;
    QList<Action *> listActionSequence;
};

#endif // SEQUENCE_H
