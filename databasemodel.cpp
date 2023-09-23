#include "databasemodel.h"
#include <QDebug>

DataBaseModel::DataBaseModel(QSqlRelationalTableModel *parent, QSqlDatabase db) : QSqlRelationalTableModel(parent)
{

}

QHash<int, QByteArray> DataBaseModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[Qt::UserRole] = "REC_NO";
    names[Qt::UserRole + 1] = "DOCTOR";
    names[Qt::UserRole + 2] = "PATIENT";
    names[Qt::UserRole + 3] = "RES_DATE";
    names[Qt::UserRole + 4] = "IFC";
    names[Qt::UserRole + 5] = "AGE";
    names[Qt::UserRole + 6] = "DIAG";
    names[Qt::UserRole + 7] = "MEMO";
    names[Qt::UserRole + 8] = "FHR_DATA";
    names[Qt::UserRole + 9] = "IST_BOL";
    return names;
}

QVariant DataBaseModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlRelationalTableModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlRelationalTableModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole/* - 1*/;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlRelationalTableModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

bool DataBaseModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool isDone = false;
    int columnIdx = role - Qt::UserRole/* - 1*/;
    QModelIndex modelIndex = this->index(index.row(), columnIdx);
    isDone = QSqlRelationalTableModel::setData(modelIndex,value,Qt::EditRole);
    return isDone;
}

bool DataBaseModel::removeRow(int row, const QModelIndex &parent)
{
    bool isDone = false;
    isDone = QSqlRelationalTableModel::removeRow(row,parent);
    return isDone;
}

bool DataBaseModel::insertRow()
{
    bool isDone = false;
    isDone = QSqlRelationalTableModel::insertRow(this->rowCount());
    return isDone;
}

QVariantList DataBaseModel::getArray(int row)
{
    QByteArray arr = this->data(this->index(row, 8), Qt::DisplayRole).toByteArray();
    QVariantList res_arr;
        for (int i = 0; i < arr.size(); ++i) {
            res_arr.push_back(static_cast<int>((unsigned char)arr.at(i)));
        }
    return res_arr;
}
