import Felgo 3.0
NavigationStack {
    Page {
        title: "消息列表"
        AppListView {
            model: [
                {
                    text: "苹果",
                    detailText: "你好，这是我的名片",
                    icon: IconType.apple
                },
                {
                    text: "啤酒",
                    detailText: "一罐可口的啤酒",
                    icon: IconType.beer
                }
            ]

            delegate:SwipeOptionsContainer{
                id:container
                height: listItem.heights
                SimpleRow {
                    id:listItem
                    onSelected: console.log("Clicked Item #"+index+": "+JSON.stringify(modelData))
                    badgeValue:"12"
                }
                rightOption:SwipeButton{
                    height: listItem.height;
                    icon: IconType.close
                    onClicked: {
                        listItem.text = "被点击"
                        container.hideOptions();
                    }
                }
            }
        }
    }
}
