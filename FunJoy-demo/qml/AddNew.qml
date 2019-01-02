import QtQuick 2.0
import VPlayApps 1.0
import VPlayPlugins 1.0
//import uploadAndDownload 1.0
import QtMultimedia 5.9
NavigationStack{
    property string url: "192.168.1.1"  //服务器IP
    property int port:21    //服务器端口
    property string usreName:"zhang"    //登录服务器的用户名
    property string userPassword:"123456"   //登录服务的密码
//    UploadAndDownload{
//        id:uploaddownload
//    }

    Page{
        title: "发布"
        AppButton {
            text: "拍摄并上传"
            anchors.centerIn: parent
            onClicked:{
//                uploaddownload.setHostPort(url,port);
                camera.start();//打开相机
            }
        }
    }
    Camera {
        id: camera
        cameraState: Camera.UnloadedState
        captureMode: Camera.CaptureVideo//使相机可以捕获视频
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        position: Camera.BackFace//设置其为后置摄像
        exposure {//曝光
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }
        flash.mode:Camera.FlashAuto//闪光模式

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview  // Show the preview in an Image
            }
        }
    }
    VideoOutput {
        source: camera
        anchors.fill: parent
        focus : visible
        autoOrientation: true   //跟随屏幕
    }

    AppImage {
        id: photoPreview
        autoTransform:true//自动调整
    }
}

