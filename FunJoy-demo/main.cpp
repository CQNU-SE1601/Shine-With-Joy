#include <QApplication>
#include <VPApplication>
#include "updatefile.h"
#include <QQmlApplicationEngine>
#include "recordervideo.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    VPApplication vplay;

    // Use platform-specific fonts instead of V-Play's default font
    qmlRegisterType<UploadAndDownload>("uploadAndDownload",1,0,"UploadAndDownload");//注册元对象系统

    qmlRegisterType<RecorderVideo>("recordervideo",1,0,"RecorderVideo");

    vplay.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

    //在应用开发中使用这个，在发布时，使用下面被注释的
    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    // 使用这个而不是上面调用来避免部署qml文件并使用qt的资源系统qrc将它们编译成二进制文件
    //这是将游戏，应用发布到应用商店的首选项，因为这样qml和js会受到保护，为了避免部署qml文件和图像，还要在.pro文件中
    //注释DEPLOYMENTFOLDERS命令
    // vplay.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));

    return app.exec();
}
