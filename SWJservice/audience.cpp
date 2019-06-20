#include "audience.h"



Audience::Audience()
{

}

Audience::Audience(string name,string password,string sex,string birthday, string icon):m_name{name},m_password{password},m_sex{sex},m_birthday{birthday},m_icon{icon}
{
}

string Audience::name() const
{
    return m_name;
}

void Audience::setName(const string &name)
{
    m_name = name;
}

string Audience::password() const
{
    return m_password;
}

void Audience::setPassword(const string &password)
{
    m_password = password;
}

string Audience::sex() const
{
    return m_sex;
}

void Audience::setSex(const string &sex)
{
    m_sex = sex;
}

string Audience::birtyday() const
{
    return m_birthday;
}

void Audience::setBirtyday(const string &birthday)
{
    m_birthday = birthday;
}

std::string Audience::icon() const
{
    return m_icon;
}

void Audience::setIcon(const std::string &icon)
{
    m_icon = icon;
}

std::map<string, std::shared_ptr<VideoList> > Audience::VieoList() const
{
    return m_SuggestedVideoList;
}

void Audience::setVieoList(const std::map<string, std::shared_ptr<VideoList> > &VieoList)
{
    m_SuggestedVideoList = VieoList;
}

std::map<string, std::shared_ptr<Video> > Audience::video() const
{
    return m_video;
}

void Audience::setVideo(const std::map<string, std::shared_ptr<Video> > &video)
{
    m_video = video;
}

std::map<string, std::shared_ptr<Audience> > Audience::attentedUsers() const
{
    return _attentedUsers;
}

void Audience::setAttentedUsers(const std::map<string, std::shared_ptr<Audience> > &attentedUsers)
{
    _attentedUsers = attentedUsers;
}

std::map<string, std::shared_ptr<VideoList> > Audience::SuggestedVideoList() const
{
    return m_SuggestedVideoList;
}

void Audience::setSuggestedVideoList(const std::map<string, std::shared_ptr<VideoList> > &SuggestedVideoList)
{
    m_SuggestedVideoList = SuggestedVideoList;
}
