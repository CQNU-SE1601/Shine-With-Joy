import QtQuick 2.0
import VPlayApps 1.0
import QtMultimedia 5.9
import QtQuick.Controls 2.2 as Quick2
Item {
    anchors.fill: parent
    property bool bMenuShown:false //侧边栏
    NavigationStack{

        property int sourcePath: 1
        Page{
            leftBarItem: IconButtonBarItem {
                icon: IconType.search //设置
                onClicked:{
                    onSearchMenu()
                }
            }

            id:page1
            title: "主页"
            visible: true
            ListView{
                id:listView
                anchors.fill: parent
                currentIndex: 0
                cacheBuffer: 2
                snapMode: ListView.SnapOneItem  //单张切换
                highlightRangeMode: ListView.StrictlyEnforceRange   //currentIndex跟着变化
                orientation:ListView.Vertical
                header: Rectangle{
                    width: listView.width
                    height: listView.height/3
                    color: "white"
                    Text{
                        anchors.centerIn: parent
                        text:"上拉刷新"
                    }
                }
                footer: Rectangle{
                    width: listView.width
                    height: listView.height/3
                    color: "white"
                    Text{
                        anchors.centerIn: parent
                        text:"已经到底了"
                    }
                }
                model:videoModel
                delegate: Rectangle{
                    width: listView.width
                    height: listView.height
                    color: "gray"
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            mediaplayer.pause()
                            pauseAndPlayButton.visible = true
                        }
                    }
                    VideoOutput {
                        z:2
                        anchors.fill: parent
                        source:MediaPlayer {
                            id:mediaplayer
                            autoPlay: false
                            source:path
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
            ListModel {
                id:videoModel
                ListElement {
                    //                path:"rtsp://10.253.224.83/vedio/1.mkv"
                    path:"/home/zhangzhe/Videos/1.mp4"

                }
                ListElement {
                    path:"/home/zhangzhe/Videos/2.mp4"
                    //                path:"rtsp://10.253.224.83/vedio/2.mkv"
                }
                ListElement {
                    path:"/home/zhangzhe/Videos/3.mp4"
                    //                path:"rtsp://10.253.224.83/vedio/3.mkv"
                }
                ListElement{
                    path:"/home/zhangzhe/Videos/4.mp4"
                }
                ListElement{
                    path:"/home/zhangzhe/Videos/5.mp4"
                }
            }
            MouseArea{
                anchors.fill:parent
                enabled: bMenuShown
                onClicked: {
                    onSearchMenu()
                }
            }
        }
    }

    transform:Translate{
        id:menuTranslate
        x:0
        Behavior on x{
            NumberAnimation{
                duration:400;
                easing.type: Easing.OutQuad
            }
        }
    }
    //打开侧边栏
    function onSearchMenu(){
        menuTranslate.x = bMenuShown?0:width*0.8
        bMenuShown = !bMenuShown;
    }
}
