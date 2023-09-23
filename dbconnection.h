#ifndef DBCONNECTION_H
#define DBCONNECTION_H

#include <QObject>

#include <QtSql>
#include <QSqlDatabase>
#include <QSqlRelationalDelegate>
#include <QSqlRelation>
#include <QIdentityProxyModel>
#include "databasemodel.h"

class DbConnection : public QObject
{
    Q_OBJECT

public:

    explicit DbConnection(QObject *parent = nullptr);

    QSqlDatabase db;
    DataBaseModel* model;
    QIdentityProxyModel* modelCombo;

    Q_INVOKABLE void openDB();
    Q_INVOKABLE void setdbPath(const QString &newPath);
    Q_INVOKABLE DataBaseModel *getModel();
    Q_INVOKABLE QIdentityProxyModel* getModelCombo(int curCol);

    QSqlError getcurError();

private:

    QSqlError curError;
    QString dbPath;
};

#endif // DBCONNECTION_H
