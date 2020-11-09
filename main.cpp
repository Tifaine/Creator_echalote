#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    //We use charts so we must use QApplication.
    QApplication app(argc, argv);
    app.setOrganizationName("RCO");
    app.setOrganizationDomain("RCO");
    // The following are needed to make examples run without having to install the module
    // in desktop environments.

    QQuickView viewer;
    QString extraImportPath(QStringLiteral("%1/../../../%2"));

    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                                       QString::fromLatin1("qml")));
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("Creator Echalote"));
#ifdef Q_OS_LINUX
    viewer.engine()->rootContext()->setContextProperty("fileRoot", "file://");

#elif defined(Q_OS_WIN)
    viewer.engine()->rootContext()->setContextProperty("fileRoot", "file:///");

#endif
    viewer.engine()->rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.show();

    return app.exec();
}
