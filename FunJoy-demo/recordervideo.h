#ifndef RECORDERVIDEO_H
#define RECORDERVIDEO_H
#include <QCamera>
#include <QMediaRecorder>
#include <QAudioEncoderSettings>
#include <QCameraImageCapture>
class RecorderVideo:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m_fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
public:
    RecorderVideo(QObject *parent = nullptr);
    Q_INVOKABLE bool isAvailable();//摄像头是否可用
    Q_INVOKABLE void startRecord();//开始录制
    Q_INVOKABLE void pasueRecord();//暂停录制
    Q_INVOKABLE void stopRecord();//停止录制
    QString fileName() const;
    void setFileName(const QString &fileName);
signals:
    void fileNameChanged();//文件路径改变了


private:
    QCamera *m_camera;//摄像头
    QMediaRecorder *m_mediaRecorder;
    QAudioEncoderSettings m_audioSettings;//音频编码设置
    QString m_fileName;
};

#endif // RECORDERVIDEO_H
