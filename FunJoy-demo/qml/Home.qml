import QtQuick 2.0
import VPlayApps 1.0
NavigationStack{
    Page{
    id:page1
    title: "主页"
    AppButton{
        anchors.centerIn: parent
        text:"推送一个子页面"
        onClicked: {
//            page1.navigationStack.push(subPage)
            }
        }
    }
}
