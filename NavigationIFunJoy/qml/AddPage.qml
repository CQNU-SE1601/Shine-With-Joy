import QtQuick 2.9
import Felgo 3.0
import QtMultimedia 5.9
NavigationStack{
    property int initTime:1
    property bool timerVisible:false
    property alias cameraAvailablity:camera.cameraState
    anchors.fill: parent;
    id:stck;
    Page {
        navigationBarHidden: true
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
                            QtMultimedia.availableCameras
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
            //计时器
            Timer{
                id:timer;
                interval: 1000
                repeat: true;
                triggeredOnStart: true
                onTriggered: {
                    textTimer.text = initTime+" s"
                    initTime++;
                }

            }
            Camera {
                id: camera
                captureMode: Camera.CaptureVideos
                digitalZoom: pinch.scale
                videoRecorder {//视频记录
                    id:videoRecorder
                    resolution: "640x480"
                    frameRate: 30
                    onRecorderStateChanged: {
                        console.log("4.++++++++"+videoRecorder.recorderState)
                        if(videoRecorder.rcorderState === 0){
                            console.log("相机不在录制中")
                            cameraUI.state = "VideoPreview"
                        }
                    }
                }
            }
            //视频预览
            VideoPreview {
                id : videoPreview
                anchors.fill : parent
                onClosed: cameraUI.state = "VideoCapture"
                //                visible: cameraUI.state == "VideoPreview"
                visible: !(cameraUI.state == "VideoCapture")
                //如果视频预览不可用就不用加载preview
                source: visible ? camera.videoRecorder.actualLocation : ""
            }
            //显示视频
            VideoOutput {
                id: viewfinder
                visible:cameraUI.state == "VideoCapture"
                anchors.fill: parent
                source: camera
                autoOrientation: true
//                PinchHandler{//双指捏合
//                    id:pinch
//                    target: null
//                }

                MouseArea{//自动对焦
                    id:maFocus
                    anchors.fill: parent;
                    onClicked: {
                        camera.searchAndLock();
                        imageFocus.x = mouse.x-imageFocus.width/2
                        imageFocus.y = mouse.y-imageFocus.height/2
                        imageFocus.visible = !imageFocus.visible
                        animation.start()
                    }
                }
                Image {
                    id: imageFocus
                    source: "../assets/icon/circle.png"
                    visible: false
                    NumberAnimation on scale {
                        id:animation
                        from:dp(1);to:dp(0.8)
                    }
                }
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: dp(20)
                    id:textTimer
                    color: Theme.colors.tintColor
                    font.pixelSize: dp(20)
                    visible: timerVisible
                    z:2
                    anchors.centerIn: parent;
                }
                ImageButton{//切换摄像头
                    property bool isBackCamera:true
                    anchors.right: parent.right
                    anchors.rightMargin: dp(20)
                    anchors.top: parent.top
                    anchors.topMargin: dp(20)
                    id:btnSwitch
                    imageBackground: "../assets/icon/switch.png"
                    onBtnClicked: {
                        console.log("点击")
                        if(isBackCamera){
                            camera.deviceId = QtMultimedia.availableCameras[1].deviceId
                            isBackCamera = false
                        }else{
                            camera.deviceId = QtMultimedia.availableCameras[0].deviceId
                            isBackCamera = true
                        }
                    }
                }
                ImageButton{//录制
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: dp(20)
                    visible: cameraUI.state == "VideoCapture"
                    imageBackground: "../assets/icon/record.png"
                    id:recorderButtton
                    onBtnPressAndHold: {
                        timerVisible = !timerVisible
                        initTime = 1
                        camera.videoRecorder.record();
                        timer.start();
                    }
                    onBtnReselesed: {
                        timerVisible = !timerVisible
                        camera.videoRecorder.stop();
                        timer.stop()
                    }
                }
                ImageButton{//预览按钮
                    anchors.right: parent.right
                    anchors.rightMargin: dp(20)
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: dp(20)
                    id:btnPreview
                    imageBackground: "../assets/icon/next.png"
                    visible: !(camera.videoRecorder.actualLocation == "") && (cameraUI.state == "VideoCapture")
                    onBtnClicked: {
                        cameraUI.state = "VideoPreview"
                    }
                }
            }
            ZoomControl{
                anchors.left: parent.left
                anchors.leftMargin: dp(10)
                z:3
                width: dp(10)
                height: parent.height
                currentZoom: camera.digitalZoom
                maximumZoom: Math.min(4.0,camera.maximumDigitalZoom)
                onZoomTo: camera.setDigitalZoom(value)
            }

        }
    }
}
