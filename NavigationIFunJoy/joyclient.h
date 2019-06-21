#ifndef JOYCLIENT_H
#define JOYCLIENT_H
#include <QObject>
#include <QTcpSocket>
#include "audience.h"
#include "videolist.h"
class JoyClient:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString videoSrc READ videoSrc WRITE setVideoSrc NOTIFY videoSrcChanged)
    Q_PROPERTY(QString localHost READ getHostName WRITE setHostName)
    Q_PROPERTY(quint16 port READ getPort WRITE setPort)


public:
    JoyClient();
    Q_INVOKABLE void startconnect();//开始连接
    Q_INVOKABLE void myLogin(QString username,QString userpw);//登录
    Q_INVOKABLE void myRegister(QString username,QString userpw);//注册
    Q_INVOKABLE string getVideoscr(int i);//得到路径

    // std::map<int, std::shared_ptr<Video> > videolist() const;

    void setVideolist(const std::map<int, std::shared_ptr<Video> > &videolist);

    void addVideoinVideoList(int,std::shared_ptr<Video>);//添加视频到videolist中
    QString videoSrc() const;
    void setVideoSrc(const QString &s);

    VideoList vlist() const;
    void setVlist(const VideoList &vlist);
    Q_INVOKABLE QString getVideoSrc(int i);

    QString getHostName() const;
    void setHostName(const QString &hostName);

    quint16 getPort() const;
    void setPort(quint16 port);

signals:
    void videoSrcChanged(const QString &s);
private slots:
    Q_INVOKABLE void ReadInformation();
private:

    QTcpSocket *tcpClient;
    QString m_username;
    Audience audience;
    int m_userID;
    QString m_icon;
    bool m_logining = false;
    std::map<int,std::shared_ptr<Video>> m_videolist;
    VideoList m_vlist;
    QString m_videoSrc;

    QString m_hostName = "10.253.197.198";//主机名
    quint16 m_port = 2001;//端口号
};

#endif // JOYCLIENT_H
