#ifndef AUDIENCE_H
#define AUDIENCE_H

#include <string>
#include <vector>
#include <map>
#include <shared_mutex>

using std::string;

class Audience
{
public:
    Audience();
    Audience(string name,string password,string sex,string birthday, string icon);
    string name() const;
    void setName(const string &name);

    string password() const;
    void setPassword(const string &password);

    string sex() const;
    void setSex(const string &sex);

    string birtyday() const;
    void setBirtyday(const string &birtyday);

    std::string icon() const;
    void setIcon(const std::string &icon);


    std::map<string, std::shared_ptr<Audience> > attentedUsers() const;
    void setAttentedUsers(const std::map<string, std::shared_ptr<Audience> > &attentedUsers);



private:
    string m_name;     //名字
    string m_password; //密码
    string m_sex;      //性别
    string m_birthday; //生日
    std::string m_icon;         //头像，保存路径
    bool m_vaild;               //状态变量，用来标志歌曲是否违法，

    std::map<string ,std::shared_ptr<Audience>> _attentedUsers;               //关注的用户

};

#endif // AUDIENCE_H
