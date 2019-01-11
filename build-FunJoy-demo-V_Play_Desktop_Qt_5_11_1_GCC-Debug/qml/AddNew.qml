import QtQuick 2.0
import VPlayApps 1.0
import VPlayPlugins 1.0
//import uploadAndDownload 1.0
import QtMultimedia 5.9
Item {
    anchors.fill: parent
    NavigationStack{
        property string url: "192.168.1.1"  //服务器IP
        property int port:21    //服务器端口
        property string usreName:"zhang"    //登录服务器的用户名
        property string userPassword:"123456"   //登录服务的密码
        property bool isCameraAvailable:QtMultimedia.availableCameras.length>0  //相机权限是否可用
//            property string videoStoreLocation:camera.outputLocation  //用于保存录制后的视频位置
//        UploadAndDownload{
//            id:uploaddownload
//        }
        AppButton{
            z:3
            text: "上传指定视频"
            onClicked: {
                uploaddownload.setUserInfo("zhangzhe","123456")
                //            uploaddownload.setHostPort()
            }
        }

        Page{
            title: "发布"
            VideoOutput {
                source: camera
                anchors.fill: parent
                focus : visible
                autoOrientation: true   //跟随屏幕
                Camera {
                    id: camera
                    captureMode: Camera.CaptureVideo//使相机可以捕获视频
                    imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash//白平衡
                    exposure{//曝光
                        exposureCompensation: -1.0
                        exposureMode: Camera.ExposurePortrait
                    }
                    flash.mode:Camera.FlashAuto//闪光模式
                    position: Camera.BackFace//后置摄像头可用，移动设备通常是后置摄像头

                    videoRecorder{
                        id:videorecorder
                        audioCodec: "acc" //录制视频的音频解码器
                        //                    outputLocation: "/home/zhangzhe/Pictures/3"
//                        outputLocation: "/UCDownloads/4"
                        audioBitRate: 128000  //录制的比特率
                        mediaContainer: "mp4" //录制视频的容器，通常是mp4
                        audioEncodingMode: CameraRecorder.ConstantQualityEncoding //录制视频编码方式
                        onRecorderStateChanged: {//只有录制中1和非录制两种状态0
                            if(recorderState == CameraRecorder.StoppedState)
                                console.log("录制位置源----"+actualLocation)
                        }
                    }
                }
                Row{
                    z:2
                    anchors.centerIn: parent
                    AppButton{
                        text: "开始"
                        onClicked: {
                            camera.start();//打开相机
                            camera.videoRecorder.record() //开始录制
                            nativeUtils.vibrate()
                        }
                    }
                    AppButton{
                        text: "停止"
                        onClicked: {
                            camera.videoRecorder.stop() //停止
                            camera.stop()
                            nativeUtils.vibrate()
                        }
                    }
                }
                Rectangle{
                    color: "red"
                    width: 200
                    height: 200
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.Center
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("相机是否录制-----"+camera.videoRecorder.recorderStatus)
                            console.log("相机是否在录制中--------"+camera.videoRecorder.recorderState)
                            console.log("打印errorCode---------"+camera.videoRecorder.errorCode)
                        }
                    }
                }
            }
        }
    }
}

