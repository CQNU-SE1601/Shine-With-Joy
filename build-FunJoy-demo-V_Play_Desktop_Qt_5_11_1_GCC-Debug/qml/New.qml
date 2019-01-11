import VPlayApps 1.0
import QtQuick 2.1
import recordervideo 1.0
Item {
    anchors.fill: parent
    RecorderVideo{
        id:recorder
    }
    NavigationStack {
        id:stack
        splitView: tablet
        initialPage: mainPage
    }
    property Component mainPage: ListPage {
        title: "发布我的作品"
        model: [
            { text: "开始录制", icon: IconType.camera, group: "选项" },
            { text: "本地文件", icon: IconType.file, group: "选项" },
        ]
        section.property: "group"
        onItemSelected: {
            if(index == 0){
                navigationStack.popAllExceptFirstAndPush(recorderPage)
                recorder.openCamera();
            }
            else{
                navigationStack.popAllExceptFirstAndPush(locateFilePage)

            }
        }
    }
    property Component recorderPage: Page {
        title: "录制"
        id:recorderPage
        anchors.fill: parent
        AppButton{
            borderColor: "black"
            radius: 50
            icon: IconType.play
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom
            onClicked: {
                if(recorder.recoderState() === 0)
                {
                    icon = IconType.stop
                    recorder.startRecord()
                    nativeUtils.vibrate()
                }
                else if(recorder.recoderState() === 1)
                {
                    icon = IconType.play
                    recorder.stopRecord()
                    //                    console.log(recorder.currentLocation())
                    console.log("a")
                    nativeUtils.vibrate()
                }
            }
        }
        AppButton{
            anchors.centerIn: parent
            onClicked: {
                console.log("是否录制中---------"+recorder.recoderState());
            }
        }
    }
    property Component locateFilePage: Page {
        title: "选择"
        id:locateFilePage
    }
}
