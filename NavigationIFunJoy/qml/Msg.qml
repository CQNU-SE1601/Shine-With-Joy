import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Window {
    id: eo_askDialog
    width: 500
    height: 400
    property string title: "评论区"
    property string content: "暂无评论,还不快抢沙发"
    property string yesButtonString: "发送"
    property string noButtonString: "取消"
    property string checkBoxString: "说点好听的~"
    property string titleBackgroundImage: ""
    property string contentBackgroundImage: ""
    property string buttonBarBackgroundImage: ""
    property bool checked: false
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowStaysOnTopHint

    modality: Qt.ApplicationModal

    signal accept
    signal reject
    signal checkAndAccept

    ColumnLayout {
        anchors.fill: parent

        spacing: 2

        //标题栏
        Rectangle {
            id: titleBar
            Layout.fillWidth: parent
            implicitHeight: 30
            color: "darkgray"
            //1.实现标题栏
            RowLayout {
                anchors.fill: parent
                spacing: 2

                MouseArea {
                    id: mouseControler

                    property point clickPos: "0,0"

                    Layout.fillHeight: parent
                    Layout.fillWidth: parent

                    //title
                    Text {
                        text: title
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    onPressed: {
                        clickPos = Qt.point(mouse.x, mouse.y)
                    }

                    onPositionChanged: {
                        //鼠标偏移量motai
                        var delta = Qt.point(mouse.x - clickPos.x,
                                             mouse.y - clickPos.y)
                        //如果mainwindow继承自QWidget,用setPos
                        eo_askDialog.setX(eo_askDialog.x + delta.x)
                        eo_askDialog.setY(eo_askDialog.y + delta.y)
                    }
                }

                //close button
                MouseArea {
                    id: closeButton
                    Layout.fillHeight: parent
                    implicitWidth: 45

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                    }

                    onClicked: {

                        //console.log("close button clicked.")
                        eo_askDialog.visible = false
                        reject()
                    }
                }
            }
        }

        //内容框
        Rectangle {
            id: contentView
            Layout.fillWidth: parent
            Layout.fillHeight: parent
            color: "lightgray"
            Text {
                text: content
                anchors.centerIn: parent
            }
        }

        //按钮栏
        Rectangle {
            id: buttonBar
            Layout.fillWidth: parent
            implicitHeight: 30
            color: "darkgray"
            RowLayout {
                anchors.fill: parent
                spacing: 2

                //checkBox
                MouseArea {
                    id: checkBox
                    Layout.fillHeight: parent
                    width: 100

                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                    }

                    Text {
                        text: checkBoxString
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        //checked = checked == false
                        console.log("输入评论")
                    }
                }

                //h spacer
                Rectangle {
                    id: buttonBarSpacer
                    color: Qt.rgba(0, 0, 0, 0)
                    Layout.fillWidth: parent
                }

                //yes button
                MouseArea {
                    id: yesButton
                    Layout.fillHeight: parent
                    width: 75

                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                    }

                    Text {
                        text: yesButtonString
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        console.log("发送成功")
                        eo_askDialog.visible = false

                        if (checked) {
                            checkAndAccept()
                        } else {
                            accept()
                        }
                    }
                }

                //no button
                MouseArea {
                    id: noButton
                    Layout.fillHeight: parent
                    width: 75

                    Rectangle {
                        anchors.fill: parent
                        color: "lightgray"
                    }

                    Text {
                        text: noButtonString
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        //console.log("no button clicked.")
                        eo_askDialog.visible = false

                        reject()
                    }
                }
            }
        }
    }
}
