import Felgo 3.0
import QtQuick 2.0

App {
    id:app
    onInitTheme:Theme.platform = "ios"
    property bool loginState: true
    LoginPage {
        id:loginPage
        app: app
        z:1
        visible: loginState
        enabled: visible
        Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
    }
    Navigation{
        navigationMode: navigationModeTabs
        NavigationItem{
            title:"主页"
            icon:IconType.home
            HomePage{}
        }
        NavigationItem{
            title: "发布"
            icon:IconType.adn
            AddPage{}
        }
        NavigationItem{
            title: "我的"
            icon:IconType.minussquareo
            MinePage{
                app: app
            }
        }
        NavigationItem{
            title: qsTr("消息")
            MessagePage{

            }
        }

        NavigationItem{
            title: qsTr("附近")
            icon: IconType.mapmarker;
            MapPage{

            }
        }
    }

}
