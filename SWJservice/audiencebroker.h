#ifndef AUDIENCEBROKER_H
#define AUDIENCEBROKER_H
#include <memory>
#include <map>
#include <QSql>
#include <QSqlQueryModel>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <vector>
#include <QSqlError>
#include <QDebug>
#include <QSqlRecord>
#include <string>
#include "audience.h"
#include "videolist.h"
class AudienceBroker
{
public:
    static std::shared_ptr<AudienceBroker> getInstance();
    std::shared_ptr<Audience> findUser(std::string username);

    std::shared_ptr<Audience> retrievalUser(std::string username);       //在数据库中检索,检索用户的所有信息，包括歌单、关注、粉丝
    std::shared_ptr<Audience> findUserInDataBase(string name);
    void updateCacheForCreatedSongList(std::string username, std::shared_ptr<VideoList> songlist);       //更新缓存
    void startconnect(QSqlDatabase &dbconn);
private:
    AudienceBroker();
    static std::shared_ptr<AudienceBroker> _instance;
    std::map<std::string, std::shared_ptr<Audience>> m_audience;       //用户名为键

};

#endif // AUDIENCEBROKER_H
