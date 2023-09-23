#ifndef DATABASEMODEL_H
#define DATABASEMODEL_H

#include <qsqldatabase.h>
#include <QSqlRelationalTableModel>

class DataBaseModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit DataBaseModel(QSqlRelationalTableModel *parent = nullptr, QSqlDatabase db=QSqlDatabase());
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;

    bool setData(const QModelIndex &index, const QVariant &value, int role) Q_DECL_OVERRIDE;

    Q_INVOKABLE bool removeRow(int row, const QModelIndex& parent = QModelIndex());
    Q_INVOKABLE bool insertRow();
    Q_INVOKABLE QVariantList getArray(int row);

};

#endif // DATABASEMODEL_H
