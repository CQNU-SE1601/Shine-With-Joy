#ifndef VIDEOBROKER_H
#define VIDEOBROKER_H
#include "video.h"
#include <memory>
#include <map>
class VideoBroker
{
public:
    static std::shared_ptr<VideoBroker> getInstance();
//    std::shared_ptr<Video> re
    std::shared_ptr<Video> findVideo();
    std::shared_ptr<Video> retrievalVideo();
private:
    VideoBroker();
    static std::shared_ptr<VideoBroker> _instance;
    std::map<std::string, std::shared_ptr<Video>> m_videos;

};

#endif // VIDEOBROKER_H
