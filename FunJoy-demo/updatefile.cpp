//#include "updatefile.h"
//#include <QFileInfo>

//UploadAndDownload::UploadAndDownload(QObject *parent)
//    :QObject{parent}
//{
//    m_protecolUrl.setScheme("ftp");//设置传输协议
//}
////设置服务器地址和端口
//void UploadAndDownload::setHostPort(const QString &host, int port)
//{
//    m_protecolUrl.setHost(host);
//    m_protecolUrl.setPort(port);
//}
////设置登录FTP服务器的用户名和密码
//void UploadAndDownload::setUserInfo(const QString &userName, const QString &password)
//{
//    m_protecolUrl.setUserName(userName);
//    m_protecolUrl.setPassword(password);
//}
////上传文件
//void UploadAndDownload::uploadFile( QString &fileName,QString &path)
//{
//    //测试用
//    fileName = "clip_00000001.ogg";
//    path = "/home/zhangzhe/Videos";



//    QFile file(fileName);
//    file.open(QIODevice::ReadOnly);
//    QByteArray data = file.readAll();//读取本地所有文件的内容
//    m_protecolUrl.setPath(path);
//    QNetworkReply *pReply = m_manager.put(QNetworkRequest(m_protecolUrl),data);//上传文件
//    connect(pReply,SIGNAL(uploadProgress(qint64,qint64)),this,SIGNAL(uploadProgress(qt64,qint64)));
//    connect(pReply,SIGNAL(error(QNetworkReply::NetworkError)),this,SIGNAL(error(QNetworkReply::NetworkError)));

//}
////下载文件
//void UploadAndDownload::downloadFile(const QString &path,const QString &fileName)
//{
//    QFileInfo info;
//    info.setFile(fileName);

//    m_file.setFileName(fileName);
//    m_file.open(QIODevice::WriteOnly | QIODevice::Append);
//    m_protecolUrl.setPath(path);

//    QNetworkReply *pReply = m_manager.get(QNetworkRequest(m_protecolUrl));//下载文件

//    connect(pReply,SIGNAL(finished()),this,SLOT(finishedAndWrite()));
//    connect(pReply,SIGNAL(downloadProgress(qint64,qint64)),this,SIGNAL(downloadProgress(qint64,qint64)));
//    connect(pReply,SIGNAL(error(QNetworkReply::NetworkError)),this,SIGNAL(error(QNetworkReply::NetworkError)));
//}
////下载过程中写文件
//void UploadAndDownload::finishedAndWrite()
//{
//    QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());//qt中尽量使用qobject_cast，少使用强制转换
//    switch (pReply->error()) {
//    case QNetworkReply::NoError:{
//        m_file.write(pReply->readAll());
//        m_file.flush();//激活
//    }
//        break;
//    default:
//        break;
//    }
//    m_file.close();
//    pReply->deleteLater();//删除工作表
//}
