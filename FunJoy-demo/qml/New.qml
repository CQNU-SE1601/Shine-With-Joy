import QtQuick 2.0
import VPlayApps 1.0
import recordervideo 1.0
NavigationStack{
    id:addNewStack
    RecorderVideo{
        id:recordervider;
    }

    Page{
        title: "发布"

    }
    Column{
        width: 234
        height: 26
        anchors.centerIn: parent
    AppButton {
        id: button_recoderVideoButton
        text: "录制视频"
        onClicked: {
            recordervider.startRecord();
            console.log("录制视频按钮被点击")
        }

    }

    AppButton {
        id: button_fromLocaly
        text:"上传本地"
    }}

}
/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
