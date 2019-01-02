import VPlayApps 1.0
import QtQuick.Controls 2.2 as Quick2
import QtQuick 2.0
import QtMultimedia 5.0
NavigationStack{
    Page {
        title: "关注"

        Quick2.SwipeView {
            id: swipeView
            width: parent.width
            height: parent.height
            orientation: "Vertical"
            Rectangle { color: "green"  }
            Rectangle { color: "red"  }
            Rectangle { color: "blue"  }
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
        loops: MediaPlayer.Infinite
        source: "/home/zhangzhe/Videos/dde-introduction.mp4"
        //          source: "rtsp://10.253.224.83/vedio/1.mkv"
    }
}
