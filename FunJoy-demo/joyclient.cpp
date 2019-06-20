#include "joyclient.h"
#include <QtNetwork>
#include <QAbstractSocket>
#include <iostream>
#include <string>
#include <QMessageBox>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QTextCodec>
#include <QDebug>
#include "video.h"
#include "json/json.h"
JoyClient::JoyClient()
{
    startconnect();
}

void JoyClient::startconnect()
{
     tcpClient = new QTcpSocket(this);
     //connect(tcpClient,)
     tcpClient->abort();
     tcpClient->connectToHost("192.168.31.99",2001);
     connect(tcpClient, &QTcpSocket::readyRead, this, &JoyClient::ReadInformation);
     qDebug() << "连接";
}

void JoyClient::myLogin(QString username, QString userpw)
{
    QJsonObject json;
    json.insert("type","LOGIN");
    json.insert("userName",username);
    json.insert("userPassword",userpw);

    QJsonDocument document;
    document.setObject(json);
    QByteArray byte_array = document.toJson(QJsonDocument::Compact);
    QString json_str(byte_array);
    qDebug() << json_str;
    tcpClient->write(byte_array);

}

void JoyClient::myRegister(QString username, QString userpw)
{

}
string JoyClient::getVideoscr(int i)
{
    //string qstr = QString::(m_videolist[i]->videoSrc());
//    string s= qstr.toStdString();
//    std::cout << "ser+++++++++++++="<<m_videolist[i]->videoSrc();
//    return m_videolist[i]->videoSrc();
    std::cout << "接收成功++++++++++++__________+========"<<m_videolist[i]->videoSrc()<<std::endl;
    QString q = QString::fromStdString(m_videolist[i]->videoSrc());
    setVideoSrc(q);
    qDebug() <<"==========="<< m_videoSrc;
    return m_videolist[i]->videoSrc();

}

//QString JoyClient::qstrtoStdstr()
//{
//    string s = getVideoscr(1);
//    std::cout << getVideoscr(1)<<std::endl;
//    QString ss = QString::fromStdString(s);
//    return ss;
//}

void JoyClient::ReadInformation()
{
        QByteArray temp = tcpClient->readAll();
        //std::cout << temp.toStdString()<<std::endl;
        string jsonString = temp.toStdString();


        //std::cout << "enter---------------"<<jsonString<<std::endl;
        QString jsonStr = QString::fromStdString(jsonString);
        jsonStr = jsonStr.simplified();
       // qDebug() << "enter---------------"<<jsonStr;
        QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonStr.toLocal8Bit().data());
        if( jsonDocument.isNull() ){
                qDebug()<< "===> please check the string ";
            }
           QJsonObject jsonObject = jsonDocument.object();
           std::string type = jsonObject["type"].toString().toStdString();
          // qDebug() <<"NAME:::--------------"<< jsonObject["userName"].toString();
           std::cout << "type--------------------------"<<type<<std::endl;
           if(type == "LOGIN")
           {
               std::cout << "enter--------------------------"<<std::endl;
               std::string succes=jsonObject["loginSuccess"].toString().toStdString();
               if(succes == "SUCCESS")
               {
                   m_username = jsonObject["userName"].toString();
                   audience.setName(jsonObject["userName"].toString().toStdString());
                   audience.setSex(jsonObject["userSex"].toString().toStdString());
                   audience.setBirtyday(jsonObject["userBirthday"].toString().toStdString());
                   std::cout <<"name:"<< audience.name()<<std::endl;
                   if(jsonObject.contains(QStringLiteral("SuggestedVideo")))
                   {
                               QJsonValue arrayValue = jsonObject.value(QStringLiteral("SuggestedVideo"));
                               if(arrayValue.isArray())
                               {
                                   QJsonArray array = arrayValue.toArray();
                                   for(int i=0;i<array.size();i++)
                                   {
                                       QJsonValue iconArray = array.at(i);
                                       QJsonObject icon = iconArray.toObject();
                                       string id = icon["id"].toString().toStdString();
                                       string name = icon["name"].toString().toStdString();
                                       string author = icon["author"].toString().toStdString();
                                       string videosrc = icon["videosrc"].toString().toStdString();
                                       int likenumber = icon["likenumber"].toInt();
                                       int videoPlayQ = icon["videoPlayQ"].toInt();
                                       int download = icon["download"].toInt();

                                       std::shared_ptr<Video> video = std::make_shared<Video>(Video(id,name,videosrc,author,likenumber,videoPlayQ,download));
                                       //std::cout << id <<video->videoSrc()<<std::endl;
                                       addVideoinVideoList(i, std::make_shared<Video>(Video(id,name,videosrc,author,likenumber,videoPlayQ,download)));

                                   }
                               }
                   }
                   //m_vlist.setVideos(m_videolist);
                   //std::cout <<"))))))))))))))))SRC:" <<m_videolist[1]->videoSrc()<<std::endl;
                   getVideoscr(1);


               }
           }



}

QString JoyClient::getVideoSrc(int i) const
{

    return m_videoSrc;
}

VideoList JoyClient::vlist() const
{
    return m_vlist;
}

void JoyClient::setVlist(const VideoList &vlist)
{
    m_vlist = vlist;
}

//std::map<int, std::shared_ptr<Video> > JoyClient::videolist() const
//{
//    return m_videolist;
//}

void JoyClient::setVideolist(const std::map<int, std::shared_ptr<Video> > &videolist)
{
    m_videolist = videolist;
}

void JoyClient::addVideoinVideoList(int s, std::shared_ptr<Video> v)
{
    m_videolist.insert(std::make_pair(s,v));
}

QString JoyClient::videoSrc() const
{
    return m_videoSrc;
}

void JoyClient::setVideoSrc(const QString &s)
{
    m_videoSrc = s;
    emit videoSrcChanged(m_videoSrc);
}

