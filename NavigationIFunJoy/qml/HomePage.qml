import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import Felgo 3.0

NavigationStack {
    anchors.fill: parent
    Page {
        id: pageHome
        title: "主页"
        visible: true
        navigationBarHidden: true
        anchors.fill: parent
        Rectangle {
            id: page1
            anchors.fill: parent

            ListView {
                id: listView
                anchors.fill: parent
                currentIndex: 0
                cacheBuffer: 2
                snapMode: ListView.SnapOneItem //单张切换
                highlightRangeMode: ListView.StrictlyEnforceRange //currentIndex跟着变化
                orientation: ListView.Vertical
                footer: Rectangle {
                    width: listView.width
                    height: listView.height / 3
                    color: "white"
                    Text {
                        anchors.centerIn: parent
                        text: "song shou shua xin"
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
                            //anchors.bottomMargin: dp(20)
                            width: pageHome.width
                            height: dp(10)
                            maximumValue: player.duration
                            minimumValue: 0
                            value: player.position
                            stepSize: 1000
                            style: SliderStyle {
                                groove: Rectangle {
                                    width: pageHome.width
                                    height: 8
                                    color: "gray"
                                    radius: 2
                                    Rectangle {
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        width: player.duration > 0 ? parent.width * player.position
                                                                     / player.duration : 0
                                        color: Theme.colors.tintColor
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
                                        color: Theme.colors.tintColor
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            //点击鼠标设置播放位置
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed: {
                                player.pause()
                                switchs.status = 0
                                switchs.visible = true
                                switchs.imageBackground = "../assets/icon/play.png"
                            }
                        }
                        ImageButton {
                            id: switchs
                            anchors.centerIn: parent
                            width: dp(30)
                            height: dp(30)
                            visible: true
                            property bool status: true //默认播放
                            imageBackground: "../assets/2.jpg"
                            onBtnClicked: {
                                if (status) {
                                    player.pause()
                                    console.log("start")
                                    status = 0
                                    imageBackground = "../assets/icon/play.png"
                                } else {
                                    player.play()
                                    console.log("pause")
                                    status = 1
                                    visible = false
                                    imageBackground = "../assets/icon/pause.png"
                                }
                            }
                        }
                    }
                }
                onCurrentIndexChanged: {
                    //                    videoModel.get(listView.currentIndex - 1).//                    if (listView.currentIndex == videoModel.count-1)
                    //                        videoModel.append()
                    console.log("changed")
                }
                ListModel {
                    id: videoModel
                    ListElement {
                        path: "file:/root/videolists/ab.mp4"
                    }
                    ListElement {
                        path: "file:/root/videolists/abc.mp4"
                    }
                    ListElement {
                        path: "file:/root/videolists/a.mp4"
                    }
                    ListElement {
                        path: "file:/root/videolists/abc.mp4"
                    }
                }

                Column {
                    anchors.right: parent.right
                    anchors.rightMargin: dp(1)
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: dp(15)
                    ImageButton {
                        id: dian
                        property bool isLiked: false
                        width: dp(50)
                        height: dp(35)
                        imageBackground: "../assets/icon/d.png"
                        onBtnClicked: {
                            imageBackground
                                    = isLiked ? "../assets/icon/d.png" : "../assets/icon/l.png"
                            isLiked = !isLiked
                        }
                    }
                    Msg {
                        id: modelwnd
                    }

                    ImageButton {
                        width: dp(50)
                        height: dp(35)
                        imageBackground: "../assets/icon/p.png"
                        onBtnClicked: {
                            modelwnd.show()
                        }
                    }
                    ImageButton {
                        width: dp(50)
                        height: dp(35)
                        imageBackground: "../assets/icon/z.png"
                        onBtnClicked: nativeUtils.share("Sharing is caring!",
                                                        "https://www.felgo.com")
                    }
                }
            }
        }
    }
}
