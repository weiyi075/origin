-- 创建数据库
create database oes;
use oes;

-- 建表
-- 用户表
create table user(
    uid int not null,
    username varchar(20) not null,
    role int not null,
    phone varchar(20) not null,
    email varchar(50) not null,
    password varchar(20) not null,
    s_id varchar(20),
    t_id varchar(20),
    introduction varchar(255),
    status int default 1,
    avatar varchar(255) not null,
    create_at datetime default current_timestamp

);

-- 教师
create table teacher(
    id int not null,
    t_id varchar(20) not null,
    t_name varchar(20) not null,
    t_phone varchar(20) not null,
    t_email varchar(50) not null,
    t_age int not null,
    t_gender enum('boy','girl') not null
);
-- 学生
create table student(
    id int not null,
    s_id varchar(20) not null,
    s_name varchar(20) not null,
    s_phone varchar(20) not null,
    s_email varchar(50) not null,
    s_age int not null,
    s_gender enum('boy','girl') not null
);
-- 班级
create table class(
    c_id int not null,
    t_id varchar(20) not null,
    c_name varchar(50) not null
);
-- 学科组
create table subject_group(
    sg_id int not null,
    uid int not null,
    subject varchar(50)
);
-- 题库
create table question_bank(
    q_id int not null,
    question_hash char(32) not null,
    question_type enum('single_choice','multiple_choice','grap_filling','short_answer') not null,
    question_text Text not null,
    correct_answer TEXT not null,
    difficulty_level tinyint default 1,
    subject varchar(50) not null,
    score decimal(5,2) default 0,
    create_at datetime default current_timestamp not null,
    update_at datetime default  current_timestamp on update current_timestamp
);
-- 选择题答案
create table option_answer(
    oa_id int not null,
    q_id int not null,
    option_label char(1) not null,
    option_text varchar(500) not null,
    is_correct tinyint default 0,
    score decimal(5,2) default 0.00 ,
    create_at datetime default current_timestamp not null,
    update_at datetime default  current_timestamp on update current_timestamp
);
-- 填空简答答案
create table question_answer(
    qa_id int not null,
    q_id int not null,
    correct_answer Text not null,
    score decimal(5,2) default 0.00,
    create_at datetime default current_timestamp not null,
    update_at datetime default  current_timestamp on update current_timestamp
);
