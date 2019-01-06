import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
App{
    onInitTheme: {
        Theme.platform = "ios"
    }
    Page{
        useSafeArea: false//在异形屏幕的显示
        navigationBarHidden: false
        navigationBarTranslucency:1
        Navigation{
            //            headerView:Component    //用于自定义导航
            navigationMode: navigationModeTabs

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
