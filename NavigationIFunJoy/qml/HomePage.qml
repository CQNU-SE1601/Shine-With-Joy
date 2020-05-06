import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import Felgo 3.0
NavigationStack {
    anchors.fill: parent
    property int currentIndex:1
    Page {
        id: pageHome
        title: "主页"
        visible: true
        navigationBarHidden: true
        anchors.fill: parent
        Rectangle {
            id: page1
            anchors.fill: parent
            AppListView {
                id: listView
                anchors.fill: parent
                currentIndex: 0
                cacheBuffer: 2
                scrollIndicatorVisible: false
                snapMode: ListView.SnapOneItem //单张切换
                highlightRangeMode: ListView.StrictlyEnforceRange //currentIndex跟着变化
                orientation: ListView.Vertical
                footer: Rectangle {
                    width: listView.width
                    height: listView.height / 3
                    color: "white"
                    Text {
                        anchors.centerIn: parent
                        text: "松手即可刷新"
                    }
                }
                model: videoModel
                delegate: Rectangle {
                    width: listView.width
                    height: listView.height
                    MediaPlayer {
                        id: player
                        loops: MediaPlayer.Infinite
                        source: path
                    }
                    VideoOutput {
                        z: 2
                        anchors.fill: parent
                        source: player
                        Slider {
                            id: playPos
                            z:3
                            anchors.bottom: parent.bottom
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
                                switchs.state = false
                                player.pause()
                            }
                        }
                        ImageButton {
                            id: switchs
                            anchors.centerIn: parent
                            property bool state:false
                            width: dp(30)
                            height: dp(30)
                            visible: !state
                            imageBackground: "../assets/icon/play.png"
                            onBtnClicked: {
                                if (state) {
                                    state = false
                                    player.pause()
                                } else {
                                    state = true
                                    player.play()
                                }
                            }
                        }
                    }
                }
                property int total:videoModel.count
                onCurrentIndexChanged: {
                    if((videoModel.count==(listView.currentIndex+1)) /*&& total != 7 */)
                    {
                        var a = client.getVideoSrc(currentIndex)
                        console.log("视频模型数量"+videoModel.count+"当前序列"+listView.currentIndex)
                        console.log(a)
                        videoModel.append({"path":a})
                        total++
                    }
                    console.log("changed")
                }
                ListModel {
                    id: videoModel
                    ListElement {
                        path: "https://static2.xiaoniangao.cn/album_tpl/xngVideo1.mp4"
                    }
                    ListElement {
                        path: "https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200ff20000bqnnaa49hq5ksnrks4kg&ratio=720p&line=0"
                    }
                    ListElement{
                        path:"https://kol-fans.fp.ps.netease.com/file/5e7acd1c143cfa903f353960BYGRso5502"
                    }

                    ListElement{
                        path:"https://static2.xiaoniangao.cn/web/xng-pc/img/home/VerticalVideo4.mp4"
                    }
                    ListElement{
                        path:"https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200ff20000bqnbavg9lr7a1ct3hpag&ratio=720p&line=0"
                    }
                    ListElement{
                        path:"https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200f670000bqlslqtds133rheabni0&ratio=720p&line=0"
                    }
                    ListElement{
                        path:"https://sky.res.netease.com/2019/0515/3.mp4"
                    }
                    ListElement{
                        path:"https://flv2.bn.netease.com/da4cfaf101511768833d46f5b2da99bd71ad6f63dca5094c7b2640d828bb93fcfa530c484f36f47b801a1f42c0ab603ed0fe343f02a86f133537a677ab62880268afa961bf6de3eedeec48e0a789c15f38068da765bac39d081230f5156f5c48fba5abac3a2db7d1470135a5577008400e187c98000ff43a.mp4"
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
                        height: dp(25)
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
