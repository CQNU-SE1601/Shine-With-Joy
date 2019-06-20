#include "videobroker.h"


std::shared_ptr<VideoBroker> VideoBroker::_instance =std::make_shared<VideoBroker>(VideoBroker());
std::shared_ptr<VideoBroker> VideoBroker::getInstance()
{
    return _instance;
}

std::shared_ptr<Video> VideoBroker::findVideo()
{

}

std::shared_ptr<Video> VideoBroker::retrievalVideo()
{

}

VideoBroker::VideoBroker()
{

}


