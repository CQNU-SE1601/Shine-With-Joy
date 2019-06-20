import Felgo 3.0
import QtQuick 2.0

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
        LoginPage {
            id:loginPage
            app: app
            z:1
            visible: true
            enabled: visible
            Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
        }
        Navigation{
            id:navigation
            navigationMode: navigationModeTabs

            NavigationItem{
                title:"主页"
                icon:IconType.home
                HomePage{}
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.focus)
                }
            }
            NavigationItem{
                title: "发布"
                icon:IconType.adn
                AddPage{
                    //使得当页面切出去关闭camera
                    cameraAvailablity: navigation.currentIndex == 1?2:0
                }
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.activeFocus)
                }
            }
            NavigationItem{
                title: "我的"
                icon:IconType.minussquareo
                MinePage{
                    app: app
                }
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.activeFocus)
                }
            }
            NavigationItem{
                title: qsTr("消息")
                icon: IconType.clocko
                MessagePage{
                }
                onSelected: {
                    console.log(navigation.currentIndex+"     "+navigation.currentNavigationItem+"  "+navigation.activeFocus)
                }
            }
        }
    }
}
