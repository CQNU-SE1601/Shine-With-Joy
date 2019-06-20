#include "joyserver.h"
#include <boost/thread.hpp>
#include <boost/asio.hpp>
#include <string>
#include <iostream>
#include <algorithm>
#include <vector>
#include "syssignal.h"
#include <json/json.h>

using namespace boost::asio;
using std::cout;            using std::endl;
using std::string;          using std::vector;

typedef boost::shared_ptr<ip::tcp::socket> socket_ptr;


io_service service;   //创建调度器
ip::tcp::endpoint ep(ip::tcp::v4(),2001);  //监听端口
ip::tcp::acceptor acc(service,ep); //创建连接器
void sendMessage(string result2,socket_ptr sock);
vector<string> jsonParase(char data[]);
JoyServer::JoyServer()
{

}

void JoyServer::connect()
{
    bool value = true;
    setsockopt(1,SOL_SOCKET,SO_REUSEADDR,(void *)&value,sizeof(value)); //允许套接口和一个已在使用中的地址捆绑（参见bind()）。
    while(true){
        socket_ptr sock(new ip::tcp::socket(service));
        acc.accept(*sock); //接收新的连接
        boost::thread(boost::bind(&JoyServer::receiveMessage,this,sock)); //开辟线程去处理该连接上的事务

    }
}

void JoyServer::receiveMessage(socket_ptr sock)
{
    boost::system::error_code ec;
    auto ep1 = sock->remote_endpoint(ec);//获得客户端的连接端口
    if(ec)
    {
        std::cout << boost::system::system_error(ec).what() << std::endl;
    }
    std::cout<<ep1.address().to_string()<<"连接"<<std::endl;
    while(true)
    {
        char data1[512];
        memset(data1,0,sizeof (char)*512);
        sock->read_some(buffer(data1),ec);
        if(ec)
        {
            std::cout << boost::system::system_error(ec).what() << std::endl;
            break;
        }
          cout << "receive from client : " << data1<<endl;
          if(strlen(data1) != 0){
              auto result1 = jsonParase(data1);
              cout << "++++++++++++++++++: " << result1[0] << endl;

              boost::thread(boost::bind(&JoyServer::dealMessage,this,result1[0],result1,sock));

          }
      }
      std::cout<<ep1.address().to_string()<<"关闭"<<std::endl;

}
vector<string> jsonParase(char data[]){
    vector<string>  parameter;
    Json::Value value;
    Json::Reader reader;
    if (!reader.parse(data, value))
    {
        cout << "receive from client failed" <<endl;
    }else{
        //分辨信息存储
        string type = value["type"].asString();
        if(type == "LOGIN"){
            parameter.push_back(value["type"].asString());
            parameter.push_back(value["userName"].asString());
            parameter.push_back(value["userPassword"].asString());

        }else if(type == "REGISTER"){
            parameter.push_back(value["type"].asString());
            parameter.push_back(value["userName"].asString());
            parameter.push_back(value["userPassword"].asString());
        }else if(type == "VideoLIST"){
            parameter.push_back(value["type"].asString());
            parameter.push_back(value["videoListId"].asString());
        }else{
            parameter.push_back("wrongParameter");
        }
    }
         return parameter;

}
string JoyServer::dealMessage(string sig,vector<string> str,socket_ptr sock)
{
    string res;
    cout << "==================:  " << sig << endl;
    if(sig == "LOGIN"){
            cout << "enter LOGIN" << endl;
            res = m_audienceProxy->myLogin(str[1],str[2]);
            sendMessage(res,sock);
            cout << res <<endl;
            return res;

        }
}
void sendMessage(string result2,socket_ptr sock)
{
    boost::system::error_code ec;
    if(result2 != "fileTransfer"){
        //写回客户端
        char data2[1024*10];
        memset(data2,0,sizeof(char)*1024*10);

        char headLength[10];
        memset(headLength,0,sizeof(char)*(10));
        sprintf(headLength, "%d", (result2.size()));
        result2.copy(data2,result2.size(),0);
        //memcpy(data2,headLength,sizeof(headLength));

        cout << strlen(data2) << "ss"<<headLength<< endl;
        //sock->write_some(buffer(headLength), ec);  //客户输入的消息，重新写到客户端
        if(ec)
        {
            std::cout << boost::system::system_error(ec).what() << std::endl;
        }
        sock->write_some(buffer(data2), ec);  //客户输入的消息，重新写到客户端
        if(ec)
        {
            std::cout << boost::system::system_error(ec).what() << std::endl;
        }
        cout << "send to client : " << data2<<endl;
    }
}

