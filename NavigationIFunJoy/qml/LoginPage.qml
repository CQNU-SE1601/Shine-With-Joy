import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1

Page {
    property alias loginState:loginPage.visible
    property  alias tUsername:  txtUsername.text
    property  alias tUserPassword:  txtPassword.text
    id: loginPage
    backgroundColor: Qt.rgba(0,0,0, 0.75) // page background is translucent, we can see other items beneath the page
    useSafeArea: false // do not consider safe area insets of screen
    property App app;
    //登录的背景
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        color: "white"
        width: content.width + dp(30)
        height: content.height + dp(16)
        radius: dp(4)
    }

    GridLayout {
        id: content
        anchors.centerIn: loginForm
        columnSpacing: dp(20)
        rowSpacing: dp(10)
        columns: 2

        AppText {
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: "登录"
        }

        //用户名
        AppText {
            text: "用户名"
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtUsername
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            text:app.settings.getValue("userID");//读取数据
        }

        //密码域
        AppText {
            text: "密码"
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtPassword
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            echoMode: TextInput.Password
            text: app.settings.getValue("userPSW")
        }

        //列向的按钮
        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)

            // buttons
            AppButton {
                text: "登录"
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.forceActiveFocus() //将焦点移开文本域
                     client.myLogin(tUsername,tUserPassword)
                    app.settings.setValue("userID", txtUsername.text)//写入
                    app.settings.setValue("userPSW",txtPassword.text)
                    loginPage.visible = false
                }
            }
            AppButton {
                text: qsTr("还没有账号吗，快注册吧")
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.forceActiveFocus() // move focus away from text fieldss
                    // call your logic action to register here
                    console.debug("registering...")
                }
            }
        }
    }
}
