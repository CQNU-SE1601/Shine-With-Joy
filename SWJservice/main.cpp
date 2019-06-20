//蒋富豪 2018-1-5
#include <QApplication>
#include <VPApplication>

#include <QQmlApplicationEngine>
#include "joyserver.h"
#include "audiencebroker.h"
int main(int argc, char *argv[])
{

    JoyServer joyserver;
    joyserver.connect();
//    cout << "jaing"<<endl;
     auto a = AudienceBroker::getInstance();
      a->findUserInDataBase("jiang");

}
