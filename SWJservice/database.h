//蒋富豪 2018-1-5
#ifndef DATABASE_H
#define DATABASE_H

#include <QSql>
#include <QSqlQueryModel>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <vector>
#include <QSqlError>
#include <QDebug>
#include <QSqlRecord>
#include <string>
class database
{
public:
    database();
    void startconnect();
    void createtable();
    void insertvideo();
    bool verifyaccout(std::string name,std::string password);
    std::vector<QString> selectvidio();
    ~database(){
         dbconn.close();
    }
//    std::vector<QString> setnamelist();
private:
    QSqlDatabase dbconn;
    std::vector<QString> namelist;
};

#endif // DATABASE_H
