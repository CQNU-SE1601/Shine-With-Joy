import QtQuick 2.0
import Felgo 3.0
Item {
    anchors.fill: parent
    property App app;//获取父部件的App对象
    NavigationStack{
        id:stack
        Page{
            id:stackPage
            title: "我的"
            //头像拾取——开始
            Column{
                spacing: dp(10)
                anchors.fill: parent;
                UserImage {
                    anchors.horizontalCenter: parent.horizontalCenter
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
                } //用户头像
                AppListView {
                    model: [
                        {
                            text: "退出登录",
                        },
                        {
                            text:"切换颜色"
                        },
                        {
                            text:"关于"
                        }

                    ]
                    delegate: SimpleRow {
                        onSelected:{
                            switch(index){
                            case 0:
                                console.log("退出登录")
                                nativeUtils.displayAlertDialog(qsTr("确认？"),qsTr("是否退出？"),qsTr("退出"),qsTr("取消"))
                                break;
                            case 1:
                                console.log("切换颜色");
                                stackPage.navigationStack.push(pageSwitchColor);
                                break;
                            case 2:
                                console.log("关于")
                                stackPage.navigationStack.push(pageAbout)
                                break;
                            }
                            console.log("Clicked Item #"+index+": "+JSON.stringify(modelData))
                        }
                    }
                }
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
        }
    }
    /*----------------------------------------对本机各种响应------------------------------*/
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
        onAlertDialogFinished:{
            if(accepted){
                console.log("退出")
                //返回到登录
            }else{
                //关闭当前警告框
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
    /*----------------------------------------下面是切换颜色-----------------------------*/
    Component {
        id: pageSwitchColor
        Page {
            Column {
                id: tintColorRow
                anchors.centerIn: parent;
                property color defaultColor: Theme.isIos ? "#007aff" : (Theme.isAndroid ? "#3f51b5" : "#01a9e2")
                property int currentIndex: 0
                Connections {
                    target: Theme
                    onPlatformChanged: if(tintColorRow.currentIndex === 0) Theme.colors.tintColor = tintColorRow.defaultColor
                }

                Repeater {
                    model: [tintColorRow.defaultColor, "#FF3B30", "#4CD964", "#FF9500","gray","black"]
                    Rectangle {
                        color: modelData
                        width: dp(48)
                        height: dp(48)
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                Theme.colors.tintColor =  color;
                                tintColorRow.currentIndex = index
                                //                                app.settings.setValue("themeColor",color)//保存主题颜色到系统
                            }
                        }
                    }
                }
            }
        }
    }
    //--------------------------------------切换颜色结束，关于页面开始-------------------------------------------
    Component{
        id:pageAbout
        Page{
            Text{
                anchors.centerIn: parent;
                text: "Qt Creator 4.8.2\nBased on Qt 5.12.1 (GCC 5.3.1 20160406 (Red Hat 5.3.1-6), 64 bit)
\nBuilt on Feb 28 2019 16:23:53
\nFrom revision 04aac85e26
\nCopyright 2008-2019 The Qt Company Ltd. All rights reserved.
\nThe program is provided AS IS with NO WARRANTY OF ANY KIND,
\nINCLUDING THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS
\nFOR A PARTICULAR PURPOSE."
            }
        }
    }
    //----------------------------------关于结束--------------------------------------------------------------

}
