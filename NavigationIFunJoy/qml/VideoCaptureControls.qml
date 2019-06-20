import QtQuick 2.0
import QtMultimedia 5.4
import QtQuick.Controls 2.0
import Felgo 3.0
FocusScope {//创建焦点区
    property Camera camera
    property bool previewAvailable : false

    property int buttonsPanelWidth: buttonPaneShadow.width

    signal previewSelected//当预览按钮被点击
    signal photoModeSelected
    id : captureControls

    Rectangle {
        id: buttonPaneShadow
        width:  parent.width - stillControls.buttonsPanelWidth
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right
        color: Qt.rgba(0.08, 0.08, 0.08, 1)

        Column {
            anchors {//锚点
                centerIn:parent;
                margins: 8
            }
            id: buttonsColumn
            spacing: 8
            Button{
                text: qsTr("录制")
                onPressed: {
                    //按下
                    console.log("按下")
                    camera.videoRecorder.record();
                }
                onReleased: {
                    //抬起
                    console.log("抬起")
                    camera.videoRecorder.stop();
                }
            }

            Button {
                text: "预览"
                onClicked: captureControls.previewSelected();
                //录制过程中隐藏按钮
                visible: true
            }
        }
    }
//    ZoomControl {
//        x : 0
//        y : 0
//        width : 100
//        height: parent.height

//        currentZoom: camera.digitalZoom
//        maximumZoom: Math.min(4.0, camera.maximumDigitalZoom)
//        onZoomTo: camera.setDigitalZoom(value)
//    }
}

