import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import client 1.0
App{
    property bool userLoggedIn: false
    LoginPage {
        z: 1 // show login above actual app pages
        visible: opacity > 0
        enabled: visible
        opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
        onLoginSucceeded:{
           console.debug("client")
            client.logining(tUsername,tUserPassword)//交互C++，发送name和password
            console.debug(client.userName)
            console.debug(client.userPassword)

            userLoggedIn = true
        }

        Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
    }
    Client{
        id:client
    }
    Page{
        useSafeArea: false//在异形屏幕的显示
        navigationBarHidden: Theme.isOSX
        navigationBarTranslucency:0
        Navigation{
//            headerView: true;//用于自定义上下导航视图
//            footerView: true;
            //可以取消注释尝试不同的导航模式
//            navigationMode: navigationModeDrawer
            navigationMode: navigationModeTabs
//            navigationMode: navigationModeTabsAndDrawer
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
            NavigationItem{
                title: "测试"
                icon:IconType.laptop
                New{}
            }
        }
    }
}
