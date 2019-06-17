import QtQuick 2.9
import Felgo 3.0
import QtQuick.Controls 2.2
import QtMultimedia 5.12
NavigationStack{
    anchors.fill: parent;
    id:stck;
    Page {
        title: qsTr("发布")
        anchors.fill: parent;
        Rectangle {
            id : cameraUI
            anchors.fill: parent
            color: "white"
            state: "VideoCapture"
            states: [
                State {//视频捕获
                    name: "VideoCapture"
                    StateChangeScript {
                        script: {
                            camera.captureMode = Camera.CaptureVideo
                            camera.start()  //打开相机
                        }
                    }
                },
                State {//视频预览
                    name: "VideoPreview"
                    StateChangeScript {
                        script: {
                            camera.stop()   //关闭相机
                        }
                    }
                }
            ]
            Camera {
                id: camera
                captureMode: Camera.CaptureStillImage
                videoRecorder {//视频记录
                    id:videoRecorder
                    resolution: "640x480"
                    frameRate: 30
                }
            }
            VideoPreview {
                id : videoPreview
                anchors.fill : parent
                onClosed: cameraUI.state = "VideoCapture"
                visible: cameraUI.state == "VideoPreview"
                focus: visible
                //如果视频预览不可用就不用加载preview
                source: visible ? camera.videoRecorder.actualLocation : ""
            }
            VideoOutput {
                id: viewfinder
                visible:cameraUI.state == "VideoCapture"
                width: parent.width
                height: parent.height
                source: camera
                autoOrientation: true
            }
            Column {
                anchors {//锚点
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    margins: 8
                }
                Row{
                id: buttonsColumn
                spacing: 8
                RoundButton{
                    text: qsTr("录制")
                    onPressed: {
                        //按下
                        console.log("按下")
                        nativeUtils.vibrate()
                        camera.videoRecorder.record();//开始录制
                    }
                    onReleased: {
                        //抬起
                        console.log("抬起")
                        nativeUtils.vibrate()
                        camera.videoRecorder.stop();//停止录制
                    }
                }
                AppButton{
                    text: qsTr("打开摄像头")
                    onClicked: {
                        camera.start();
                    }
                }
                AppButton{
                    text:qsTr("关闭摄像头")
                    onClicked: {
                        camera.stop();
                    }
                }
                RoundButton {
                    text: "预览"
                    onClicked: cameraUI.state == "VideoPreview"
                    //录制过程中隐藏按钮
                    visible: true
                }
                }
            }
            AppText{
                id:at_tips
                text: "长按录制"
            }
        }
    }

    Component{
        id:pagePreView
        Page{

        }
    }
}
