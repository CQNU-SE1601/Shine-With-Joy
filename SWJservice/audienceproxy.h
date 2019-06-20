#ifndef AUDIENCEPROXY_H
#define AUDIENCEPROXY_H
#include <string>

using std::string;

class AudienceProxy
{
public:
    AudienceProxy();
    string myLogin(string username,string password);
};

#endif // AUDIENCEPROXY_H
