create table Department (
	Abbreviation varchar(4) primary key,
	Name varchar(100) not null unique
);

create table Course (
	courseID int primary key auto_increment,
	DepartmentAbbr varchar(4) not null,
	Name varchar(100) not null,
	Number char(4) not null,
	foreign key (DepartmentAbbr) references Department(Abbreviation)
);

create table Student (
	uID char(7) primary key,
	DepartmentAbbr varchar(4) not null,
	FirstName varchar(100) not null,
	LastName varchar(100) not null,
	DoB date not null,
	foreign key (DepartmentAbbr) references Department(Abbreviation)
);

create table Professor (
	uID char(7) primary key,
	DepartmentAbbr varchar(4) not null,
	FirstName varchar(100) not null,
	LastName varchar(100) not null,
	DoB date not null,
	foreign key (DepartmentAbbr) references Department(Abbreviation)
);

create table Administrator (
	uID char(7) primary key,
	FirstName varchar(100) not null,
	LastName varchar(100) not null,
	DoB date not null
);

create table Class (
	classID int primary key auto_increment,
	Year int unsigned not null,
	Season varchar(100) not null,
	Location varchar(100) not null,
	StartTime time not null,
	EndTime time not null,
	ProfessorID char(7) not null,
	CourseID int not null,
	unique(Year, Season, CourseID),
	foreign key (ProfessorID) references Professor(uID),
	foreign key (CourseID) references Course(courseID)
);

create table AssignmentCategory (
	categoryID int primary key auto_increment,
	classID int not null,
	Weight int CHECK (Weight between 0 and 100),
	Name varchar(100) not null,
	unique(Name, classID),
	foreign key (classID) references Class(classID)
);

create table Assignment (
	assignmentID int primary key auto_increment,
	categoryID int,
	Name varchar(100),
	MaxPoint int,
	Content varchar(8192),
	DueTime datetime,
	foreign key (categoryID) references AssignmentCategory(categoryID)
);

create table Submission (
	studentID char(7),
	assignmentID int,
	Time datetime not null,
	Score int,
	Content varchar(8192) not null,
	primary key (studentID, assignmentID),
	foreign key (studentID) references Student(uID),
	foreign key (assignmentID) references Assignment(assignmentID)
);

create table Enroll (
	studentID char(7),
	classID int,
	Grade varchar(2),
	primary key (studentID, classID),
	foreign key (studentID) references Student(uID),
	foreign key (classID) references Class(classID)
);


