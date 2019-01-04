#include "recordervideo.h"
#include <QUrl>
RecorderVideo::RecorderVideo(QObject *parent)
    :QObject{parent}
{
    m_camera = new QCamera(this);
    m_mediaRecorder = new QMediaRecorder(m_camera);
    m_audioSettings.setCodec("audio/amr");
    m_audioSettings.setQuality(QMultimedia::HighQuality);
    m_mediaRecorder->setAudioSettings(m_audioSettings);
    m_mediaRecorder->setOutputLocation(QUrl::fromLocalFile(m_fileName));//设置文件的输出路径和文件名
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

void RecorderVideo::stopRecord()
{
    m_mediaRecorder->stop();
}
QString RecorderVideo::fileName() const
{
    return m_fileName;
}

void RecorderVideo::setFileName(const QString &fileName)
{
    m_fileName = fileName;
}
