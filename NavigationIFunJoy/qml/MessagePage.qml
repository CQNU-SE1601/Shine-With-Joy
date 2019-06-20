import QtQuick 2.4
import Felgo 3.0
NavigationStack{
    id:globalNavStack
    ListPage {
        id:listPage
        navigationBarHidden: true
        delegate: SwipeOptionsContainer{
            id: container
            SimpleRow {
                id:listItem
            image.radius: image.height
            image.fillMode: Image.PreserveAspectCrop
            autoSizeImage: true
            style.showDisclosure: false
            imageMaxSize: dp(51)
            detailTextItem.maximumLineCount: 1
            detailTextItem.elide: Text.ElideRight
            badgeValue: "1";
            onSelected: {
                badgeValue = ""
                globalNavStack.popAllExceptFirstAndPush(detailPageComponent, {
                                                            person: item.text,
                                                            newMsgs: [{me: true, text: item.detailText}]

                                                        })
            }
        }
            rightOption: SwipeButton{
                icon:IconType.close
                height: listItem.height
                onClicked: {
                    console.log("删除")
                    container.hideOptions()
                }
            }
        }
        Component { id: detailPageComponent;  ConversationPage { } }

        model:
            [
            { text: "Tom McEloy", detailText: "Sorry for the late reply ...", image: Qt.resolvedUrl("../assets/1.jpg") },
            { text: "Leah Douglas", detailText: "Hahaha :D", image: Qt.resolvedUrl("../assets/2.jpg") },
            { text: "小小", detailText: "最近如何", image: Qt.resolvedUrl("../assets/3.jpg") },
            { text: "学鸟", detailText: "在吗", image: Qt.resolvedUrl("../assets/4.jpg") },
            { text: "鹏鹏", detailText: "吃饭了吗", image: Qt.resolvedUrl("../assets/5.jpg") }
        ]
    }
}
