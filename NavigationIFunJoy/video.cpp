#include "video.h"
#include <iostream>

Video::Video(std::string ID,std::string name, std::string source, std::string author, int likenumber, int playq, int download):m_ID(ID),m_name(name),m_author(author),m_videoSrc(source),m_likeNumber(likenumber),m_videoPlayQuantity(playq),m_videoDownLoadQuantity(download)
{

}

string Video::name() const
{
    return m_name;
}

void Video::setName(const string &name)
{
    m_name = name;
}

string Video::author() const
{
    return m_author;
}

void Video::setAuthor(const string &author)
{
    m_author = author;
}

string Video::videoType() const
{
    return m_videoType;
}

void Video::setVideoType(const string &videoType)
{
    m_videoType = videoType;
}

string Video::videoSrc() const
{
    std::cout<<"////////////////"<<this->m_videoSrc<<std::endl;
    string s = this->m_videoSrc;
    return m_videoSrc;
}

void Video::setVideoSrc(const string &videoSrc)
{
    m_videoSrc = videoSrc;
}

int Video::likeNumber() const
{
    return m_likeNumber;
}

void Video::setLikeNumber(int likeNumber)
{
    m_likeNumber = likeNumber;
}

int Video::videoPlayTime() const
{
    return m_videoPlayTime;
}

void Video::setVideoPlayTime(int videoPlayTime)
{
    m_videoPlayTime = videoPlayTime;
}

int Video::videoPlayQuantity() const
{
    return m_videoPlayQuantity;
}

void Video::setVideoPlayQuantity(int videoPlayQuantity)
{
    m_videoPlayQuantity = videoPlayQuantity;
}

int Video::videoDownLoadQuantity() const
{
    return m_videoDownLoadQuantity;
}

void Video::setVideoDownLoadQuantity(int videoDownLoadQuantity)
{
    m_videoDownLoadQuantity = videoDownLoadQuantity;
}

string Video::ID() const
{
    return m_ID;
}

void Video::setID(const string &ID)
{
    m_ID = ID;
}
