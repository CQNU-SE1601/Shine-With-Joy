import VPlayApps 1.0
import QtQuick.Controls 2.2 as Quick2
import QtQuick 2.0
import QtMultimedia 5.0
NavigationStack{
    property int sourcePath: 1
    Page {
        Rectangle{
            color: "red"
            width: 200
            height: 200
            z:2
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.Center
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("滑动到了--------"+swipeView.currentIndex)
                }
            }
        }
        title: "关注"
        Quick2.SwipeView {
            id: swipeView
            width: parent.width
            height: parent.height
            orientation: "Vertical"
            Rectangle { color: "green"  }
            Rectangle { color: "black"
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        mediaplayer.pause()
                        pauseAndPlayButton.visible = true
                    }
                }
                VideoOutput {
                    anchors.fill: parent
                    source: mediaplayer
                }
                AppButton{
                    id:pauseAndPlayButton
                    icon: IconType.play
                    anchors.centerIn: parent
                    visible: mediaplayer.status
                    onClicked: {
                        visible = false
                        mediaplayer.play()
                    }
                }
            }
        }
    }
    MediaPlayer {
        id: mediaplayer
        autoPlay: false
        source: "/home/zhangzhe/Videos/"+sourcePath+".mp4"

    }
}
