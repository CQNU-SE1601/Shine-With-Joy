import QtQuick 2.0
import VPlayApps 1.0
NavigationStack{
    Page{
    title: "我的"
    AppImage {
      id: image
      anchors.fill: parent
      // important to automatically rotate the image taken from the camera
      autoTransform: true
      fillMode: Image.PreserveAspectFit
    }

    AppButton {
      anchors.centerIn: parent
      text: "拍照上传"
      onClicked: {
        nativeUtils.displayCameraPicker("test")
      }
    }
    Connections{
      target: nativeUtils
      onCameraPickerFinished: {//displayCamerPicker被调用，用户接受，则讲照片保存在path路径,否则保存空字符串
        if(accepted) image.source = path
      }
    }
    }
}
