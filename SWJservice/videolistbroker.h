#ifndef VIDEOLISTBROKER_H
#define VIDEOLISTBROKER_H
#include <iostream>
#include "video.h"
#include "videobroker.h"
#include "videolist.h"
#include <memory>
#include <QSql>
#include <QSqlQueryModel>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <vector>
#include <QSqlError>
#include <QDebug>
#include <QSqlRecord>
using std::shared_ptr;
class VideoListBroker
{
public:
     static std::shared_ptr<VideoListBroker> getInstance();
     std::map<string,std::shared_ptr<VideoList>> findMyVideoList(std::string username);
     std::map<string,std::shared_ptr<VideoList>> findSuggestedVideos();

     void startconnect( QSqlDatabase &dbconn);

private:
    VideoListBroker();
    static std::shared_ptr<VideoListBroker> _instance;
    std::map<std::string,std::shared_ptr<VideoList>> m_videolist;
};

#endif // VIDEOLISTBROKER_H
