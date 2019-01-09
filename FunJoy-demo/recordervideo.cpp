#include "recordervideo.h"
#include <QUrl>
RecorderVideo::RecorderVideo(QObject *parent)
    :QObject{parent}
{
    m_camera = new QCamera(this);




    m_camera->setViewfinder(m_viewFinder);



    m_mediaRecorder = new QMediaRecorder(m_camera);
    m_audioSettings.setCodec("audio/amr");
    m_audioSettings.setQuality(QMultimedia::HighQuality);//高品质
    m_mediaRecorder->setContainerFormat("mp4");
    m_mediaRecorder->setAudioSettings(m_audioSettings);//音频
    m_camera->setCaptureMode(QCamera::CaptureVideo);//采集视频
    m_mediaRecorder->setOutputLocation(QUrl::fromLocalFile(m_fileName));//设置文件的输出路径和文件名
    connect(m_camera, QOverload<QCamera::Error>::of(&QCamera::error),
          [=](QCamera::Error value){
        m_camera->errorString();
        m_error = value;
    });
}

bool RecorderVideo::isAvailable()
{
    return m_mediaRecorder->isAvailable();
}

void RecorderVideo::startRecord()
{
    m_mediaRecorder->record();
}

void RecorderVideo::pasueRecord()
{
    m_mediaRecorder->pause();
}

void RecorderVideo::openCamera()
{
    m_camera->start();

}

void RecorderVideo::closeCamera()
{
    m_camera->stop();
}

void RecorderVideo::stopRecord()
{
    m_mediaRecorder->stop();
}

int RecorderVideo::recoderState()
{
    return m_mediaRecorder->state();
}

QString RecorderVideo::currentLocation()
{

}
QString RecorderVideo::fileName() const
{
    return m_fileName;
}

void RecorderVideo::setFileName(const QString &fileName)
{
    m_fileName = fileName;
}
