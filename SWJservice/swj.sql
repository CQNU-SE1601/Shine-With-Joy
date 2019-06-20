
CREATE TABLE videolist (id int NOT NULL primary key auto_increment,author VARCHAR(10) NOT NULL ,videoname VARCHAR(50) NOT NULL, type VARCHAR(10),source VARCHAR(100) NOT NULL,likenumber int,playQuantity int,downloadQuantity int );
CREATE TABLE account (id int NOT NULL primary key auto_increment,username VARCHAR(10) NOT NULL unique, password VARCHAR(10) NOT NULL,sex VARCHAR(10),birthday VARCHAR(10),icon VARCHAR(50));

insert into account (username,password,sex,birthday,icon) values ("yang","yang","nan","19970104", '');   
insert into account (username,password,sex,birthday,icon) values ("zhang","zhang","nan","19970104", '');
insert into videolist(videoname,author,source,likenumber,playQuantity,downloadQuantity) values ('孤独','zhang','rtsp://192.168.31.99/video/1.mkv',1000,300,1000);
insert into videolist(videoname,author,source,likenumber,playQuantity,downloadQuantity) values ('木叶之影','zhang','rtsp://192.168.31.99/video/2.mkv',0,0,0);
insert into videolist(videoname,author,source,likenumber,playQuantity,downloadQuantity) values ('对决','jiang','rtsp://192.168.31.99/video/3.mkv',10,0,0);
insert into videolist(videoname,author,source,likenumber,playQuantity,downloadQuantity) values ('木叶','jiang','rtsp://192.168.31.99/video/4.mkv',990,0,0);
