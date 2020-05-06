import Felgo 3.0
import QtQuick 2.0
//import client 1.0
App {
    id:app
    onInitTheme: {
        var darkBgColor = "#161614"
        var darkTextColor = "white"
        Theme.navigationBar.backgroundColor = darkBgColor
        Theme.navigationBar.titleColor = darkTextColor
        Theme.navigationBar.itemColor = darkTextColor

        Theme.tabBar.backgroundColor = darkBgColor
        Theme.tabBar.titleColor = darkTextColor
        Theme.colors.secondaryBackgroundColor = "#EFEFF4"
        Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
        Theme.platform = "ios"
    }
    property bool loginState: loginPage.visible
    Page{
        useSafeArea: false;//界面充满窗口
        //        LoginPage {
        //            id:loginPage
        //            app: app
        //            z:1
        //            visible: true
        //            enabled: visible

        //            Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
        //        }
        //        Client{
        //            id:client
        //        }
        Navigation{
            id:navigation
            navigationMode: navigationModeTabs

            NavigationItem{
                title:qsTr("Home")
                icon:IconType.home
                HomePage{}
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.focus)
                }
            }
            NavigationItem{
                title: qsTr("Release")
                icon:IconType.adn
                AddPage{
                    //使得当页面切出去关闭camera
                    cameraAvailablity: navigation.currentIndex == 1?2:0
                }
            }

            NavigationItem{
                title: qsTr("Message")
                icon:IconType.minussquareo
                MinePage{app: app}
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.activeFocus)
                }
            }
            NavigationItem{
                title: qsTr("Mine")
                icon: IconType.user
                NavigationStack {
                    initialPage: socialView.inboxPage
                }
            }
            NavigationItem {
                title: qsTr("Mine")
                icon: IconType.user
                NavigationStack {
                    initialPage: socialView.profilePage
                }
            }
        }
        //用于显示信息
        FelgoGameNetwork {
            id: gameNetwork
            gameId: 285
            secret: "AmazinglySecureGameSecret"
            multiplayerItem: multiplayer
        }

        FelgoMultiplayer {
            id: multiplayer
            appKey: "dd7f1761-038c-4722-9f94-812d798cecfb"
            pushKey: "a4780578-5aad-4590-acbe-057c232913b5"
            gameNetworkItem: gameNetwork
        }
        // social view setup
        SocialView {
            id: socialView
            gameNetworkItem: gameNetwork
            countryCodeEnabled: false
            visible: false
            multiplayerItem: multiplayer

            //使用委托来扩展
            profileUserDelegate: SocialUserDelegate {
                height: otherUserCol.visible ? otherUserCol.height : userDetailCol.height

                // parse the JSON data stored in customData property, if it is set
                property var userCustomData: !!gameNetworkUser && !!gameNetworkUser.customData ? JSON.parse(gameNetworkUser.customData) : {}

                // column visible for logged-in user, allows editing the custom fields
                Column {
                    id: userDetailCol
                    x: dp(Theme.navigationBar.defaultBarItemPadding) // add indent
                    width: parent.width - 2 * x
                    spacing: x
                    // only show if profile of logged-in user
                    visible: gameNetworkUser.userId === gameNetworkItem.user.userId

                    AppText {
                        text: qsTr("Edit your information")
                    }

                    //自定义数据域
                    Column {
                        spacing: parent.spacing

                        Row {
                            spacing: parent.spacing
                            Icon {
                                id: inputIcon
                                icon: IconType.android; color: Theme.tintColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            AppTextField {
                                id: songInput
                                text: !!userCustomData.song ? userCustomData.song : ""
                                width: userDetailCol.width - parent.spacing - inputIcon.width
                                placeholderText: "Enter your name"
                                borderWidth: px(1)
                            }
                        }

                        Row {
                            spacing: parent.spacing
                            Icon {
                                icon: IconType.xing; color: Theme.tintColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            AppTextField {
                                id: foodInput
                                text: !!userCustomData.food ? userCustomData.food : ""
                                width: userDetailCol.width - parent.spacing - inputIcon.width
                                placeholderText: "Change your password."
                                borderWidth: px(1)
                            }
                        }
                    }

                    //保存按钮
                    SocialViewButton {
                        text: qsTr("Save")
                        onClicked: {
                            var customData = JSON.stringify({ "song": songInput.text, "food": foodInput.text })
                            gameNetworkItem.updateUserCustomData(customData) // store stringified JSON data
                        }
                    }
                }

                // column visible when viewing other users, show data of custom fields
                Column {
                    id: otherUserCol
                    x: dp(Theme.navigationBar.defaultBarItemPadding) // add indent
                    width: parent.width - 2 * x
                    spacing: x
                    // only show if profile of other user
                    visible: gameNetworkUser.userId !== gameNetworkItem.user.userId

                    // show custom data
                    Grid {
                        spacing: parent.spacing
                        columns: 2
                        Icon { icon: IconType.android; color: Theme.tintColor }
                        AppText { text: !!userCustomData.song ? userCustomData.song : "" }
                        Icon { icon: IconType.cutlery; color: Theme.tintColor }
                        AppText { text: !!userCustomData.food ? userCustomData.food : "" }
                    }
                }
            }
            SocialActionButton{

            }
        }
    }
}
