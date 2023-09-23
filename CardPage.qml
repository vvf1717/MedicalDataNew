import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

Item {
    ColumnLayout{
        id: collayout
        anchors.fill: parent
        spacing: 2

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 70

            RowLayout {
                id: rowlayout
                Layout.fillWidth: true
                anchors.fill: parent
                anchors.margins: 5
                spacing: 6

                Button {
                    id: saveButton
                    Layout.fillWidth: true
                    text: "Save"
                    onClicked: {
                        mymodel.setData(mymodel.index(curModelRow, 3),resDateField.text, 259 )
                        mymodel.setData(mymodel.index(curModelRow, 1),comboDoctor.currentText, 257 )
                        mymodel.setData(mymodel.index(curModelRow, 1),comboPatient.currentText, 258 )
                        mymodel.setData(mymodel.index(curModelRow, 9),ifcField.text, 260)
                        mymodel.setData(mymodel.index(curModelRow, 9),ageField.text, 261)
                        mymodel.setData(mymodel.index(curModelRow, 9),diagField.text, 262)
                        mymodel.setData(mymodel.index(curModelRow, 9),memoField.text, 263)
                        mymodel.setData(mymodel.index(curModelRow, 9),istbolField.text, 265 )

                        mymodel.submitAll()
                        curstack.push(tablePage)
                    }
                }
                Button {
                    id: cancelButton
                    Layout.fillWidth: true
                    text: "Cancel"
                    onClicked: {
                        curstack.push(tablePage)
                    }
                }
            }
        }
        Rectangle {

            Layout.fillWidth: true
            Layout.fillHeight: true

            GridLayout {

                Layout.fillWidth: true
                anchors.fill: parent

                anchors.margins: 5
                rowSpacing: 10
                columnSpacing: 10
                rows: 4
                columns: 2

                Text {
                    text: qsTr("№")
                    Layout.fillWidth: true
                }

                TextField {
                    id: recNoField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 0))
                }

                Text {
                    text: qsTr("res.date")
                    Layout.fillWidth: true
                }

                TextField {
                    id: resDateField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 3))
                }

                Text {
                    text: qsTr("Doctor")
                    Layout.fillWidth: true
                }

                ComboBox {
                    id: comboDoctor
                    Layout.fillWidth: true
                    editable: true

                    model: modelDoctors

                    Component.onCompleted: {
                        currentIndex = find(mymodel.data(mymodel.index(curModelRow, 1)), Qt.MatchExactly)
                    }

                }

                Text {
                    text: qsTr("Patient")
                    Layout.fillWidth: true
                }

                ComboBox {
                    id: comboPatient
                    Layout.fillWidth: true
                    editable: true
                    model: modelPatients
                    Component.onCompleted: {
                        currentIndex = find(mymodel.data(mymodel.index(curModelRow, 2)), Qt.MatchExactly)
                    }
                }

                Text {
                    text: qsTr("IFC")
                    Layout.fillWidth: true
                }

                TextField {
                    id: ifcField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 4))
                }

                Text {
                    text: qsTr("Age")
                    Layout.fillWidth: true
                }

                TextField {
                    id: ageField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 5))
                }

                Text {
                    text: qsTr("Diag.")
                    Layout.fillWidth: true
                }

                TextField {
                    id: diagField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 6))
                }

                Text {
                    text: qsTr("Memo")
                    Layout.fillWidth: true
                }

                TextField {
                    id: memoField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 7))
                }

                Text {
                    text: qsTr("Ist.bol")
                    Layout.fillWidth: true
                }

                TextField {
                    id: istbolField
                    Layout.fillWidth: true
                    text: mymodel==undefined ? "" : mymodel.data(mymodel.index(curModelRow, 9))
                }
            }
        }
    }
}
