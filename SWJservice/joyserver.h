#ifndef JOYSERVER_H
#define JOYSERVER_H
#include <boost/asio.hpp>
#include <iostream>
#include <string>
#include <vector>
#include "audienceproxy.h"
#include "database.h"
#include "videolistproxy.h"
using namespace boost::asio;
using std::cout;            using std::endl;
using std::string;          using std::vector;
typedef boost::shared_ptr<ip::tcp::socket> socket_ptr; //简化定义
class JoyServer
{
public:
    JoyServer();
    //接收客户端的连接
    void connect();//连接客户端
    void receiveMessage(socket_ptr sock);//接受客户端信息
    string dealMessage(string sig,vector<string> str,socket_ptr sock);//处理客户端信息
   //发送客户端信息
private:
    std::shared_ptr<VideoListProxy> m_videoListProxy;
    int m_videoProxy;
    std::shared_ptr<AudienceProxy>m_audienceProxy;

   // database datacontroller;

};

#endif // JOYSERVER_H
