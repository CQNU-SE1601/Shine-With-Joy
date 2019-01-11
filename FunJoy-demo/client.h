#ifndef CLIENT_H
#define CLIENT_H


#include <QObject>
#include <boost/asio.hpp>
#include <boost/thread.hpp>
#include <string>
#include <iostream>
#include "json/json.h"
#include <QList>
using namespace boost::asio;
using std::cout;            using std::endl;
using std::string;          using std::vector;
typedef boost::shared_ptr<ip::tcp::socket> socket_ptr; //简化定义
class Client:public QObject
{
    Q_OBJECT
//    Q_PROPERTY()
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(QString userPassword READ userPassword WRITE setUserPassword NOTIFY userPasswordChanged)

public:
    Client();
    Q_INVOKABLE void StartConnect();
    Q_INVOKABLE void logining(QString name,QString password);
    void Readvideo();  //接受服务器的video消息
    void sendaccount();

    //用户帐号
    QString userName();
    void setUserName(QString name);
    QString userPassword();
    void setUserPassword(QString password);
signals:
    void userNameChanged();
    void userPasswordChanged();
private:
    //用户帐号
    QString m_userName;
    QString m_userPassword;
    bool m_loginging = false;
    QList<QString> _namelist;

};


#endif // CLIENT_H
