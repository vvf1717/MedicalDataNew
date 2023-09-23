#include "dbconnection.h"
//#include <QDebug>
#include <QIdentityProxyModel>

DbConnection::DbConnection(QObject *parent) : QObject(parent)
{
    dbPath = "C:/CPP/OTUS/T16/build-TestDBConnection-Desktop_Qt_5_12_12_MSVC2017_64bit-Debug/INTFETAL.sqlite";
}

void DbConnection::openDB()
{

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath);

    if( !db.open() ){
        curError =  db.lastError();
        return;
    }

    if (curError.type() == QSqlError::NoError)
    {
        model = new DataBaseModel();
        model->setTable("RESEARCH");
        model->setRelation(1, QSqlRelation("DOCTORS", "NAME", "NAME"));
        model->setRelation(2, QSqlRelation("PATIENTS", "NAME", "NAME"));

        if (!model->select()) {
            curError = model->lastError();
            return;
        }
    }
}

void DbConnection::setdbPath(const QString &newPath)
{
    dbPath = newPath;
}

QSqlError DbConnection::getcurError()
{
    return curError;
}

DataBaseModel *DbConnection::getModel()
{
    model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    return model;
}

QIdentityProxyModel* DbConnection::getModelCombo(int curCol)
{
    modelCombo = new QIdentityProxyModel(this);
    modelCombo->setSourceModel(model->relationModel(curCol));
    return modelCombo;
}
