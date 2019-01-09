//#ifndef UPDATEFILE_H
//#define UPDATEFILE_H
//#include <QUrl>
//#include <QFile>
//#include <QNetworkReply>
//#include <QObject>
//#include <QNetworkAccessManager>
///*元对象系统小结
// * Q_INVOKABLE 使成员方法可以在QML使用
// * Q_PROPERTY 使成员属性可以在QML中修改和访问
// * Q_ENUMS 使类的枚举成员可以在QML中访问
// */
//class UploadAndDownload:public QObject
//{
//    //使用元对象系统的基本要求
//    Q_OBJECT
////    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)

//public:
//    explicit UploadAndDownload(QObject *parent = nullptr);
//    //Q_INVOKABLEweil为了使对象可以被元对象系统所使用
//    Q_INVOKABLE void setHostPort(const QString &host, int port = 21);//设置服务器地址和端口
//    Q_INVOKABLE void setUserInfo(const QString &userName, const QString &password);//设置登录FTP服务器用户名和密码
//    Q_INVOKABLE void uploadFile( QString &fileName,  QString &path);//上传文件
//    Q_INVOKABLE void downloadFile(const QString &path, const QString &fileName);//下载文件

//signals:
//    void error(QNetworkReply::NetworkError);
//    void uploadProgress(qint64 bytesSent,qint64 bytesTotal);//上传进度
//    void downloadProgress(qint64 bytesReceived,qint64 bytesTotal);//下载进度

//private slots:
//    void finishedAndWrite();//下载过程中写文件

//private:
//    QFile m_file;
//    QString m_path;
//    QUrl m_protecolUrl;
//    QNetworkAccessManager m_manager;
//};

//#endif // UPDATEFILE_H
