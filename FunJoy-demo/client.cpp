#include "client.h"
#include <algorithm>
#include <iostream>
#include "json/json.h"
#include <QDebug>
io_service service;     //必有的io——service对象
ip::tcp::endpoint ep(boost::asio::ip::address::from_string("192.168.31.99"),6688);
ip::tcp::socket sock(service);
Client::Client()
{
    StartConnect();
}

void Client::StartConnect()
{
    boost::system::error_code ec;
    sock.async_connect(ep,[](const boost::system::error_code &ec)
    {
        if(ec){
            cout << ec.message() <<endl;
            return ;
        }
    });
    service.run();
}

void Client::logining(QString name, QString password)
{
    m_userName = name;
    m_userPassword = password;

    Readvideo();
    sendaccount();
    for (int i=0;i < _namelist.size();i++)
    {
        qDebug() << _namelist.at(i)<<endl;
    }
    //    std::cout << userName() << m_userPassword << std::endl;
}

void Client::Readvideo()
{
    string rec;

    char dataSize[10];
    boost::system::error_code ec;
    memset(dataSize,0,sizeof(char)*10);//reset 0 to data[]

    while(strlen(dataSize) == 0)
        sock.read_some(buffer(dataSize,sizeof(char)*10),ec);
    char data[1024];
    memset(data,0,sizeof(char)*1024);
    while(rec.length() < atoi(dataSize))
    {
//        qDebug() << "jieshou1";
        sock.read_some(buffer(data),ec);
        qDebug() << data;
        rec.append(data,0,sizeof (data));
        memset(data,0,sizeof(char)*512);
    }
    cout << rec;
    if(ec)
    {
        std::cout << boost::system::system_error(ec).what() << std::endl;
        return;
    }
    Json::Reader reader;
    Json::Value resultname;
    if(!reader.parse(rec.data(),resultname))
    {
        std::cout << "json received faild" <<std::endl;
        return;
    }else
    {
//         qDebug()<<"read3"<<resultname["name"].size();
         Json::Value value;
         value = resultname["name"];
         for (unsigned int i =0 ; i < resultname["name"].size();i++)
         {
//             qDebug()<<;

//             cout <<"name" <<value[i].asString()<<endl;
            //             qDebug()<<"read9";
             _namelist.append(QString::fromStdString(value[i].asString()));
//             qDebug()<<"read8";
         }


    }

}

void Client::sendaccount()
{
    char data[1024];
     memset(data,0,sizeof(char)*1024);
      boost::system::error_code ec;
      string account ;
      Json::Value acc;
      acc["name"] = m_userName.toStdString();
      acc["password"] = m_userPassword.toStdString();
      cout <<"send:" <<m_userName.toStdString() <<endl;
      account = acc.toStyledString();
      account.copy(data,account.size(),0);
//     cout << strlen(data) << "handsize"<< headLength <<endl;
     sock.write_some(buffer(data), ec);  //写道服务器
     if(ec)
     {
         std::cout << boost::system::system_error(ec).what() << std::endl;
     }
     char data1[10];
     memset(data,0,sizeof(char)*10);
//     cout << data <<endl;

}

QString Client::userName()
{
    return m_userName;
}

void Client::setUserName(QString name)
{
    m_userName = name;
    emit userNameChanged();
}

QString Client::userPassword()
{
    return m_userPassword;
}

void Client::setUserPassword(QString password)
{
    m_userPassword = password;
    emit userPasswordChanged();
}
