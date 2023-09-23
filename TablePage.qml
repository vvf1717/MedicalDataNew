import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
//import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.0
import DbConnection 0.1
import DataBaseModel 0.1

Item {
    property int curModelIndex : curModelIndex

    FileDialog {
        id: fileDialog
        title: "Please choose a file of database";
        nameFilters: ["Image Files (*.sqlite)"];
        onAccepted: {

            var path = fileDialog.fileUrl.toString();

            if(Qt.platform.os == "windows"){
                // remove prefixed "file:///"
                path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
                // unescape html codes like '%23' for '#'
                dbCon.setdbPath(decodeURIComponent(path));
            }
            else
                dbCon.setdbPath(path);

            dbCon.openDB();

            mymodel = dbCon.getModel();
            modelDoctors = dbCon.getModelCombo(1);
            modelPatients = dbCon.getModelCombo(2);
            fileDialog.close()
        }
    }

    ColumnLayout{
        id: collayout
        anchors.top: parent.top
        anchors.fill: parent
        spacing: 2
        RowLayout {
            id: rowlayout
            Layout.fillWidth: true
            spacing: 6

            Button {
                id: openFileButton
                Layout.fillWidth: true
                text: "Connect DB"
                onClicked: fileDialog.open()
            }

            Button {
                id: addButton
                Layout.fillWidth: true
                text: "Add"
                onClicked: {

                    curModelRow = mymodel.rowCount()
                    mymodel.insertRow()
                    curstack.push(cardPage)
                }
            }
            Button {
                id: delButton
                Layout.fillWidth: true
                text: "Del"
                onClicked: {
                    mymodel.removeRow(curModelRow);
                    mymodel.submitAll()
                }
            }
        }

        Rectangle {
            id: main
            Layout.fillWidth: true
            color:"red"
            height:200
            property string alterBackground: "white"
            property string highlight: "#e4f7d6"
            TableView {
                id: view
                anchors.fill: parent
                clip: true
                frameVisible: true
                width: parent.width
                height: parent.height - 100

                model: mymodel

                //TableViewColumn{role: "REC_NO"; title: "№"; width: 50}
                TableViewColumn{role: "RES_DATE"; title: "res.date"; width: 70;  elideMode: Text.ElideRight;}
                TableViewColumn{role: "DOCTOR"; title: "Doctor"; width: 200;elideMode: Text.ElideRight;}
                TableViewColumn{role: "PATIENT"; title: "Patient"; width: 200;elideMode: Text.ElideRight;}
                //TableViewColumn{role: "IFC"; title: "IFC"; width: 80}
                //TableViewColumn{role: "AGE"; title: "Age"; width: 70}
                //TableViewColumn{role: "DIAG"; title: "Diag."; width: 70}
                //TableViewColumn{role: "MEMO"; title: "Memo"; width: 70}
                //TableViewColumn{role: "FHR_DATA"; title: "FHR Data"; width: 70}
                TableViewColumn{role: "IST_BOL"; title: "Ist.bol"; width: 60}

                headerDelegate: Rectangle {
                    implicitWidth: 10
                    implicitHeight: 24
                    border.width: 1
                    border.color: "gray"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                        anchors.right: parent.right
                        anchors.rightMargin: 4
                        text: styleData.value
                        color: styleData.pressed ? "red" : "blue"
                        font.bold: true
                    }
                }


                itemDelegate: Text {
                    text: styleData.value
                    color: styleData.selected ? "red" : styleData.textColor
                    elide: styleData.elideMode
                }

                // Set the background color of the row
                rowDelegate: Rectangle {
                    id: rowDelegate
                    color: styleData.selected ? main.highlight : main.alterBackground
                    readonly property int modelRow: styleData.row ? styleData.row : 0

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton | Qt.LeftButton

                        onClicked: {
                            view.selection.clear()
                            view.selection.select(styleData.row)
                            view.currentRow = styleData.row
                            view.focus = true
                            curModelRow = styleData.row
                            chartArray =  mymodel.getArray(curModelRow);
                            mycanvas.requestPaint();
                        }
                        onDoubleClicked: {
                            curstack.push(cardPage)
                        }
                    }
                }
            }
        }


        Rectangle {

            id: mychart
            Layout.fillWidth: true
            width:640
            height:200

            Canvas {
                id: mycanvas
                anchors.fill: parent

                onPaint: {
                    if (chartArray!== undefined)
                    {
                        function drawChart()
                        {
                            var x1=0,y1=0;
                            ctx.beginPath()
                            ctx.moveTo(0, 0);
                            for (var i = 0; i < chartArray.length; ++i){
                                if(i>0){
                                    y1 = chartArray[i]
                                    ctx.lineTo(x1*2.5, y1*0.5);
                                    ctx.moveTo(x1*2.5, y1*0.5);
                                    x1=i*2.5;
                                }else
                                    ctx.moveTo(i,  chartArray[i]*0.5);
                            }
                            ctx.closePath()
                        }
                        var ctx = getContext ("2d");
                        ctx.clearRect(0, 0, parent.width, parent.height)
                        ctx.save();
                        ctx.strokeStyle = "black"
                        ctx.lineWidth = 1
                        drawChart();
                        ctx.stroke ();
                        ctx.restore();
                    }
                }
            }
        }
    }
}
