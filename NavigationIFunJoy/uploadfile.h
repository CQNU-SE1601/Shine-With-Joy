/*Q_INVOKABLE使得该方法可以被元对象系统调用
 *Q_PROPERTY使得该属性可以被元对象系统使用
 *
 *
 */
#ifndef UPLOADFILE_H
#define UPLOADFILE_H
#include <iostream>
#include <QQuickItem>

using namespace std;
class UploadFile:public QObject
{
    Q_OBJECT
public:
    UploadFile(QObject *parent);
    Q_INVOKABLE void upLoad();//上传文件
    Q_INVOKABLE void download();//下载文件
private:
    int m_port;//服务器端口号
    string m_ip;//ip地址
};

#endif // UPLOADFILE_H
