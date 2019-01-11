#include "swjserver.h"
#include <boost/asio.hpp>
#include <boost/thread.hpp>
#include "database.h"
#include <iostream>
#include <boost/lexical_cast.hpp>
#include "json/json.h"
//蒋富豪 2018-1-5




io_service service;     //必有的io——service对象
ip::tcp::endpoint ep(ip::tcp::v4(),6688);
ip::tcp::acceptor acc(service,ep);//连接器

Server::Server()
{

}

void Server::connect()
{
    try {

        cout << acc.local_endpoint().address()<<endl;
        while(true)
        {
            socket_ptr sock(new ip::tcp::socket(service));
            acc.accept(*sock);  //接收socket连接

            boost::thread(boost::bind(&Server::receciveMassage,this,sock));

        }
    }
    catch (std::exception &e)
    {
        cout << e.what()<< endl;
    }
}

void Server::receciveMassage(socket_ptr sock)
{
    boost::system::error_code ec;
    auto client_ep = sock->remote_endpoint(ec);//获得远程客户端连接短口
    if(ec)
    {
        cout << boost::system::system_error(ec).what() << endl;
    }
    cout << client_ep.address().to_string() << "连接"<<endl;

//    video.selectvidio();
    readdata(sock);//读取数据库
    while(true)
    {
        char data1[1024];
        memset(data1,0,sizeof(char)*1024);
        //同步接受，异步处理
//        cout << "recivedata" <<endl;
         cout <<"accountqq:"<< data1 <<endl;
        sock->read_some(buffer(data1),ec);
        if(ec)
        {
             cout << boost::system::system_error(ec).what() << endl;//客户端连接断开
             cout << client_ep.address().to_string() << "断开连接"<<endl;
             break;
        }
//        cout <<"account:"<< data1 <<endl;
        if(strlen(data1)!=0)
        {
            bool succes = verifyaccount(data1);
            if(succes)
            {
                sock->write_some(buffer("yes"), ec);
                if(ec)
                {
                     cout << boost::system::system_error(ec).what() << endl;//客户端连接断开
                     cout << client_ep.address().to_string() << "断开连接"<<endl;
                     break;
                }
            }else
            {
                sock->write_some(buffer("no"), ec);
                if(ec)
                {
                     cout << boost::system::system_error(ec).what() << endl;//客户端连接断开
                     cout << client_ep.address().to_string() << "断开连接"<<endl;
                     break;
                }
            }
        }
    }
}

void Server::readdata(socket_ptr &sock)
{
    database video;  //初始数据库
    std::string name;
    Json::Value namelist;
    std::vector<QString> videolist = video.selectvidio();

    boost::system::error_code ec;

    namelist["amount"]=videolist.size();
    for (int i= videolist.size()-1; i>=0; i--)
    {
        qDebug() << videolist[i];

        namelist["name"].append(videolist[i].toStdString());

    }
    std::string namepath = namelist.toStyledString();
    char headLength[10];
    memset(headLength,0,sizeof(char)*(10));
    sprintf(headLength, "%d", (namepath.size()));

    char data[1024];
     memset(data,0,sizeof(char)*1024);
     namepath.copy(data,namepath.size(),0);
//     cout << strlen(data) << "handsize"<< headLength <<endl;
     sock->write_some(buffer(headLength), ec);  //客户输入的消息，重新写到客户端
     if(ec)
     {
         std::cout << boost::system::system_error(ec).what() << std::endl;
     }
     sock->write_some(buffer(data), ec);  //客户输入的消息，重新写到客户端
     if(ec)
     {
         std::cout << boost::system::system_error(ec).what() << std::endl;
     }
     cout << "send to client : " << data<<endl;

//        for (auto iter = videolist.begin(); iter != videolist.end();iter++)
//        {
//            cout << *iter << " ";
//        }


}

bool Server::verifyaccount(string account)
{
    Json::Reader reader;
    Json::Value resultacc;
    if (!reader.parse(account.data(),resultacc))
    {
        std::cout << "json received account faild" <<std::endl;
        return false;
    }else
    {
        string name,password;
        boost::system::error_code ec;
//        Json::Value acc;
//        Json::Value pass;
        name = resultacc["name"].asString();
        password = resultacc["password"].asString();
        database q;
        bool succes = q.verifyaccout(name,password);
        if(succes)
        {
            return true;
        }
        else {
            return false;
        }
//        cout << name << password <<endl;

    }
}



