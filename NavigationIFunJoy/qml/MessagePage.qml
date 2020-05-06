import Felgo 3.0
import QtQuick 2.10
NavigationStack{
    id:globalNavStack
    initialPage: SocialView.inboxPage

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
    SocialView {
        id: socialView
        gameNetworkItem: gameNetwork
        multiplayerItem: multiplayer
        visible: true // we show the view pages on our custom app navigation
        countryCodeEnabled:false

        //扩展
        profileUserDelegate: SocialUserDelegate {
            height: otherUserCol.visible ? otherUserCol.height : userDetailCol.height

            //使用json来存储用户信息
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
                    text: qsTr("下面输入你的信息")
                }

                //自定义的数据域
                Column {
                    spacing: parent.spacing

                    Row {
                        spacing: parent.spacing
                        Icon {
                            id: inputIcon
                            icon: IconType.music; color: Theme.tintColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        AppTextField {
                            id: songInput
                            text: !!userCustomData.song ? userCustomData.song : ""
                            width: userDetailCol.width - parent.spacing - inputIcon.width
                            placeholderText: qsTr("输入你的名字")
                            borderWidth: px(1)
                        }
                    }

                    Row {
                        spacing: parent.spacing
                        Icon {
                            icon: IconType.cutlery; color: Theme.tintColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        AppTextField {
                            id: foodInput
                            text: !!userCustomData.food ? userCustomData.food : ""
                            width: userDetailCol.width - parent.spacing - inputIcon.width
                            placeholderText:qsTr("输入你的信息")
                            borderWidth: px(1)
                        }
                    }
                }

                // save button
                SocialViewButton {
                    text: qsTr("保存")
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

                //显示自定义的数据
                Grid {
                    spacing: parent.spacing
                    columns: 2
                    Icon { icon: IconType.music; color: Theme.tintColor }
                    AppText { text: !!userCustomData.song ? userCustomData.song : "" }
                    Icon { icon: IconType.cutlery; color: Theme.tintColor }
                    AppText { text: !!userCustomData.food ? userCustomData.food : "" }
                }
            }
        }
    }

}
