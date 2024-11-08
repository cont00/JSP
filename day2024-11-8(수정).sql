create table library(
	book_num int not null primary key,
    title varchar(500) not null,
    writer varchar(30),
    genre varchar(500) not null,
    publisher varchar(50),
    book_state varchar(20) not null,
    book_check varchar(10),
    reg_date datetime not null
);

create table user (
	user_id varchar(10) not null primary key unique,
    user_password varchar(20) not null,
    user_name varchar(10) not null,
    user_phonenum varchar(20) not null,
    user_email varchar(30)
);

create table recommendbookboard(
	recommend_num int not null primary key auto_increment,
    recommend_booktitle varchar(500) not null,
    recommend_title varchar(50) not null,
    recommend_user_name varchar(20) not null,
    recommend_date datetime not null,
    recommend_readcount int default 0,
    recommend_passwd varchar(20) not null,
    recommend_ref int not null,
    recommend_re_step smallint not null,
    recommend_re_level smallint not null,
    recommend_count int default 0,
    recommend_content text
);

create table administer(
	adminId varchar(50) not null primary key unique,
    adminPasswd varchar(16) not null
);