import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
App{
    Page{
        useSafeArea: false//在异形屏幕的显示
        navigationBarHidden: Theme.isOSX
        navigationBarTranslucency:0
        Navigation{
//            headerView: true;//用于自定义上下导航视图
//            footerView: true;
            //可以取消注释尝试不同的导航模式
//            navigationMode: navigationModeDrawer
//            navigationMode: navigationModeTabs
            navigationMode: navigationModeTabsAndDrawer
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
        }
    }
}
