import QtQuick 2.0
import QtMultimedia 5.10
import QtQuick.Controls 2.2
import Felgo 3.0
Item {
    id: videoPreview
    property alias source : player.source
    signal closed
    MediaPlayer {
        id: player
        autoPlay: true
        loops: MediaPlayer.Infinite
        //        onStatusChanged: {
        //            if (status == MediaPlayer.EndOfMedia)
        //                videoPreview.closed();
        //        }
    }
    VideoOutput {
        source: player
        anchors.fill : parent
        AppSlider{
            anchors.bottom: sureButton.top
            anchors.bottomMargin: dp(30)
            width: parent.width
            id:slider
            from: 0
            to:player.duration
            value: player.position
            onMoved: {
                if(player.seekable)
                    player.seek(position)
                else{
                    console.log("无法拖动")
                }
            }
        }
        ImageButton{//确认
            id:sureButton
            anchors.left: parent.left
            anchors.leftMargin: dp(20)
            anchors.bottom: parent.bottom
            anchors.bottomMargin:dp(20)
            imageBackground: "../assets/icon/ok.png"
            onBtnClicked: {

            }
        }
        ImageButton{//取消
            anchors.right: parent.right
            anchors.rightMargin: dp(20)
            anchors.bottom: parent.bottom
            anchors.bottomMargin:dp(20)
            imageBackground: "../assets/icon/cancel.png"
            onBtnClicked: {
                videoPreview.closed();
            }
        }
    }
}
