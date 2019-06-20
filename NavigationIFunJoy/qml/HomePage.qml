import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import Felgo 3.0
NavigationStack{
    anchors.fill: parent
    property MediaPlayer mediaPlayer:mediaplayer
    Page{
        id:pageHome
        title: "主页"
        visible: true
        navigationBarHidden: true
        anchors.fill: parent
        ListView {
            id: listView
            anchors.fill: parent
            currentIndex: 0
            cacheBuffer: 2
            snapMode: ListView.SnapOneItem //单张切换
            highlightRangeMode: ListView.StrictlyEnforceRange //currentIndex跟着变化
            orientation: ListView.Vertical
            header: Rectangle {
                width: listView.width
                height: listView.height / 3
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "上拉刷新"
                }
            }
            footer: Rectangle {
                width: listView.width
                height: listView.height / 3
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: "已经到底了"
                }
            }
            model: videoModel
            delegate: Rectangle {
                width: listView.width
                height: listView.height
                VideoOutput {
                    z: 2
                    anchors.fill: parent
                    source: MediaPlayer {
                        id: player
                        autoPlay: autoPlay
                        source: path
                    }
                    Slider {
                        id: playPos
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: dp(20)
                        width: kPlayer.width
                        height: 10
                        maximumValue: player.duration
                        minimumValue: 0
                        value: player.position
                        stepSize: 1000
                        style: SliderStyle {
                            groove: Rectangle {
                                width: kPlayer.width * 0.8
                                height: 8
                                color: "gray"
                                radius: 2
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: player.duration > 0 ? parent.width * player.position
                                                                 / player.duration : 0
                                    color: "blue"
                                }
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "darkgray"
                                border.color: "gray"
                                border.width: 2
                                implicitWidth: 15
                                implicitHeight: 15
                                radius: 7.5
                                Rectangle {
                                    width: parent.width - 8
                                    height: width
                                    radius: width / 2
                                    color: "blue"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        //点击鼠标设置播放位置
                        MouseArea {
                            property int pos
                            anchors.fill: parent
                            onClicked: {
                                if (player.seekable)
                                    pos = player.duration * mouse.x / parent.width
                                player.seek(pos)
                                playPos.value = pos
                            }
                        }
                    }
                    ImageButton {
                        x: 10
                        y: 10
                        width: 30
                        height: 30
                        property bool status:true//默认播放
                        imageBackground: "../assets/icon/pause.png"
                        onBtnClicked: {
                            if (status) {
                                player.pause()
                                console.log("start")
                                status = 0
                                iconImage = "../assets/icon/play.png"
                            } else {
                                player.play()
                                console.log("pause")
                                status = 1
                                iconImage = "../assets/icon/pause.png"
                            }
                        }
                    }
                }
            }
        }
        ListModel {
            id: videoModel
            ListElement {
                path: "rtsp://10.253.197.198/video/1.mkv"
            }
            ListElement {
                path: "file:/root/videolists/a.mp4"
            }
            ListElement {
                path: "file:/root/videolists/abc.mp4"
            }
        }
        Column {
            anchors.right: pageHome.right
            anchors.rightMargin: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            ImageButton {
                id: dian
                property bool isLiked:false
                width: 80
                height: 50
                imageBackground: "../assets/icon/d.png"
                state: "BORING"
                onBtnClicked: {
                    imageBackground = isLiked?"../assets/icon/d.png":"../assets/icon/l.png"
                    isLiked = !isLiked
                }
            }
            ImageButton {
                width: 80
                height: 50
                imageBackground:"../assets/icon/p.png"
            }
            ImageButton {
                width: 80
                height: 50
                imageBackground: "../assets/icon/z.png"
            }
        }
    }
}


