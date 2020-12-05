#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QQmlContext>
#include <QtCore/QDir>
#include <QFontDatabase>
#include "GestionActions/gestionactions.h"
#include "GestionSequence/sequence.h"

void initRep();

int main(int argc, char *argv[])
{
    //We use charts so we must use QApplication.
    QApplication app(argc, argv);
    app.setOrganizationName("RCO");
    app.setOrganizationDomain("RCO");

    initRep();

    GestionActions gestAction;
    GestionActions gestActionSequence;

    // The following are needed to make examples run without having to install the module
    // in desktop environments.

    QQuickView viewer;
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
    QFontDatabase::addApplicationFont("data/icomoon/fonts/icomoon.ttf");

    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                                       QString::fromLatin1("qml")));
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.engine()->rootContext()->setContextProperty("gestActions", &gestAction);
    viewer.engine()->rootContext()->setContextProperty("gestActionsSequence", &gestActionSequence);

    viewer.setTitle(QStringLiteral("Creator Echalote"));
#ifdef Q_OS_LINUX
    viewer.engine()->rootContext()->setContextProperty("fileRoot", "file://");

#elif defined(Q_OS_WIN)
    viewer.engine()->rootContext()->setContextProperty("fileRoot", "file:///");

#endif
    viewer.engine()->rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());
    //viewer.engine()->rootContext()->setContextProperty("icomoon", font);


    qmlRegisterType<Sequence>("sequence",1, 0,"SequenceCPP");

    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.show();

    return app.exec();
}

//Add a function to initialize all repository we will have to use.
void initRep()
{
    if( ! QDir("data").exists())
    {
        QDir().mkdir("data");
        QDir().mkdir("data/Dyna");
        QDir().mkdir("data/Etape");
        QDir().mkdir("data/Sequence");
        QDir().mkdir("data/Actions");
        QDir().mkdir("data/Strategie");
    }else
    {
        if( ! QDir("data/Dyna").exists())
        {
            QDir().mkdir("data/Dyna");
        }
        if( ! QDir("data/Etape").exists())
        {
            QDir().mkdir("data/Etape");
        }
        if( ! QDir("data/Sequence").exists())
        {
            QDir().mkdir("data/Sequence");
        }
        if( ! QDir("data/Actions").exists())
        {
            QDir().mkdir("data/Actions");
        }
        if( ! QDir("data/Strategie").exists())
        {
            QDir().mkdir("data/Strategie");
        }
    }
}
