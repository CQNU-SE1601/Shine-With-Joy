#ifndef RECORDERVIDEO_H
#define RECORDERVIDEO_H
#include <QCamera>
#include <QMediaRecorder>
#include <QAudioEncoderSettings>
#include <QCameraImageCapture>
#include <QCameraViewfinder>
class RecorderVideo:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m_fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)


//    Q_PROPERTY(QCameraViewfinder m_viewFinder READ viewFinder WRITE setViewFinder)


public:
    RecorderVideo(QObject *parent = nullptr);
    Q_INVOKABLE bool isAvailable();//摄像头是否可用
    Q_INVOKABLE void startRecord();//开始录制
    Q_INVOKABLE void pasueRecord();//暂停录制
    Q_INVOKABLE void openCamera();//开启摄像头
    Q_INVOKABLE void closeCamera();//关闭摄像头
    Q_INVOKABLE void stopRecord();//停止录制
    Q_INVOKABLE int recoderState();//录制状态
    Q_INVOKABLE QString currentLocation();//目前的保存路径
    QString fileName() const;
    void setFileName(const QString &fileName);

signals:
    void fileNameChanged();//文件路径改变了
private:
    QCamera *m_camera;//摄像头
    QMediaRecorder *m_mediaRecorder;//记录
    QAudioEncoderSettings m_audioSettings;//音频编码设置
    QString m_fileName;
    QCamera::Error m_error;//摄像头错误码

    QCameraViewfinder *m_viewFinder;//摄像头渲染
//    QCameraImageCapture *m_imageCapture;
};

#endif // RECORDERVIDEO_H
