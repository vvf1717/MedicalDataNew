#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "dbconnection.h"
#include "databasemodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    qmlRegisterType<DbConnection>("DbConnection", 0, 1, "DbConnection");
    qmlRegisterType<DataBaseModel>("DataBaseModel", 0, 1, "DataBaseModel");
    qmlRegisterType<QIdentityProxyModel>("QIdentityProxyModel", 0, 1, "QIdentityProxyModel");

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    app.setOrganizationName("MyCompany");
    app.setOrganizationDomain("MyCompany.com");
    return app.exec();
}
