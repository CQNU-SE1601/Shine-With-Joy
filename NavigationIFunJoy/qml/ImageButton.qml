import QtQuick 2.0
Image {
    property string imageBackground
    property alias text:text.text

    signal btnClicked;
    signal btnPressed;
    signal btnReselesed;
    signal btnPressAndHold;

    id: image
    width: dp(20)
    height: dp(20)
    source: imageBackground
    Text {
        id: text
        anchors.centerIn: parent
        text: qsTr("")
    }
    MouseArea{
        id:imageArea
        anchors.fill: parent
        onClicked: {btnClicked()}
        onPressed: {btnPressed();image.scale=1.2}
        onPressAndHold: {btnPressAndHold()}
        onReleased: {btnReselesed();image.scale=1}
    }
}

