import QtQuick 2.0
import VPlayApps 1.0
import VPlay 2.0
Item {
    anchors.fill: parent
    property bool bMenuShown:false //侧边栏
    property Component settingsPage: ListPage {
        id:settingsPage
        title: "设置"
        model: [
            {text: "开启声音",detailText: "是否开启视频背景音乐",icon: IconType.volumedown},
            {text: "主题", detailText: "选择应用的主题颜色",icon: IconType.file},
        ]
        section.property: "group"
        onItemSelected: {
        }
    }
    NavigationStack{
        id:stack
        Page{
            id:stackPage
            leftBarItem: IconButtonBarItem {
                icon: IconType.gears //设置
                onClicked:{
                    //                    stack.popAllExceptFirstAndPush(settingsPage)
                    onSettingMenu();
                }
            }
            title: "我的"
            AppImage {
                id: image
                anchors.fill: parent
                // important to automatically rotate the image taken from the camera
                autoTransform: true
                fillMode: Image.PreserveAspectFit
            }
            //头像拾取——开始
            Column{
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: userImage.height
                    spacing: dp(10)
                    width: userImage.width + spacing + choosePhotoText.width
                    UserImage {
                        id: userImage
                        property string iconFontName: Theme.iconFont.name
                        width: dp(72)
                        height: width

                        placeholderImage: "\uf007" // user
                        source: ""
                        editable: true
                        editBackgroundColor: Theme.tintColor

                        property bool shownEditPhotoDialog: false

                        onEditClicked: {
                            if (system.desktopPlatform) {
                                nativeUtils.displayImagePicker(qsTr("Choose Image"))
                            }
                            else {
                                //是否用QML更好
                                shownEditPhotoDialog = true
                                nativeUtils.displayAlertSheet("", ["本地图片", "拍照", "重置"], true)
                            }
                        }
                        Connections {
                            target: nativeUtils
                            onAlertSheetFinished: {
                                if (userImage.shownEditPhotoDialog) {
                                    if (index == 0)
                                        nativeUtils.displayImagePicker(qsTr("本地图片"))
                                    else if (index == 1)
                                        nativeUtils.displayCameraPicker("拍照")
                                    else if (index == 2)
                                        userImage.source = "" //重置
                                    userImage.shownEditPhotoDialog = false
                                }
                            }
                            onImagePickerFinished: {
                                console.debug("图片拾取结束，路径在：", path)
                                if(accepted)
                                    userImage.source = Qt.resolvedUrl(path)
                            }
                            onCameraPickerFinished: {
                                console.debug("拍照完成，路径在：", path)
                                if(accepted)
                                    userImage.source = Qt.resolvedUrl(path)
                            }
                        }
                    } //用户头像
                    AppText {
                        id: choosePhotoText
                        width: dp(130)
                        text: "点击上传头像"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: dp(12)
                        wrapMode: Text.WordWrap
                    }
                }//头像拾取——结束

            }
            Connections{
                target: nativeUtils
                onCameraPickerFinished: {//displayCamerPicker被调用，用户接受，则讲照片保存在path路径,否则保存空字符串
                    if(accepted)
                    {
                        image.source = path
                        console.log("-------------------"+path)
                    }
                }
            }
            MouseArea{
                anchors.fill:parent
                enabled: bMenuShown
                onClicked: {
                    console.log("what")
                    onSettingMenu()
                }
            }
        }
    }
    Rectangle{
        id:rectangeList
        height: stackPage.height
        Behavior on width {
            NumberAnimation{
                duration: 300
            }
        }
//        transform:Translate{
//            id:menuTranslate
//            x:0
//            Behavior on x{
//                NumberAnimation{
//                    duration:300;
//                    easing.type: Easing.OutQuad
//                }
//            }
//        }
        //色彩
        Column {
            id: tintColorRow
            anchors.centerIn: rectangeList
            spacing: rectangeList.spacing
            property color defaultColor: Theme.isIos ? "#007aff" : (Theme.isAndroid ? "#3f51b5" : "#01a9e2")
            property int currentIndex: 0
            visible: bMenuShown?1:0
            Connections {
                target: Theme
                onPlatformChanged: if(tintColorRow.currentIndex === 0) Theme.colors.tintColor = tintColorRow.defaultColor
            }
            AppText {
                text: "Tint:"
                anchors.verticalCenter: rectangeList.verticalCenter
            }

            Repeater {
                model: [tintColorRow.defaultColor, "#FF3B30", "#4CD964", "#FF9500","gray","black"]

                Rectangle {
                    color: modelData
                    width: dp(48)
                    height: dp(48)
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { Theme.colors.tintColor =  color; tintColorRow.currentIndex = index }
                    }
                }
            }
        }
    }
    //打开侧边栏
    function onSettingMenu(){
//        menuTranslate.x = bMenuShown?0:stackPage.width*0.8
        rectangeList.width = bMenuShown?0:stackPage.width*0.8
        bMenuShown = !bMenuShown;

    }
}
