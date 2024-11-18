drop database if exists courseInstructorManagement1;
create database courseInstructorManagement1;
use courseInstructorManagement1;

create table faculties (
    facultyId int auto_increment primary key,
    facultyName varchar(100) not null
);

create table teachers (
    teacherId int auto_increment primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    hireDate date,
    email varchar(100) unique not null,
    teacherName varchar(100) generated always as (concat(firstName, ' ', lastName)) stored unique
);

create table courses (
    courseId int auto_increment primary key,
    courseName varchar(100) not null unique,
    courseDescription text,
    facultyId int,
    foreign key (facultyId) references faculties(facultyId)
);

create table students (
    studentId int auto_increment primary key,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    email varchar(100) unique not null,
    studentName varchar(100) generated always as (concat(firstName, ' ', lastName)) stored unique
);

create table courseSchedule (
    scheduleId int auto_increment primary key,
    courseId int,
    dayOfWeek enum('Понеділок', 'Вівторок', 'Середа', 'Четвер', "П'ятниця", 'Субота') not null,
    startTime time not null,
    endTime time not null,
    foreign key (courseId) references courses(courseId)
);

create table assignments (
    assignmentId int auto_increment primary key,
    courseName varchar(100),
    teacherName varchar(100),
    assignedDate date not null,
    foreign key (courseName) references courses(courseName),
    foreign key (teacherName) references teachers(teacherName)
);

create table courseEnrollment (
    enrollmentId int auto_increment primary key,
    studentName varchar(100),
    courseName varchar(100),
    enrollmentDate date not null,
    foreign key (studentName) references students(studentName),
    foreign key (courseName) references courses(courseName)
);

create table studentGrades (
    gradeId int auto_increment primary key,
    studentName varchar(100),
    courseName varchar(100),
    grade int check (grade between 1 and 5),
    gradedDate date not null,
    foreign key (studentName) references students(studentName),
    foreign key (courseName) references courses(courseName)
);


insert into faculties (facultyName) values
('Факультет інформаційних технологій'),
('Факультет філології'),
('Факультет фізичного виховання');

insert into students (firstName, lastName, email) values
('Микола','Бестюк','mbestiuk@rcit.ukr.education'),
('Олександр', 'Бугайчук','obugaychuk@rcit.ukr.education'),
('Іван', 'Войтюк','ivoityuk@rcit.ukr.education'),
('Максим', 'Дейнека', 'mdeineka@rcit.ukr.education'); 

insert into courses (courseName, courseDescription, facultyId) values
('База диних', 'Основи MySQL', 1),
('Англіська мова', 'Підвищити рівень володіння англійською мовою', 2),
('Українська мова', 'Формування мовної компетенції студентів', 1),
('ЯПЗ', 'Тестування програмного забезпечення', 1),
('АТСД', 'Алгоритми та структури даних', 1),
('Фізкультура', 'Формування активної життєвої позиції студентів', 3),
('Основи програмування', 'Основи програмування та алгоритмічної мови', 1);

insert into teachers (firstName, lastName, hireDate, email) values
('Андрій', 'Ніколаєнко', '2020-01-15', 'a.i.nikolaienko@rcit.ukr.education'),
('Вікторія', 'Гонтар', '2012-08-23', 'v.gontar@rcit.ukr.education'),
('Тамара', 'Вербило', '2010-05-11', 't.verbilo@rcit.ukr.education'),
('Тарас', 'Мельник', '2019-09-12', 't.melnik@rcit.ukr.education'),
('Любов', 'Шостак', '2022-02-28', 'l.shostak@rcit.ukr.education'),
('Іван', 'Конончук', '2013-06-19', 'i.kononchuk@rcit.ukr.education'),
('Олександр', 'Шпортько', '2015-01-10', 'o.shportko@rcit.ukr.education');

insert into assignments (courseName, teacherName, assignedDate) values
('База диних', 'Андрій Ніколаєнко', '2023-09-01'), 
('Англіська мова', 'Вікторія Гонтар', '2023-09-01'), 
('Українська мова', 'Тамара Вербило', '2023-09-01'), 
('ЯПЗ', 'Тарас Мельник', '2023-09-01'), 
('АТСД', 'Любов Шостак', '2023-09-01'), 
('Фізкультура', 'Іван Конончук', '2023-09-01'), 
('Основи програмування', 'Олександр Шпортько', '2023-09-01');

insert into courseSchedule (courseId, dayOfWeek, startTime, endTime) values
(1, 'Понеділок', '08:30:00', '09:50:00'), 
(2, 'Понеділок', '10:00:00', '11:20:00'), 
(3, 'Понеділок', '11:50:00', '13:10:00'),
(4, 'Вівторок', '08:30:00', '09:50:00'), 
(5, 'Вівторок', '10:00:00', '11:20:00'), 
(6, 'Вівторок', '11:50:00', '13:10:00'),
(7, 'Середа', '08:30:00', '09:50:00'), 
(1, 'Середа', '10:00:00', '11:20:00'),
(2, 'Четвер', '08:30:00', '09:50:00'), 
(3, 'Четвер', '10:00:00', '11:20:00'), 
(4, "П'ятниця", '08:30:00', '09:50:00'), 
(5, "П'ятниця", '10:00:00', '11:20:00');

insert into studentGrades (studentName, courseName, grade, gradedDate) values
('Микола Бестюк', 'База диних', 5, '2023-10-01'),
('Олександр Бугайчук', 'База диних', 4, '2023-10-01'),
('Іван Войтюк', 'База диних', 3, '2023-10-01'),
('Максим Дейнека', 'База диних', 5, '2023-10-01'),
('Микола Бестюк', 'Англіська мова', 4, '2023-10-10'),
('Олександр Бугайчук', 'Англіська мова', 5, '2023-10-10'),
('Іван Войтюк', 'Англіська мова', 4, '2023-10-10'),
('Максим Дейнека', 'Англіська мова', 3, '2023-10-10');

select * from teachers;
select * from students;
select * from courses;
select * from assignments;
select * from faculties;
select * from courseSchedule;

select
    courses.courseName as 'Назва курсу',
    courseSchedule.dayOfWeek as 'День',
    CONCAT(courseSchedule.startTime, ' - ', courseSchedule.endTime) as 'Початок-Кінець',
    CONCAT(teachers.firstName, ' ', teachers.lastName) as 'Ім\'я викладача',
    faculties.facultyName as 'Факультет'
from 
    courseSchedule
join 
    courses on courseSchedule.courseId = courses.courseId
join 
    assignments on assignments.courseName = courses.courseName
join 
    teachers on assignments.teacherName = CONCAT(teachers.firstName, ' ', teachers.lastName)
join 
    faculties on courses.facultyId = faculties.facultyId
order by courseSchedule.dayOfWeek;

select 
    students.firstName as 'Ім\'я',
    students.lastName as 'Прізвище',
    courses.courseName as 'Курс',
    faculties.facultyName as 'Факультет',
    studentGrades.grade as 'Оцінка',
    studentGrades.gradedDate as 'Дата оцінювання'
from 
    studentGrades
join 
    students on studentGrades.studentName = concat(students.firstName, ' ', students.lastName)
join 
    courses on studentGrades.courseName = courses.courseName
join 
    faculties on courses.facultyId = faculties.facultyId
order by students.lastName, studentGrades.gradedDate;

insert into studentGrades (studentName, courseName, grade, gradedDate)
select 
    concat(students.firstName, ' ', students.lastName) as studentName,
    courses.courseName,
    round(rand() * (5 - 1) + 1) as grade,
    curdate() as gradedDate
from 
    students
cross join 
    courses
on duplicate key update 
    grade = values(grade),
    gradedDate = values(gradedDate);