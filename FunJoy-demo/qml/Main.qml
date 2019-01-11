import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import client 1.0
App{
    onInitTheme: {
        Theme.platform = "ios"
    }
    property bool userLoggedIn: false
    LoginPage {
        z: 1 // show login above actual app pages
        visible: opacity > 0
        enabled: visible
        opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
        onLoginSucceeded:{
           console.debug("client")
            client.logining(tUsername,tUserPassword)//交互C++，发送name和password
//            console.debug(client.userName)
//            console.debug(client.userPassword)

            userLoggedIn = true
        }

        Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
    }
    Client{
        id:client
    }
        Navigation{
            navigationMode: navigationModeTabs
//            navigationDrawerItem: Text {
//              text: "Open"
//              anchors.centerIn: parent
//              color: navigation.navigationTabsItemPressed ? "red" : "green"
//            }
//            footerView: BaseTabBar{
//                id: bar
//                height: 48
//                width: parent.width
//                Component.onCompleted: {
//                    myModel.append({ "modelText": "消息", "modelColor": "#000000", "modelColorG": "#148014", "modelSrc": "qrc:/images/Chat_MsgRecord.svg", "modelSrcG": "qrc:/images/Chat_MsgRecordG.svg"})
//                    myModel.append({ "modelText": "联系人", "modelColor": "#000000", "modelColorG": "#148014", "modelSrc": "qrc:/images/Chat_FriendManager.svg", "modelSrcG": "qrc:/images/Chat_FriendManagerG.svg"})
//                    myModel.append({ "modelText": "发现", "modelColor": "#000000", "modelColorG": "#148014", "modelSrc": "qrc:/images/Mobile_Find.svg", "modelSrcG": "qrc:/images/Mobile_FindG.svg"})
//                    myModel.append({ "modelText": "我", "modelColor": "#000000", "modelColorG": "#148014", "modelSrc": "qrc:/images/Main_P2PChat.svg", "modelSrcG": "qrc:/images/Main_P2PChatG.svg"})
//                }
//            }
            NavigationItem{
                title:"主页"
                icon:IconType.home
                Home{}//主页

            }
            NavigationItem{
                title: "关注"
                icon:IconType.heart
                Concerned{}
            }
            NavigationItem{
                title: "发布"
                icon:IconType.adn
                AddNew{}
            }
            NavigationItem{
                title: "消息"
                icon:IconType.medium
                Messagement{}
            }
            NavigationItem{
                title: "我的"
                icon:IconType.minussquareo
                Mine{}
            }
//            NavigationItem{
//                title: "测试"
//                icon:IconType.laptop
//                New{}
//            }

        }
    }
