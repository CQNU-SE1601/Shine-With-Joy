#include "audienceproxy.h"
#include <json/json.h>
#include "audiencebroker.h"
AudienceProxy::AudienceProxy()
{

}

std::string AudienceProxy::myLogin(std::string username, std::string password)
{
    Json::Value root;
    Json::Value videolist;
     Json::Value arrayObj1;
    root["type"] = "LOGIN";
    auto audienceBroker = AudienceBroker::getInstance();
    auto res = audienceBroker->findUser(username);
    if(res==NULL){
        root["loginSuccess"] = "NAME_INVALID";
    }else{
        //succuss;
        root["userName"] = username;
        root["userPassword"] = password;
        root["userSex"] = res->sex();
        root["userBirthday"] = res->birtyday();
         root["userIcon"] = res->icon();
         if(password != res->password()){
             root["loginSuccess"] = "PW_INVALID";  //用户密码错误
         }else{
             root["loginSuccess"] = "SUCCESS";
             for(auto l:res->VieoList())
             {
                 for(auto i:l.second->getVideos())
                 {
                      Json::Value item;
                      item["id"] = i.second->ID();
                      item["name"] = i.second->name();
                      item["author"] = i.second->author();
                      item["videoType"] = i.second->videoType();
                      item["videosrc"] = i.second->videoSrc();
                      item["likenumber"] = i.second->likeNumber();
                      item["videoPlayQ"] = i.second->videoPlayQuantity();
                      item["download"] = i.second->videoDownLoadQuantity();
                      arrayObj1.append(item);
                 }
             }
         }
    }
    root["SuggestedVideo"] = arrayObj1;
    root.toStyledString();
    return root.toStyledString();
}
