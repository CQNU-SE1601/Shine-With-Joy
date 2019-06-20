#ifndef VIDEO_H
#define VIDEO_H

#include <string>
#include "command.h"
using std::string;
class Video
{
public:
    Video(string ID,string name,string source,string author,int likenumber,int playq,int download);
    string name() const;
    void setName(const string &name);

    string author() const;
    void setAuthor(const string &author);

    string videoType() const;
    void setVideoType(const string &videoType);

    string videoSrc() const;
    void setVideoSrc(const string &videoSrc);

    int likeNumber() const;
    void setLikeNumber(int likeNumber);

    int videoPlayTime() const;
    void setVideoPlayTime(int videoPlayTime);

    int videoPlayQuantity() const;
    void setVideoPlayQuantity(int videoPlayQuantity);

    int videoDownLoadQuantity() const;
    void setVideoDownLoadQuantity(int videoDownLoadQuantity);

    string ID() const;
    void setID(const string &ID);

private:
    string m_ID;
    string m_name; //视频名
    string m_author;//视频作者
    string m_videoType;//视频类型
    string m_videoSrc;//视频地址
    int m_likeNumber;//点赞视频的人数
    int m_videoPlayTime;//视频播放的时长
    int m_videoPlayQuantity;//视频播放次数
    int m_videoDownLoadQuantity;//视频下载次数

};

#endif // VIDEO_H
