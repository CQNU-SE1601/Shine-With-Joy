import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.12
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
            AppListView{
                id:listView
                anchors.fill: parent
                currentIndex: 0
                cacheBuffer: 2
                snapMode: ListView.SnapOneItem  //单张切换
                highlightRangeMode: ListView.StrictlyEnforceRange   //currentIndex跟着变化
                scrollIndicatorVisible:false//是否显示进度条
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
                        //                        FloatingActionButton{//悬浮按钮
                        //                            icon:IconType.heart
                        //                            onClicked:console.log("FloatingActionButton Clicked");
                        //                            visible:true  //在所有平台上显示，默认只有Android
                        //                        }
                        IconButton {//喜欢
                            anchors.horizontalCenter: parent
                            //默认状态
                            icon:IconType.hearto
                            //处于选定状态的图标
                            selectedIcon:IconType.heart
                            toggle:true;
                            onToggled:{
                                console.debug("按钮切换")
                            }
                        }

                    }
                }
            }
            ListModel {
                id:videoModel
//                ListElement {
//                    path:"https://static2.xiaoniangao.cn/album_tpl/xngVideo1.mp4"

//                }
//                ListElement {
//                    path:"https://static2.xiaoniangao.cn/web/xng-pc/img/home/VerticalVideo1.mp4"
//                }
//                ListElement{
//                    path:"https://static2.xiaoniangao.cn/web/xng-pc/img/home/VerticalVideo2.mp4"
//                }
                ListElement {
                    path:"rtsp://10.253.197.198/video/1.mkv"

                }
                ListElement {
                    path:"rtsp://10.253.197.198/video/2.mkv"
                }
                ListElement{
                    path:"rtsp://10.253.197.198/video/3.mkv"
                }


                ListElement{
                    path:"https://aweme.snssdk.com/aweme/v1/play/?video_id=47a9d69fe7d94280a59e639f39e4b8f4&line=0&ratio=720p&media_type=4&vr_type=0s"
                }
                ListElement{
                    path:"https://aweme.snssdk.com/aweme/v1/play/?video_id=3fdb4876a7f34bad8fa957db4b5ed159&line=0&ratio=720p&media_type=4&vr_type=0s"
                }
                ListElement{
                    Path:"https://aweme.snssdk.com/aweme/v1/play/?video_id=8a55161f84cb4b6aab70cf9e84810ad2&line=0&ratio=720p&media_type=4&vr_type=0"
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
