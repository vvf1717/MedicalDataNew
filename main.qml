import QtQuick 2.12
import QtQml 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import DbConnection 0.1


ApplicationWindow {
    width: 640
    height: 400
    visible: true
    title: qsTr("Medical data")

    DbConnection{
        id: dbCon
    }

    property var mymodel: ({})
    property var curModelRow: ({})
    property var modelDoctors: ({})
    property var modelPatients: ({})
    property var chartArray;

    StackView{
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
        id: curstack
        initialItem: tablePage
    }

    Component {
        id: tablePage
        TablePage {}
    }
    Component {
        id: cardPage
        CardPage {}

    }
}
