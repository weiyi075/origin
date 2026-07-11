-- 创建数据库
create database if not exists oes;
use oes;

-- 建表
-- 用户表
create table sys_user(
    uid int primary key auto_increment,
    username varchar(20) unique not null,
    role int default 2,
    phone varchar(20) unique not null,
    email varchar(50) unique not null,
    password varchar(255) not null,
    introduction varchar(255),
    age int not null,
    gender tinyint not null default 0,
    status int default 1,
    avatar varchar(255) not null,
    create_at datetime default current_timestamp

);

-- 教师
create table teacher(
    id int primary key auto_increment,
    t_id varchar(20) unique not null,
    uid int not null
);
-- 学生
create table student(
    id int primary key auto_increment,
    s_id varchar(20) unique not null,
    uid int not null,
    c_id int not null
);
-- 班级
create table class(
    c_id int primary key auto_increment,
    t_id varchar(20) not null,
    c_name varchar(50) not null
);
-- 学科组
create table subject_group(
    sg_id int primary key auto_increment,
    uid int not null,
    subject varchar(50) not null
);
-- 题库
create table question_bank(
    q_id int primary key auto_increment,
    question_hash char(32) not null,
    question_type enum('single_choice','multiple_choice','gap_filling','short_answer') not null,
    question_text Text not null,
    difficulty_level tinyint default 1,
    sg_id int not null,
    created_at datetime default current_timestamp not null,
    updated_at datetime default  current_timestamp on update current_timestamp
);
-- 选择题答案
create table option_answer(
    oa_id int primary key auto_increment,
    q_id int not null,
    option_label char(1) not null,
    option_text varchar(500) not null,
    is_correct tinyint default 0,
    score decimal(5,2) default 0.00 ,
    created_at datetime default current_timestamp not null,
    updated_at datetime default  current_timestamp on update current_timestamp
);
-- 填空简答答案
create table question_answer(
    qa_id int primary key auto_increment,
    q_id int not null,
    correct_answer Text not null,
    score decimal(5,2) default 0.00,
    created_at datetime default current_timestamp not null,
    updated_at datetime default  current_timestamp on update current_timestamp
);
-- 试卷表
create table paper(
    p_id int primary key auto_increment,
    paper_name varchar(100) not null,
    paper_desc varchar(255),
    sg_id int not null,
    total_score decimal(5,2) default 100.00,
    duration int not null,
    pass_score decimal(5,2) default 60.00,
    status tinyint default 0,
    created datetime default current_timestamp,
    updated datetime default current_timestamp on update current_timestamp
);
-- 试卷题目关联表
create table paper_question(
    pq_id int primary key auto_increment,
    p_id int not null,
    q_id int not null,
    sort_order int not null default 0,
    score decimal(5,2) not null
);
-- 考试安排表
create table exam(
    e_id int primary key auto_increment,
    p_id int not null,
    exam_name varchar(100) not null,
    start_time datetime not null,
    end_time datetime not null,
    c_id int,
    exam_status tinyint default 0,
    created_at datetime default current_timestamp
);
-- 答卷表
create table exam_record(
    er_id int primary key auto_increment,
    e_id int not null,
    q_id int not null,
    uid int not null,
    student_answer text,
    is_currect tinyint default 0,
    got_score decimal(5,2) default 0.00,
    submit_at datetime default current_timestamp
);

-- 添加外键
alter table teacher add constraint tea_uid_user_uid foreign key (uid) references sys_user (uid) on update cascade on delete cascade;
alter table student add constraint stu_uid_user_uid foreign key (uid) references sys_user (uid) on update cascade on delete cascade;
alter table student add constraint student_cid_class_c_id foreign key (c_id) references class (c_id) on update cascade on delete cascade;
alter table class add constraint class_tid_teacher_t_id foreign key (t_id) references teacher (t_id) on update cascade on delete cascade;
alter table subject_group add constraint sub_uid_user_uid foreign key (uid) references sys_user (uid) on update cascade on delete cascade;
alter table option_answer add constraint opt_qid_qnbk_q_id foreign key (q_id) references question_bank (q_id) on update cascade on delete cascade;
alter table question_bank add constraint qnbk_sgid_sbgp_sg_id foreign key (sg_id) references subject_group (sg_id) on update cascade on delete cascade;
alter table question_answer add constraint qnar_qid_qnbk_q_id foreign key (q_id) references question_bank (q_id) on update cascade on delete cascade;
alter table paper add constraint paper_sub_sugp_sub foreign key (sg_id) references subject_group (sg_id) on update cascade on delete cascade;
alter table paper_question add constraint paqt_pid_paper_p_id foreign key (p_id) references paper (p_id) on update cascade on delete cascade;
alter table paper_question add constraint paqt_qid_qnbk_q_id foreign key (q_id) references question_bank (q_id) on update cascade on delete cascade;
alter table exam add constraint exam_pid_paper_p_id foreign key (p_id) references paper (p_id) on update cascade on delete cascade;
alter table exam add constraint exam_cid_class_c_id foreign key (c_id) references class (c_id) on update cascade on delete cascade;
alter table exam_record add constraint er_eid_exam_e_id foreign key (e_id) references exam (e_id) on update cascade on delete cascade;
alter table exam_record add constraint er_qid_qtbk_q_id foreign key (q_id) references question_bank (q_id) on update cascade on delete cascade;
alter table exam_record add constraint er_uid_user_u_id foreign key (uid) references sys_user (uid) on update cascade on delete cascade;