#include "videolist.h"

VideoList::VideoList()
{

}

int VideoList::updataVideoList()
{

}

std::string VideoList::getListType() const
{
    return listType;
}

void VideoList::setListType(const std::string &value)
{
    listType = value;
}

int VideoList::getVideoNumber() const
{
    return videoNumber;
}

void VideoList::setVideoNumber(int value)
{
    videoNumber = value;
}

void VideoList::addVideo(std::string videoID, std::shared_ptr<Video> video)
{
    m_videos.insert(std::make_pair(videoID,video));
}

std::map<std::string, std::shared_ptr<Video> > VideoList::getVideos() const
{
    return m_videos;
}

void VideoList::setVideos(const std::map<std::string, std::shared_ptr<Video> > &videos)
{
    m_videos=videos;
}
