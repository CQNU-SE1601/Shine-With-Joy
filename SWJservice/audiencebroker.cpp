#include "audiencebroker.h"
#include <iostream>
#include <string>
#include <cstring>
#include <vector>
#include <memory>
#include <QString>
#include <sstream>
#include "videolistbroker.h"
#include "videobroker.h"
#include "audience.h"
#include "database.h"
#include "database.cpp"
using std::cout;            using std::endl;
using std::string;          using std::vector;


std::shared_ptr<AudienceBroker> AudienceBroker::_instance =std::make_shared<AudienceBroker>(AudienceBroker());
std::shared_ptr<AudienceBroker> AudienceBroker::getInstance()
{
    return _instance;
}

std::shared_ptr<Audience> AudienceBroker::findUser(std::string username)
{
    cout << "enter findUser" << endl;
    if(m_audience.find(username) != m_audience.end()){
        return m_audience[username];
    }else{
        return retrievalUser(username);
    }
}

std::shared_ptr<Audience> AudienceBroker::retrievalUser(std::string username)
{
     cout << "enter retrievalUser" << endl;
     auto ret = findUserInDataBase(username);
     if(ret!= nullptr)
     {
//         auto videolistBroker = VideoListBroker
         auto videolistBrober = VideoListBroker::getInstance();
         auto suggestedvideos = videolistBrober->findSuggestedVideos();
         ret->setVieoList(suggestedvideos);
         m_audience.insert(std::make_pair(username,ret));
         return ret;
     }
     return nullptr;
}

std::shared_ptr<Audience> AudienceBroker::findUserInDataBase(std::string username)
{
    QSqlDatabase dbconn;
    startconnect(dbconn);
    qDebug("database open status: %d\n", dbconn.open());
    if(dbconn.open()!=1)
    {
        cout << "数据库打开失败！" <<endl;
        return nullptr;
    }

    string name;
    string password;
    string sex;
    string birthday;
    //string address;
    string icon;

    QSqlQuery query;
     std::string s = "select * from account where username='"+username+"'";
    qDebug() <<QString::fromStdString(s);
    bool success = query.exec(QString::fromStdString(s));
    if(!success)
    {
        qDebug()<<QObject::tr("findUserFaild！\n");

    }
    if(query.first())
    {
        qDebug() << query.value(0).toString() << query.value(1).toString() << query.value(2).toString() << query.value(3).toString() ;
        name = query.value(1).toString().toStdString() ;
        password = query.value(2).toString().toStdString() ;
        sex = query.value(3).toString().toStdString() ;
        birthday = query.value(4).toString().toStdString() ;
        icon =  query.value(5).toString().toStdString() ;
        dbconn.close();
        return std::make_shared<Audience>(Audience(name,password,sex,birthday,icon));
    }
    return nullptr;


}

void AudienceBroker::updateCacheForCreatedSongList(std::string username, std::shared_ptr<VideoList> songlist)
{

}

void AudienceBroker::startconnect( QSqlDatabase &dbconn)
{
    QString hostName;
    QString dbName;
    QString userName;
    QString password;
    hostName = "localhost";   // 主机名
    dbName = "SWJsql";   // 数据库名称
    userName = "root";   // 用户名
    password = "42584693";   // 密码
    dbconn = QSqlDatabase::addDatabase("QMYSQL");
    dbconn.setHostName(hostName);
    dbconn.setDatabaseName(dbName);
    dbconn.setUserName(userName);
    dbconn.setPassword(password);
    QSqlError error1 = dbconn.lastError();
    qDebug() << error1.text();
}

AudienceBroker::AudienceBroker()
{

}
