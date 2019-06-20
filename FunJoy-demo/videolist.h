#ifndef VIDEOLIST_H
#define VIDEOLIST_H
#include "video.h"
#include <iostream>
#include <memory>
#include <map>
#include <string>

class VideoList
{
public:
    VideoList();
    int updataVideoList();

    std::map<std::string, std::shared_ptr<Video> > getVideos() const;
    void setVideos(const std::map<std::string, std::shared_ptr<Video> > &videos);


    std::string getListType() const;
    void setListType(const std::string &value);

    int getVideoNumber() const;
    void setVideoNumber(int value);

    void addVideo(std::string videoID,std::shared_ptr<Video> video);


private:
    int videoNumber;
    std::string listType;
    std::map<std::string,std::shared_ptr<Video>> m_videos; //
};

#endif // VIDEOLIST_H
