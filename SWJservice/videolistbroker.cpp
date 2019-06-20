#include "videolistbroker.h"
std::shared_ptr<VideoListBroker> VideoListBroker::_instance = std::make_shared<VideoListBroker>(VideoListBroker());
std::shared_ptr<VideoListBroker> VideoListBroker::getInstance()
{
    return _instance;
}
void VideoListBroker::startconnect( QSqlDatabase &dbconn)
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

std::map<std::string, std::shared_ptr<VideoList> > VideoListBroker::findMyVideoList(std::string username)
{
    std::cout << "enter findMyVideoList"<<std::endl;
    std::map<string,std::shared_ptr<VideoList>> videoList;
    QSqlDatabase dbconn;
    startconnect(dbconn);
    if(dbconn.open()!=1)
    {
         std::cout << "MYSQL failed!" << std::endl;
         return videoList;
    }
    QSqlQuery query;
    std::string s = "select * from videolist where username = '" + username+"'";
    qDebug() << QString::fromStdString(s);
     bool success = query.exec(QString::fromStdString(s));
     if(!success)
     {
         qDebug()<<QObject::tr("findUserFaild！\n");

     }
     while(query.next())
     {
         qDebug() << query.value(0).toString() << query.value(1).toString() << query.value(2).toString() << query.value(3).toString() << query.value(4).toString()<< query.value(5).toString()<< query.value(6).toString()<< query.value(7).toString();
     }
    dbconn.close();

}

std::map<std::string, std::shared_ptr<VideoList> > VideoListBroker::findSuggestedVideos()
{
    std::cout << "enter findMyVideoList"<<std::endl;

    std::shared_ptr<VideoList> videos = std::make_shared<VideoList>();
    std::map<string,std::shared_ptr<VideoList>> videoList;
    string videoID;
    string videoname;
    string videoAuthor;
    string videosrc;
    int videolikeQ;
    int downloadQ;
    int playQ;
    QSqlDatabase dbconn;
    startconnect(dbconn);
    if(dbconn.open()!=1)
    {
         std::cout << "MYSQL failed!" << std::endl;
         return videoList;
    }
    QSqlQuery query;
    std::string s = "select * from videolist where likenumber>0";
    qDebug() << QString::fromStdString(s);
     bool success = query.exec(QString::fromStdString(s));
     if(!success)
     {
         qDebug()<<QObject::tr("findUserFaild！\n");

     }
     while(query.next())
     {
         qDebug() << query.value(0).toString() << query.value(1).toString() << query.value(2).toString() << query.value(3).toString() << query.value(4).toString()<< query.value(5).toString()<< query.value(6).toString()<< query.value(7).toString();
         videoID     = query.value(0).toString().toStdString();
         videoAuthor = query.value(1).toString().toStdString();
         videoname   = query.value(7).toString().toStdString();

         videosrc    = query.value(3).toString().toStdString();
         videolikeQ  = query.value(4).toInt();
         playQ       = query.value(5).toInt();
         downloadQ   = query.value(6).toInt();

         videos->addVideo(videoID, std::make_shared<Video>(Video(videoID,videoname,videosrc,videoAuthor,videolikeQ,playQ,downloadQ)));
         //m_videolist.insert()
     }

     std::cout << "video List OVer!" << std::endl;
    dbconn.close();
    videoList.insert((std::make_pair("SuggestedVideos",videos)));
    return videoList;
}

VideoListBroker::VideoListBroker()
{

}
