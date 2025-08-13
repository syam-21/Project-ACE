-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2025 at 04:16 PM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `question`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--
CREATE DATABASE `question`;
USE `question`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add user', 7, 'add_user'),
(26, 'Can change user', 7, 'change_user'),
(27, 'Can delete user', 7, 'delete_user'),
(28, 'Can view user', 7, 'view_user'),
(29, 'Can add course', 8, 'add_course'),
(30, 'Can change course', 8, 'change_course'),
(31, 'Can delete course', 8, 'delete_course'),
(32, 'Can view course', 8, 'view_course'),
(33, 'Can add response', 9, 'add_response'),
(34, 'Can change response', 9, 'change_response'),
(35, 'Can delete response', 9, 'delete_response'),
(36, 'Can view response', 9, 'view_response'),
(37, 'Can add score', 10, 'add_score'),
(38, 'Can change score', 10, 'change_score'),
(39, 'Can delete score', 10, 'delete_score'),
(40, 'Can view score', 10, 'view_score'),
(41, 'Can add question', 11, 'add_question'),
(42, 'Can change question', 11, 'change_question'),
(43, 'Can delete question', 11, 'delete_question'),
(44, 'Can view question', 11, 'view_question'),
(45, 'Can add quiz', 12, 'add_quiz'),
(46, 'Can change quiz', 12, 'change_quiz'),
(47, 'Can delete quiz', 12, 'delete_quiz'),
(48, 'Can view quiz', 12, 'view_quiz');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(8, 'store', 'course'),
(11, 'store', 'question'),
(12, 'store', 'quiz'),
(9, 'store', 'response'),
(10, 'store', 'score'),
(7, 'store', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-03-13 23:38:14.292231'),
(2, 'auth', '0001_initial', '2025-03-13 23:38:19.576757'),
(3, 'admin', '0001_initial', '2025-03-13 23:38:20.568775'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-03-13 23:38:20.585030'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-13 23:38:20.595999'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-03-13 23:38:21.340459'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-03-13 23:38:22.029064'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-03-13 23:38:22.314178'),
(9, 'auth', '0004_alter_user_username_opts', '2025-03-13 23:38:22.353761'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-03-13 23:38:22.803916'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-03-13 23:38:22.816454'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-03-13 23:38:22.834938'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-03-13 23:38:23.111442'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-03-13 23:38:23.413394'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-03-13 23:38:23.730635'),
(16, 'auth', '0011_update_proxy_permissions', '2025-03-13 23:38:23.782722'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-03-13 23:38:24.066545'),
(18, 'sessions', '0001_initial', '2025-03-13 23:38:24.530797'),
(19, 'store', '0001_initial', '2025-03-23 22:31:58.677103'),
(20, 'store', '0002_user_is_staff_alter_user_userrole', '2025-04-09 21:43:52.189543'),
(21, 'store', '0003_quiz_faculty_name', '2025-04-10 21:51:40.923300'),
(22, 'store', '0004_delete_response', '2025-04-14 13:36:09.352381'),
(23, 'store', '0005_remove_user_userinstitute', '2025-04-14 15:11:55.068662'),
(24, 'store', '0006_remove_user_is_staff', '2025-04-14 15:15:15.391133');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3ixy5m0rsydkjpal7efgn5fiqzqfs41x', 'eyJ1c2VyX2lkIjo4LCJ1c2VybmFtZSI6ImltdGlheiIsImlzX2F1dGhlbnRpY2F0ZWQiOnRydWV9:1u4m2l:EhHh_YGxyRgB3RzkplkW0dH88D56sDAkfZDyAyzqZE0', '2025-04-29 19:34:03.625728'),
('9cw72tcn4o4v0gbinq9fems61yba8qnr', 'eyJ1c2VyX2lkIjo1LCJ1c2VybmFtZSI6ImltdGkiLCJpc19hdXRoZW50aWNhdGVkIjp0cnVlfQ:1u4Qzh:0f3ssLOGXl7F8CtM_YZg51cneE60YO4_zki3y9uQd-s', '2025-04-28 21:05:29.518200'),
('ccmnji2vpea4zid4427pg8j8bjgvwnu0', 'eyJ1c2VyX2lkIjo5LCJ1c2VybmFtZSI6ImFraHRlciIsImlzX2F1dGhlbnRpY2F0ZWQiOnRydWV9:1u98pA:jYFGIra-dpBGZyf3cWjkDUI836uew-bbf6PF-JbyUeI', '2025-05-11 20:42:04.760726'),
('z8f6ucuw7uyy1mrwukglldpx291185vd', 'eyJ1c2VyX2lkIjo5LCJ1c2VybmFtZSI6ImFraHRlciIsImlzX2F1dGhlbnRpY2F0ZWQiOnRydWV9:1u5PIs:HAR4XXc6SI3eLP4mpuRkWBViwhg4jHo5BMd30GIjOLI', '2025-05-01 13:29:18.703698');

-- --------------------------------------------------------

--
-- Table structure for table `store_course`
--

CREATE TABLE `store_course` (
  `CourseID` int(11) NOT NULL,
  `CourseCode` varchar(50) NOT NULL,
  `CourseName` varchar(255) NOT NULL,
  `Description` longtext DEFAULT NULL,
  `Faculty_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_course`
--

INSERT INTO `store_course` (`CourseID`, `CourseCode`, `CourseName`, `Description`, `Faculty_id`) VALUES
(7, 'CSE311', 'Database Management System', 'Learn database design, SQL, normalization, queries, and optimization techniques for efficient data management and storage solutions.', 9),
(8, 'CSE101', 'Introduction to Computer Science', 'Introduction to the field of computer science, focusing on basic programming and problem-solving.', 32),
(9, 'CSE102', 'Programming Fundamentals', 'Introduction to programming using a high-level language like C or Python, with an emphasis on algorithms.', 33),
(10, 'CSE103', 'Discrete Mathematics', 'Study of mathematical structures that are fundamentally discrete rather than continuous.', 34),
(11, 'CSE104', 'Data Structures and Algorithms', 'In-depth study of common data structures and algorithms used in computer science.', 35),
(12, 'CSE105', 'Computer Networks', 'Introduction to computer networking concepts including TCP/IP, OSI model, and network security.', 36),
(13, 'CSE106', 'Database Management Systems', 'Fundamentals of databases, including relational databases, SQL, and normalization techniques.', 37),
(14, 'CSE107', 'Digital Logic Design', 'Introduction to digital circuits, Boolean algebra, and the design of logic gates and circuits.', 38),
(15, 'CSE108', 'Software Engineering', 'Overview of software development lifecycle, project management, and methodologies like Agile and Scrum.', 39),
(16, 'CSE109', 'Operating Systems', 'Study of operating system principles, memory management, file systems, and processes.', 40),
(17, 'CSE110', 'Web Development', 'Web technologies, including HTML, CSS, JavaScript, and building interactive websites.', 41),
(18, 'MATH101', 'Calculus I', 'Introduction to differential and integral calculus, including limits, derivatives, and applications.', 42),
(19, 'MATH102', 'Linear Algebra', 'Study of vector spaces, matrices, and eigenvalues, with applications in computer science and engineering.', 43),
(20, 'ENG101', 'English Communication Skills', 'Focus on reading, writing, listening, and speaking skills to communicate effectively in English.', 44),
(21, 'ENG102', 'Technical Writing', 'Introduction to writing technical documents, such as reports, manuals, and research papers.', 45),
(22, 'BBA101', 'Principles of Management', 'Introduction to management theories, practices, and decision-making strategies.', 46),
(23, 'BBA102', 'Marketing Management', 'Study of marketing principles, market analysis, branding, and consumer behavior.', 47),
(24, 'BBA103', 'Financial Accounting', 'Fundamentals of accounting including balance sheets, income statements, and financial analysis.', 48),
(25, 'BBA104', 'Human Resource Management', 'Overview of human resource practices, including recruitment, training, performance management, and employee relations.', 49),
(26, 'ECO101', 'Microeconomics', 'Study of the principles of microeconomics, focusing on market demand, supply, and pricing mechanisms.', 50),
(27, 'ECO102', 'Macroeconomics', 'Introduction to macroeconomics, including national income, inflation, unemployment, and fiscal policy.', 32);

-- --------------------------------------------------------

--
-- Table structure for table `store_question`
--

CREATE TABLE `store_question` (
  `QuesID` int(11) NOT NULL,
  `QuesText` longtext NOT NULL,
  `Option1` varchar(255) NOT NULL,
  `Option2` varchar(255) NOT NULL,
  `Option3` varchar(255) NOT NULL,
  `Option4` varchar(255) NOT NULL,
  `CorrectAns` smallint(5) UNSIGNED NOT NULL CHECK (`CorrectAns` >= 0),
  `DifficultyLevel` varchar(6) NOT NULL,
  `Quiz_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_question`
--

INSERT INTO `store_question` (`QuesID`, `QuesText`, `Option1`, `Option2`, `Option3`, `Option4`, `CorrectAns`, `DifficultyLevel`, `Quiz_id`) VALUES
(12, 'Which of the following is a database management system (DBMS)?', 'Microsoft Word', 'MySQL', 'Adobe Photoshop', 'Google Chrome', 2, 'easy', 15),
(13, 'What is the primary key in a database used for?', 'To store large amounts of data', 'To uniquely identify records', 'To perform data backups', 'To sort the data', 2, 'easy', 15),
(14, 'Which of the following is the process of organizing data to reduce redundancy?', 'Normalization', 'Encryption', 'Indexing', 'Data Mining', 1, 'easy', 15),
(15, 'Which SQL statement is used to retrieve data from a database?', 'INSERT', 'SELECT', 'DELETE', 'UPDATE', 2, 'easy', 15),
(16, 'What type of relationship does a foreign key establish in a database?', 'One-to-many', 'Many-to-many', 'One-to-one', 'Both one-to-many and many-to-many', 1, 'easy', 15),
(49, 'Which of the following is a valid identifier in C?', '1variable', 'variable1', 'int variable', 'variable-1', 2, 'Easy', 37),
(50, 'What is the output of printf(\"%d\", 10 + 20); in C?', '1020', '30', '102', 'Error', 2, 'Easy', 37),
(51, 'What does the \"break\" statement do in a loop?', 'Stops the loop immediately', 'Skips the current iteration', 'Starts the loop', 'Ends the program', 1, 'Medium', 37),
(52, 'Which of these is a looping structure in C?', 'for', 'function', 'switch', 'if', 1, 'Easy', 37),
(53, 'In C, which of the following is the correct syntax for a function declaration?', 'int function();', 'function int();', 'void function;', 'void function()', 1, 'Easy', 37),
(54, 'What is the purpose of the \"continue\" statement?', 'Exits the loop', 'Skips the current iteration of the loop', 'Starts the loop over', 'Breaks the loop', 2, 'Medium', 37),
(55, 'Which of these data types is used for floating-point numbers in C?', 'int', 'char', 'float', 'long', 3, 'Medium', 37),
(56, 'What is the correct way to define a constant in C?', 'const int x = 5;', 'int const x = 5;', 'constant int x = 5;', 'int x = constant 5;', 1, 'Easy', 37),
(57, 'What is the result of the expression 5 + 3 * 2 in C?', '11', '16', '13', '7', 1, 'Medium', 37),
(58, 'What does \"NULL\" represent in C?', 'Zero', 'Empty string', 'A special character', 'Undefined value', 4, 'Hard', 37),
(59, 'Which of the following is the correct way to allocate memory dynamically in C?', 'malloc()', 'alloc()', 'new', 'calloc()', 1, 'Medium', 37),
(60, 'What is the output of the following code in C: printf(\"%d\", 10 / 3);', '3', '4', 'Error', '3.33', 1, 'Easy', 37),
(61, 'What is a pointer in C?', 'A variable that stores a memory address', 'A special function', 'A loop structure', 'An array', 1, 'Hard', 37),
(62, 'What is the purpose of the \"sizeof\" operator in C?', 'To calculate the size of a data type or variable', 'To find the value of a variable', 'To define a constant', 'To initialize variables', 1, 'Medium', 37),
(63, 'Which header file is required to use the \"printf\" function in C?', 'stdio.h', 'stdlib.h', 'string.h', 'math.h', 1, 'Easy', 37),
(64, 'Which operator is used to compare two values in C?', '==', '=', '>', '<', 1, 'Easy', 37),
(65, 'What does CPU stand for?', 'Central Processing Unit', 'Central Power Unit', 'Computer Personal Unit', 'Central Processing Utility', 1, 'Easy', 38),
(66, 'Which of the following is not an object-oriented programming language?', 'C', 'C++', 'Java', 'Python', 1, 'Medium', 38),
(67, 'What is the primary purpose of an operating system?', 'To manage hardware resources', 'To write code', 'To run applications', 'To provide security', 1, 'Easy', 38),
(68, 'What is an array in programming?', 'A type of loop', 'A collection of variables', 'A conditional statement', 'A function', 2, 'Medium', 38),
(69, 'Which programming language is used to develop iOS applications?', 'Swift', 'Java', 'Python', 'C++', 1, 'Medium', 38),
(70, 'What is the time complexity of linear search?', 'O(log n)', 'O(n)', 'O(1)', 'O(n^2)', 2, 'Medium', 38),
(71, 'What is the output of 3 + 4 * 2?', '14', '11', '7', '13', 1, 'Easy', 38),
(72, 'What is the purpose of a compiler?', 'Translate high-level code to machine code', 'Execute machine code', 'Store data', 'Make system calls', 1, 'Medium', 38),
(73, 'Which data structure uses LIFO (Last In, First Out)?', 'Queue', 'Stack', 'Linked List', 'Array', 2, 'Easy', 38),
(74, 'Which of the following is a valid identifier in Java?', '1variable', 'variable_1', 'int', 'double', 2, 'Easy', 38),
(75, 'Which of these is a programming paradigm?', 'Functional programming', 'Inheritance', 'Polymorphism', 'Abstraction', 1, 'Medium', 38),
(76, 'What is a recursive function?', 'A function that calls itself', 'A function with no parameters', 'A function without a return value', 'A function in a loop', 1, 'Hard', 38),
(77, 'What is the output of the following Python code: print(10 // 3)?', '3', '3.0', '2', '1', 1, 'Medium', 38),
(78, 'What is a class in object-oriented programming?', 'A function', 'A data structure', 'A blueprint for objects', 'A variable', 3, 'Easy', 38),
(79, 'What is the main use of the \"else\" statement in a loop?', 'To continue the loop', 'To stop the loop', 'To execute code if the loop condition is false', 'To execute code if the loop runs successfully', 4, 'Medium', 38),
(80, 'Which of the following is a valid identifier in C?', '1variable', 'variable1', 'int variable', 'variable-1', 2, 'Easy', 39),
(81, 'What is the output of printf(\"%d\", 10 + 20); in C?', '1020', '30', '102', 'Error', 2, 'Easy', 39),
(82, 'What does the \"break\" statement do in a loop?', 'Stops the loop immediately', 'Skips the current iteration', 'Starts the loop', 'Ends the program', 1, 'Medium', 39),
(83, 'Which of these is a looping structure in C?', 'for', 'function', 'switch', 'if', 1, 'Easy', 39),
(84, 'In C, which of the following is the correct syntax for a function declaration?', 'int function();', 'function int();', 'void function;', 'void function()', 1, 'Easy', 39),
(85, 'What is the purpose of the \"continue\" statement?', 'Exits the loop', 'Skips the current iteration of the loop', 'Starts the loop over', 'Breaks the loop', 2, 'Medium', 39),
(86, 'Which of these data types is used for floating-point numbers in C?', 'int', 'char', 'float', 'long', 3, 'Medium', 39),
(87, 'What is the correct way to define a constant in C?', 'const int x = 5;', 'int const x = 5;', 'constant int x = 5;', 'int x = constant 5;', 1, 'Easy', 39),
(88, 'What is the result of the expression 5 + 3 * 2 in C?', '11', '16', '13', '7', 1, 'Medium', 39),
(89, 'What does \"NULL\" represent in C?', 'Zero', 'Empty string', 'A special character', 'Undefined value', 4, 'Hard', 39),
(90, 'Which of the following is the correct way to allocate memory dynamically in C?', 'malloc()', 'alloc()', 'new', 'calloc()', 1, 'Medium', 39),
(91, 'What is the output of the following code in C: printf(\"%d\", 10 / 3);', '3', '4', 'Error', '3.33', 1, 'Easy', 39),
(92, 'What is a pointer in C?', 'A variable that stores a memory address', 'A special function', 'A loop structure', 'An array', 1, 'Hard', 39),
(93, 'What is the purpose of the \"sizeof\" operator in C?', 'To calculate the size of a data type or variable', 'To find the value of a variable', 'To define a constant', 'To initialize variables', 1, 'Medium', 39),
(94, 'Which header file is required to use the \"printf\" function in C?', 'stdio.h', 'stdlib.h', 'string.h', 'math.h', 1, 'Easy', 39),
(95, 'Which operator is used to compare two values in C?', '==', '=', '>', '<', 1, 'Easy', 39),
(96, 'What is the result of the union of {1, 2, 3} and {3, 4, 5}?', '{1, 2, 3, 4, 5}', '{1, 2}', '{3, 4, 5}', '{1, 2, 3}', 1, 'Easy', 40),
(97, 'Which of the following is a valid logical statement?', 'p AND q', 'p OR q', 'p NOT q', 'p XOR q', 1, 'Easy', 40),
(98, 'What is the complement of the set {a, b, c} in the universal set {a, b, c, d, e}?', '{d, e}', '{b, c}', '{a, b}', '{d}', 1, 'Medium', 40),
(99, 'What is the probability of rolling a 3 on a fair 6-sided die?', '1/6', '1/2', '1/3', '1/4', 1, 'Easy', 40),
(100, 'Which of these is a valid equivalence in propositional logic?', 'p AND q = q AND p', 'p AND q = p OR q', 'p OR q = p NOT q', 'None of the above', 1, 'Medium', 40),
(101, 'In a graph, what is the degree of a vertex?', 'The number of edges incident to the vertex', 'The number of vertices connected to it', 'The number of loops', 'None of the above', 1, 'Easy', 40),
(102, 'Which of these is a valid set operation?', 'Intersection', 'Union', 'Difference', 'All of the above', 4, 'Easy', 40),
(103, 'What is the identity element for the operation \"AND\" in Boolean algebra?', '0', '1', 'a', 'None', 2, 'Medium', 40),
(104, 'What is the order of a group?', 'The number of elements in the group', 'The number of operations', 'The number of subsets', 'The number of cosets', 1, 'Hard', 40),
(105, 'Which of the following is a valid Venn diagram?', 'A circle representing a set', 'A square representing a set', 'A line representing a set', 'None of the above', 1, 'Easy', 40),
(106, 'Which is a property of a commutative operation?', 'a * b = b * a', 'a + b = a * b', 'a * b = a', 'None of the above', 1, 'Medium', 40),
(107, 'What does a directed edge represent in a graph?', 'A one-way connection from one vertex to another', 'A two-way connection between two vertices', 'A cycle', 'None of the above', 1, 'Medium', 40),
(108, 'What is the distributive property of Boolean algebra?', 'a AND (b OR c) = (a AND b) OR (a AND c)', 'a OR (b AND c) = (a AND b) OR (a AND c)', 'None of the above', 'Both of the above', 1, 'Medium', 40),
(109, 'What does \"p ⇒ q\" represent in logic?', 'Implication', 'Conjunction', 'Negation', 'Disjunction', 1, 'Easy', 40),
(110, 'Which of the following is not a valid matrix operation?', 'Matrix addition', 'Matrix multiplication', 'Matrix inversion', 'Matrix division', 4, 'Medium', 40),
(111, 'Which data structure is used for implementing depth-first search?', 'Queue', 'Stack', 'Array', 'Linked List', 2, 'Easy', 41),
(112, 'What is the time complexity of quicksort in the average case?', 'O(n^2)', 'O(n log n)', 'O(log n)', 'O(n)', 2, 'Medium', 41),
(113, 'Which of the following is a type of linked list?', 'Singly linked list', 'Doubly linked list', 'Circular linked list', 'All of the above', 4, 'Easy', 41),
(114, 'What is the space complexity of merge sort?', 'O(n)', 'O(log n)', 'O(1)', 'O(n log n)', 1, 'Medium', 41),
(115, 'Which of the following is an application of a stack?', 'Expression evaluation', 'Queueing', 'Memory management', 'Sorting', 1, 'Medium', 41),
(116, 'What is a priority queue?', 'A queue that prioritizes elements based on their value', 'A queue with fixed size', 'A stack-based queue', 'A queue with circular links', 1, 'Medium', 41),
(117, 'What is the time complexity of accessing an element in an array?', 'O(n)', 'O(log n)', 'O(1)', 'O(n log n)', 3, 'Easy', 41),
(118, 'What is a binary tree?', 'A tree with at most two children for each node', 'A tree with multiple branches', 'A graph with weighted edges', 'A hierarchical data structure', 1, 'Easy', 41),
(119, 'Which of the following is not a valid tree traversal method?', 'Pre-order', 'In-order', 'Post-order', 'Random-order', 4, 'Medium', 41),
(120, 'What is the worst-case time complexity of bubble sort?', 'O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)', 3, 'Medium', 41),
(121, 'What is the result of the following operation in a hash table with separate chaining?', 'O(1)', 'O(log n)', 'O(n)', 'O(n log n)', 1, 'Medium', 41),
(122, 'What is a balanced binary search tree?', 'A tree where the difference between the heights of left and right subtrees is at most one', 'A tree with two equal subtrees', 'A tree with a fixed number of nodes', 'A tree that has no leaves', 1, 'Hard', 41),
(123, 'Which of these is a sorting algorithm?', 'Merge sort', 'Binary search', 'Hashing', 'Linked list', 1, 'Medium', 41),
(124, 'What is the purpose of a hash function?', 'To map data to a fixed-size value', 'To sort data', 'To retrieve data from memory', 'To compress data', 1, 'Easy', 41),
(125, 'What is the time complexity of binary search?', 'O(n)', 'O(log n)', 'O(n^2)', 'O(1)', 2, 'Medium', 41),
(126, 'Which data structure is best for implementing a breadth-first search?', 'Stack', 'Queue', 'Array', 'Linked List', 2, 'Medium', 41),
(127, 'What is the derivative of x^2?', '2x', 'x^2', 'x', '2', 1, 'Easy', 42),
(128, 'What is the integral of 1/x?', 'ln(x)', 'x^2', '1/x^2', 'ln(x) + C', 1, 'Medium', 42),
(129, 'What is the limit of 1/x as x approaches infinity?', '0', '1', 'Infinity', 'Undefined', 1, 'Medium', 42),
(130, 'What is the derivative of sin(x)?', 'cos(x)', '-sin(x)', 'tan(x)', 'None of the above', 1, 'Easy', 42),
(131, 'What is the antiderivative of e^x?', 'e^x + C', 'x^2 + C', 'e^x', 'None of the above', 1, 'Easy', 42),
(132, 'What is the integral of x^3?', 'x^4 / 4 + C', 'x^2 / 2 + C', 'x^3 + C', 'x^4 + C', 1, 'Medium', 42),
(133, 'What is the derivative of cos(x)?', '-sin(x)', 'cos(x)', 'tan(x)', 'None of the above', 1, 'Medium', 42),
(134, 'What is the value of the derivative of x at x = 0?', '1', '0', '-1', 'Undefined', 2, 'Easy', 42),
(135, 'What is the integral of 1?', 'x + C', 'x^2 + C', 'ln(x) + C', 'None of the above', 1, 'Easy', 42),
(136, 'What is the slope of the tangent line at x = 0 for the function y = x^2?', '0', '1', '2', 'Undefined', 1, 'Medium', 42),
(137, 'What is the limit of sin(x)/x as x approaches 0?', '1', '0', 'Infinity', 'Undefined', 1, 'Hard', 42),
(138, 'What is the integral of cos(x)?', 'sin(x)', 'x + C', 'cos(x)', 'ln(x)', 1, 'Medium', 42),
(139, 'What is the derivative of ln(x)?', '1/x', 'x', 'ln(x)', 'x^2', 1, 'Medium', 42),
(140, 'What is the integral of x^2?', 'x^3 / 3 + C', 'x^3 + C', '2x + C', 'x^2 + C', 1, 'Easy', 42),
(141, 'What is the derivative of tan(x)?', 'sec^2(x)', 'sec(x)', 'csc^2(x)', 'None of the above', 1, 'Hard', 42),
(142, 'What is the determinant of a 2x2 matrix [[a, b], [c, d]]?', 'ad - bc', 'ad + bc', 'a + d', 'a - b', 1, 'Easy', 43),
(143, 'What is the rank of a matrix?', 'The number of linearly independent rows', 'The sum of all elements', 'The number of non-zero elements', 'The number of columns', 1, 'Medium', 43),
(144, 'Which of the following is not a property of matrix multiplication?', 'Commutative', 'Associative', 'Distributive', 'None of the above', 1, 'Hard', 43),
(145, 'What is the inverse of a 2x2 matrix [[a, b], [c, d]]?', '[[d, -b], [-c, a]]', '[[a, b], [c, d]]', '[[a, -b], [-c, d]]', 'None of the above', 1, 'Medium', 43),
(146, 'What is the solution to the system of equations x + y = 5 and 2x + y = 8?', 'x = 3, y = 2', 'x = 4, y = 1', 'x = 2, y = 3', 'x = 1, y = 4', 1, 'Medium', 43),
(147, 'What is the eigenvalue of a matrix?', 'A scalar that satisfies the equation Ax = λx', 'A matrix that satisfies the equation Ax = λx', 'A diagonal element of the matrix', 'A matrix whose determinant is 1', 1, 'Hard', 43),
(148, 'Which of the following is a vector space?', 'The set of all 2D vectors', 'The set of all positive integers', 'The set of all real numbers', 'The set of all matrices', 1, 'Easy', 43),
(149, 'What is a linear transformation?', 'A function that preserves vector addition and scalar multiplication', 'A function that maps vectors to scalars', 'A function that multiplies a vector by a constant', 'None of the above', 1, 'Medium', 43),
(150, 'What is the dot product of two vectors?', 'The sum of the products of their corresponding components', 'The sum of their magnitudes', 'The difference between their magnitudes', 'None of the above', 1, 'Easy', 43),
(151, 'What is the inverse of a matrix used for?', 'To solve linear systems', 'To multiply matrices', 'To find eigenvalues', 'To compute determinants', 1, 'Medium', 43),
(152, 'What is the characteristic equation of a matrix?', 'det(A - λI) = 0', 'det(A + λI) = 0', 'A = λI', 'None of the above', 1, 'Hard', 43),
(153, 'Which of the following is true for the matrix multiplication of A and B?', 'AB = BA', 'AB = A + B', 'AB = B + A', 'None of the above', 4, 'Hard', 43),
(154, 'What is the trace of a matrix?', 'The sum of its diagonal elements', 'The sum of its off-diagonal elements', 'The determinant', 'The inverse of the matrix', 1, 'Medium', 43),
(155, 'What is a matrix eigenvector?', 'A vector that does not change direction under the matrix transformation', 'A vector that spans the matrix', 'A scalar that scales the matrix', 'None of the above', 1, 'Easy', 43),
(156, 'What is the adjoint of a matrix?', 'The transpose of the cofactor matrix', 'The inverse of the matrix', 'The determinant of the matrix', 'None of the above', 1, 'Medium', 43),
(157, 'Which of the following is true for an orthogonal matrix?', 'A * A^T = I', 'A * A = I', 'A^T = A^-1', 'None of the above', 1, 'Hard', 43),
(158, 'Which of the following is a correct use of \"there\"?', 'There are many books on the table.', 'There is my car.', 'There I saw him.', 'None of the above', 1, 'Easy', 44),
(159, 'Which sentence uses a passive voice?', 'The book was read by John.', 'John read the book.', 'I read the book.', 'None of the above', 1, 'Medium', 44),
(160, 'What is the proper way to use a semicolon?', 'To connect two independent clauses', 'To list items in a series', 'To separate items in a list', 'None of the above', 1, 'Easy', 44),
(161, 'Which of the following is correct punctuation for a question?', 'Are you coming to the party?', 'Are you coming to the party', 'Are you coming, to the party?', 'None of the above', 1, 'Easy', 44),
(162, 'Which of these is an example of a compound sentence?', 'I like coffee, but she likes tea.', 'I like coffee.', 'I like tea and coffee.', 'None of the above', 1, 'Medium', 44),
(163, 'Which of the following is correct?', 'I have lived here for five years.', 'I have lived here since five years.', 'I have been lived here for five years.', 'None of the above', 1, 'Medium', 44),
(164, 'What is the difference between \"affect\" and \"effect\"?', 'Affect is a verb, effect is a noun', 'Affect is a noun, effect is a verb', 'Both are nouns', 'Both are verbs', 1, 'Medium', 44),
(165, 'Which sentence uses the word \"fewer\" correctly?', 'I have fewer books than you.', 'I have less books than you.', 'I have less water.', 'None of the above', 1, 'Easy', 44),
(166, 'Which of the following is a correct use of a comma?', 'I want to go, but I don’t have time.', 'I want to go but, I don’t have time.', 'I want to go but I, don’t have time.', 'None of the above', 1, 'Easy', 44),
(167, 'What is the correct form of the verb in the sentence: \"She _____ to school every day.\"?', 'goes', 'gone', 'going', 'go', 1, 'Easy', 44),
(168, 'Which of these sentences is an example of a question tag?', 'She is coming, isn’t she?', 'She is coming she?', 'Is she coming?', 'None of the above', 1, 'Medium', 44),
(169, 'Which of these is an example of direct speech?', 'She said, \"I am going to the store.\"', 'She said she is going to the store.', 'She went to the store.', 'None of the above', 1, 'Medium', 44),
(170, 'What is the correct form of the verb in the sentence: \"I _____ the project.\"?', 'completed', 'completing', 'complete', 'completes', 1, 'Easy', 44),
(171, 'Which sentence uses the word \"principle\" correctly?', 'He is a man of principle.', 'He is a man of principal.', 'He is a principle of the company.', 'None of the above', 1, 'Medium', 44),
(172, 'Which of these is a correct example of an idiomatic expression?', 'It’s raining cats and dogs.', 'I’m feeling blue.', 'It’s time to hit the hay.', 'All of the above', 4, 'Easy', 44),
(173, 'Which of the following is an example of a technical document?', 'User manual', 'Novel', 'Diary', 'Magazine', 1, 'Easy', 45),
(174, 'What is the primary purpose of a technical report?', 'To convey information clearly and accurately', 'To entertain readers', 'To express personal opinions', 'None of the above', 1, 'Medium', 45),
(175, 'What is the difference between a report and an article?', 'Reports are factual, articles may be opinion-based', 'Reports are short, articles are long', 'Articles are objective, reports are subjective', 'None of the above', 1, 'Medium', 45),
(176, 'Which of the following is an important element of technical writing?', 'Clarity', 'Brevity', 'Accuracy', 'All of the above', 4, 'Easy', 45),
(177, 'What is an example of an effective writing technique for technical writing?', 'Using simple, clear language', 'Using complex jargon', 'Using humor', 'Using irrelevant information', 1, 'Medium', 45),
(178, 'What should be included in the introduction of a technical document?', 'The purpose of the document', 'A detailed analysis', 'The conclusion', 'None of the above', 1, 'Medium', 45),
(179, 'What is the ideal tone for a technical document?', 'Formal and objective', 'Casual and personal', 'Humorous and informal', 'None of the above', 1, 'Easy', 45),
(180, 'Which of the following is a good practice in technical writing?', 'Avoid unnecessary details', 'Include as much information as possible', 'Use passive voice', 'Avoid illustrations', 1, 'Medium', 45),
(181, 'What is the role of a conclusion in a technical document?', 'To summarize key points and suggest actions', 'To introduce new topics', 'To entertain the reader', 'None of the above', 1, 'Easy', 45),
(182, 'What type of information is typically included in a technical specification?', 'Technical details about a product or system', 'Personal stories', 'Historical background', 'None of the above', 1, 'Medium', 45),
(183, 'What is an example of a visual aid used in technical writing?', 'Graph', 'Story', 'Poem', 'None of the above', 1, 'Easy', 45),
(184, 'Which of these is a characteristic of a well-written technical document?', 'It is concise and to the point', 'It is long and descriptive', 'It is written in a casual tone', 'None of the above', 1, 'Easy', 45),
(185, 'Why is formatting important in technical writing?', 'It makes the document easy to read and understand', 'It makes the document look pretty', 'It makes the document shorter', 'None of the above', 1, 'Medium', 45),
(186, 'What is the most important thing to consider when writing for a technical audience?', 'Providing accurate and relevant information', 'Being humorous', 'Using difficult language', 'None of the above', 1, 'Medium', 45),
(187, 'What is the role of editing in technical writing?', 'To ensure the document is clear, concise, and error-free', 'To make the document more colorful', 'To add personal opinions', 'None of the above', 1, 'Medium', 45),
(188, 'What is the primary goal of management?', 'To achieve organizational goals efficiently', 'To increase profit', 'To hire more employees', 'To avoid conflict', 1, 'Easy', 46),
(189, 'Which of the following is not a function of management?', 'Planning', 'Organizing', 'Motivating', 'Selling', 4, 'Medium', 46),
(190, 'Which of these is a key element of the planning function?', 'Setting objectives', 'Firing employees', 'Reducing costs', 'Hiring new managers', 1, 'Easy', 46),
(191, 'What is the purpose of the organizing function of management?', 'To arrange resources and tasks', 'To plan the company’s future', 'To motivate employees', 'To evaluate performance', 1, 'Medium', 46),
(192, 'What does the controlling function in management involve?', 'Monitoring and evaluating performance', 'Setting long-term goals', 'Hiring employees', 'Designing product marketing', 1, 'Easy', 46),
(193, 'What is the concept of leadership in management?', 'Inspiring and motivating employees to achieve goals', 'Directing employees to complete tasks', 'Creating policies for the organization', 'Managing financial resources', 1, 'Medium', 46),
(194, 'Which of the following is an example of a democratic leadership style?', 'A leader who encourages team participation in decision-making', 'A leader who makes all decisions independently', 'A leader who focuses on enforcing rules', 'A leader who is overly hands-off', 1, 'Medium', 46),
(195, 'What is the difference between a manager and a leader?', 'Managers focus on administration, leaders focus on vision', 'Managers lead teams, leaders manage tasks', 'Managers are involved in strategy, leaders are involved in operations', 'There is no difference', 1, 'Medium', 46),
(196, 'What is strategic planning in management?', 'Long-term planning for achieving major organizational goals', 'Short-term planning for specific tasks', 'Planning for training employees', 'Planning for marketing campaigns', 1, 'Easy', 46),
(197, 'Which of the following is an example of a SWOT analysis?', 'Identifying strengths, weaknesses, opportunities, and threats', 'Creating a project schedule', 'Setting a product price', 'Developing an organizational chart', 1, 'Medium', 46),
(198, 'What is the purpose of financial planning in management?', 'To allocate financial resources effectively', 'To motivate employees', 'To create customer loyalty', 'To establish company values', 1, 'Medium', 46),
(199, 'What is an important trait of effective communication in management?', 'Clarity and conciseness', 'Loudness', 'Being authoritative', 'Frequent emails', 1, 'Easy', 46),
(200, 'What is the primary goal of human resource management?', 'To recruit and retain skilled employees', 'To create new marketing strategies', 'To analyze competitors', 'To reduce operational costs', 1, 'Easy', 46),
(201, 'Which of the following is a characteristic of a good manager?', 'Ability to make decisions', 'Ability to ignore team input', 'Ability to avoid conflict', 'Ability to avoid accountability', 1, 'Medium', 46),
(202, 'Which leadership style focuses on making decisions without consulting others?', 'Autocratic leadership', 'Democratic leadership', 'Transformational leadership', 'Servant leadership', 1, 'Medium', 46),
(203, 'What is a common challenge managers face?', 'Managing conflict', 'Ignoring deadlines', 'Avoiding feedback', 'Increasing competition', 1, 'Medium', 46),
(204, 'What is the main objective of marketing?', 'To create customer value and satisfaction', 'To increase production', 'To reduce costs', 'To expand the market share', 1, 'Easy', 47),
(205, 'Which of the following is not a component of the marketing mix?', 'Product', 'Price', 'Promotion', 'Profit', 4, 'Medium', 47),
(206, 'What is market segmentation?', 'Dividing a market into smaller groups of consumers with similar needs', 'A strategy to increase product prices', 'Analyzing competition', 'Setting promotional offers', 1, 'Easy', 47),
(207, 'What is the primary purpose of a brand?', 'To differentiate a product or service from others', 'To lower costs', 'To increase profit margins', 'To manage inventory', 1, 'Easy', 47),
(208, 'Which of the following is a strategy used in product positioning?', 'Targeting specific customer segments', 'Reducing product prices', 'Increasing product quality', 'All of the above', 1, 'Medium', 47),
(209, 'What is a product life cycle?', 'The stages a product goes through from introduction to decline', 'The amount of time a product is available for sale', 'The stages of production in a factory', 'The time taken to manufacture a product', 1, 'Medium', 47),
(210, 'Which of these is a pricing strategy?', 'Penetration pricing', 'Skimming pricing', 'Value-based pricing', 'All of the above', 4, 'Medium', 47),
(211, 'What is the difference between advertising and sales promotion?', 'Advertising creates awareness, while sales promotion creates short-term incentives', 'Sales promotion is about public relations', 'Advertising is a long-term strategy', 'None of the above', 1, 'Medium', 47),
(212, 'What is the role of public relations in marketing?', 'To maintain a positive public image', 'To create advertisements', 'To manage sales campaigns', 'To improve product design', 1, 'Easy', 47),
(213, 'What is customer relationship management (CRM)?', 'Managing interactions with existing and potential customers', 'Managing financial records', 'Creating product designs', 'Managing inventory levels', 1, 'Medium', 47),
(214, 'What does SWOT analysis stand for?', 'Strengths, Weaknesses, Opportunities, Threats', 'Systems, Webs, Outputs, Targets', 'Standardized Workflow Optimization Techniques', 'Sales With Optimal Targeting', 1, 'Easy', 47),
(215, 'What is the main focus of market research?', 'To gather data on consumer behavior and preferences', 'To create advertisements', 'To monitor inventory', 'To improve customer service', 1, 'Medium', 47),
(216, 'Which of the following is a form of digital marketing?', 'Search engine optimization (SEO)', 'Direct mail', 'Television advertisements', 'Radio commercials', 1, 'Easy', 47),
(217, 'What is customer loyalty?', 'The tendency of customers to repeat purchases from the same brand', 'The process of getting new customers', 'The price customers are willing to pay for a product', 'The time customers spend on a website', 1, 'Medium', 47),
(218, 'What is a unique selling proposition (USP)?', 'A distinct benefit that makes a product stand out from competitors', 'A special promotional offer', 'A discount strategy', 'None of the above', 1, 'Medium', 47),
(219, 'What is the accounting equation?', 'Assets = Liabilities + Equity', 'Assets = Equity - Liabilities', 'Assets + Liabilities = Equity', 'Assets = Liabilities - Equity', 1, 'Easy', 48),
(220, 'Which of the following is a type of financial statement?', 'Balance sheet', 'Income statement', 'Cash flow statement', 'All of the above', 4, 'Easy', 48),
(221, 'What is a journal entry in accounting?', 'A record of financial transactions', 'A list of financial assets', 'A summary of income and expenses', 'A record of assets only', 1, 'Medium', 48),
(222, 'What is a liability in accounting?', 'An obligation owed to others', 'An asset owned by the company', 'Revenue generated by the company', 'A document that tracks expenses', 1, 'Easy', 48),
(223, 'Which of these is considered a current asset?', 'Cash', 'Land', 'Buildings', 'Goodwill', 1, 'Medium', 48),
(224, 'What is the purpose of depreciation in accounting?', 'To allocate the cost of an asset over its useful life', 'To increase the value of an asset', 'To calculate profit', 'To pay taxes', 1, 'Medium', 48),
(225, 'Which of the following represents the owners’ equity?', 'Assets - Liabilities', 'Assets + Liabilities', 'Income - Expenses', 'Revenue - Expenses', 1, 'Medium', 48),
(226, 'What is a balance sheet used for?', 'To show the financial position of a company', 'To summarize income and expenses', 'To record transactions', 'To track assets only', 1, 'Easy', 48),
(227, 'What is accrual accounting?', 'Recording revenue and expenses when they are incurred, not when cash is received or paid', 'Recording transactions when cash is received', 'Recording revenue only when cash is paid', 'Recording revenue only when cash is received', 1, 'Medium', 48),
(228, 'What is the purpose of a trial balance?', 'To ensure that debits equal credits', 'To calculate profit and loss', 'To determine tax obligations', 'To record journal entries', 1, 'Medium', 48),
(229, 'What is the difference between gross profit and net profit?', 'Gross profit is calculated before taxes, while net profit is after taxes', 'Net profit is higher than gross profit', 'Gross profit includes overheads, net profit does not', 'There is no difference', 1, 'Medium', 48),
(230, 'What is a cash flow statement?', 'A financial statement that shows the cash inflows and outflows', 'A document that lists all expenses', 'A report that shows net income', 'A summary of liabilities', 1, 'Easy', 48),
(231, 'Which of the following is not an operating activity on a cash flow statement?', 'Issuing stock', 'Receiving payments from customers', 'Paying for employee salaries', 'Paying for utilities', 1, 'Medium', 48),
(232, 'What is the purpose of an income statement?', 'To show a company’s profitability over a period of time', 'To show the financial position of a company', 'To record transactions', 'To track cash flow', 1, 'Easy', 48),
(233, 'What is the principle of conservatism in accounting?', 'Recognizing expenses and liabilities as soon as possible, but revenues only when they are certain', 'Recording all expenses as assets', 'Recording revenues immediately', 'None of the above', 1, 'Medium', 48),
(234, 'What is the primary function of human resource management?', 'To manage employee relations', 'To recruit and hire new employees', 'To improve marketing strategies', 'To manage finances', 2, 'Easy', 49),
(235, 'Which of the following is a type of employee training?', 'On-the-job training', 'Online webinars', 'Self-learning', 'All of the above', 4, 'Medium', 49),
(236, 'What is a job description?', 'A document that outlines the responsibilities of a specific role', 'A list of company policies', 'A financial report', 'A marketing strategy', 1, 'Easy', 49),
(237, 'What is the purpose of performance appraisals?', 'To assess and improve employee performance', 'To assess the company’s profit', 'To evaluate marketing strategies', 'To calculate taxes', 1, 'Medium', 49),
(238, 'What is an employee benefits package?', 'Non-wage compensation offered to employees', 'A salary increase', 'A one-time bonus', 'Training sessions', 1, 'Easy', 49),
(239, 'What is the purpose of recruitment?', 'To find the right candidate for a job', 'To improve employee relations', 'To provide compensation', 'To manage payroll', 1, 'Easy', 49),
(240, 'Which of these is an example of a non-monetary benefit?', 'Health insurance', 'Free coffee', 'Paid time off', 'All of the above', 2, 'Medium', 49),
(241, 'What is the role of HR in employee retention?', 'To improve employee satisfaction and engagement', 'To track employee attendance', 'To monitor salaries', 'To handle administrative tasks', 1, 'Medium', 49),
(242, 'What is the meaning of \"employee engagement\"?', 'The emotional commitment of employees to the organization', 'The number of employees hired in a company', 'The salary paid to employees', 'The training employees receive', 1, 'Medium', 49),
(243, 'What is a grievance procedure?', 'A formal process for employees to raise issues or complaints', 'A performance review', 'A recruitment process', 'A performance appraisal', 1, 'Easy', 49),
(244, 'What is succession planning?', 'The process of identifying and developing future leaders', 'The process of hiring new employees', 'The process of promoting employees', 'The process of terminating employees', 1, 'Medium', 49),
(245, 'What is the role of HR in employee health and safety?', 'To ensure that the workplace is safe for employees', 'To track employee attendance', 'To handle payroll', 'To provide benefits', 1, 'Easy', 49),
(246, 'Which of these is an example of a leadership development program?', 'Training for future leaders', 'Recruitment for new employees', 'Health and wellness programs', 'None of the above', 1, 'Medium', 49),
(247, 'What is the importance of workplace diversity?', 'To improve creativity and innovation', 'To maintain employee satisfaction', 'To improve communication', 'All of the above', 4, 'Medium', 49),
(248, 'What is an exit interview?', 'A meeting between an employee and HR when the employee leaves the company', 'A performance appraisal', 'A job interview', 'A recruitment process', 1, 'Medium', 49),
(249, 'What is the law of demand?', 'As the price increases, demand decreases', 'As the price increases, demand increases', 'As the price decreases, demand decreases', 'Demand is constant regardless of price', 1, 'Easy', 50),
(250, 'Which of the following is a characteristic of perfect competition?', 'Many buyers and sellers, identical products', 'One seller and many buyers', 'Few buyers and few sellers', 'Products are differentiated', 1, 'Medium', 50),
(251, 'What does elasticity of demand measure?', 'The responsiveness of quantity demanded to a change in price', 'The total demand for a good', 'The availability of substitutes', 'The quantity supplied at a given price', 1, 'Easy', 50),
(252, 'What is the main goal of a firm in microeconomics?', 'To maximize profit', 'To increase market share', 'To reduce costs', 'To increase production', 1, 'Easy', 50),
(253, 'Which of the following is an example of a public good?', 'National defense', 'A private car', 'A house', 'A smartphone', 1, 'Medium', 50),
(254, 'What is the principle of diminishing marginal utility?', 'As consumption increases, the additional satisfaction from each additional unit decreases', 'The more a good is consumed, the greater the satisfaction from it', 'Utility is constant across all units of a good', 'None of the above', 1, 'Medium', 50),
(255, 'What is a monopoly?', 'A market with a single seller and many buyers', 'A market with many buyers and sellers', 'A market where all goods are identical', 'A market with a few dominant firms', 1, 'Easy', 50),
(256, 'Which of the following describes the production function?', 'The relationship between input and output in production', 'The cost of production per unit', 'The price of a product in the market', 'The level of competition in the market', 1, 'Medium', 50),
(257, 'What is the opportunity cost?', 'The cost of forgoing the next best alternative when making a decision', 'The total cost of production', 'The fixed cost of production', 'The cost of labor', 1, 'Easy', 50),
(258, 'What is the concept of marginal cost?', 'The additional cost of producing one more unit of a good', 'The total cost of production', 'The cost of fixed inputs', 'The cost of variable inputs', 1, 'Medium', 50),
(259, 'What is a price floor?', 'A minimum price set by the government', 'A maximum price set by the government', 'The equilibrium price', 'The price at which a firm maximizes its profit', 1, 'Medium', 50),
(260, 'What is the income effect in microeconomics?', 'The change in quantity demanded due to a change in real income from a price change', 'The change in quantity demanded due to a change in price', 'The substitution of one good for another', 'None of the above', 1, 'Medium', 50),
(261, 'What is the meaning of supply and demand?', 'The amount of a good producers are willing to sell at different prices', 'The total demand in the market', 'The quantity of a good available', 'The price at which goods are sold', 1, 'Easy', 50),
(262, 'What is the role of government in a market economy?', 'To correct market failures and regulate industries', 'To control all prices and wages', 'To provide free goods to the public', 'To eliminate competition', 1, 'Medium', 50),
(263, 'What is the effect of a tax on consumers and producers in a market?', 'It increases the price for consumers and reduces the price for producers', 'It reduces the price for consumers and increases the price for producers', 'It increases the price for both consumers and producers', 'It decreases the price for both consumers and producers', 3, 'Hard', 50),
(264, 'What does a price ceiling lead to?', 'Shortage of goods', 'Surplus of goods', 'Equilibrium in the market', 'Increase in production', 1, 'Medium', 50),
(265, 'What is the primary objective of macroeconomics?', 'To study the behavior of the overall economy', 'To analyze individual markets', 'To determine the price of specific goods', 'To focus on production costs', 1, 'Easy', 51),
(266, 'What is GDP?', 'Gross Domestic Product', 'Gross Discount Price', 'Gross Demand Price', 'Gross Development Product', 1, 'Easy', 51),
(267, 'What is the difference between nominal and real GDP?', 'Nominal GDP is not adjusted for inflation, while real GDP is', 'Real GDP is adjusted for inflation, while nominal GDP is not', 'Nominal GDP includes government spending, real GDP does not', 'There is no difference', 1, 'Medium', 51),
(268, 'What is fiscal policy?', 'Government spending and taxation policies', 'The central bank’s control over money supply', 'The study of consumer behavior', 'The regulation of exchange rates', 1, 'Easy', 51),
(269, 'What is monetary policy?', 'Central bank actions to regulate money supply', 'Government policies to increase employment', 'Actions to regulate the stock market', 'Government taxation policies', 1, 'Easy', 51),
(270, 'Which of the following is considered a tool of fiscal policy?', 'Government spending', 'Interest rates', 'Open market operations', 'Money supply', 1, 'Medium', 51),
(271, 'What does the Phillips curve show?', 'The inverse relationship between inflation and unemployment', 'The direct relationship between inflation and output', 'The relationship between money supply and interest rates', 'The inverse relationship between tax rates and employment', 1, 'Medium', 51),
(272, 'What is the unemployment rate?', 'The percentage of the labor force that is unemployed and actively seeking work', 'The number of people employed', 'The percentage of people receiving unemployment benefits', 'The number of people retired', 1, 'Easy', 51),
(273, 'What is inflation?', 'The general increase in prices over time', 'The decrease in the value of currency', 'The increase in government spending', 'The decrease in production', 1, 'Easy', 51),
(274, 'What is the natural rate of unemployment?', 'The level of unemployment that is expected in an economy due to frictional and structural factors', 'The unemployment rate during a recession', 'The unemployment rate during an expansion', 'The rate at which the economy should operate', 1, 'Medium', 51),
(275, 'Which of the following is a cause of inflation?', 'Increase in demand for goods and services', 'Increase in the money supply', 'Decrease in the supply of goods and services', 'All of the above', 4, 'Medium', 51),
(276, 'What is the business cycle?', 'Fluctuations in economic activity over time', 'A stable period of economic growth', 'The cycle of product production', 'None of the above', 1, 'Easy', 51),
(277, 'What is a recession?', 'A period of negative economic growth', 'A period of rapid economic growth', 'A period of high inflation', 'A period of low interest rates', 1, 'Medium', 51),
(278, 'What is the role of the central bank in controlling inflation?', 'By controlling interest rates and money supply', 'By setting taxes', 'By regulating wages', 'By controlling wages and prices', 1, 'Medium', 51),
(279, 'What is a government budget deficit?', 'When government spending exceeds tax revenues', 'When tax revenues exceed government spending', 'When the government has no debt', 'When the economy is in a recession', 1, 'Easy', 51),
(280, 'What is the balance of payments?', 'A record of all economic transactions between residents of a country and the rest of the world', 'A balance sheet for the government', 'The difference between exports and imports', 'The balance between private and public sector investments', 1, 'Medium', 51),
(281, 'What is the difference between fiscal and monetary policy?', 'Fiscal policy involves government spending and taxation, while monetary policy involves controlling the money supply and interest rates', 'Fiscal policy involves regulating inflation, while monetary policy deals with employment', 'Fiscal policy is handled by the central bank, while monetary policy is managed by the government', 'There is no difference', 1, 'Hard', 51),
(282, 'What is the integral of sin(x)?', '-cos(x)', 'cos(x)', 'sin(x)', 'tan(x)', 1, 'Medium', 52),
(283, 'What is the derivative of ln(x)?', '1/x', 'x', 'x^2', 'ln(x)', 1, 'Easy', 52),
(284, 'What is the integral of x^2?', 'x^3/3', 'x^3', 'x^2/2', 'x^4/4', 1, 'Easy', 52),
(285, 'What is the result of the limit of sin(x)/x as x approaches 0?', '1', '0', 'Infinity', 'Undefined', 1, 'Easy', 52),
(286, 'What is the second derivative of x^2?', '2', '0', '4x', '2x', 1, 'Easy', 52),
(287, 'What is the derivative of e^x?', 'e^x', 'x', 'e', 'ln(x)', 1, 'Medium', 52),
(288, 'What is the area under a curve from x = a to x = b?', 'The definite integral of the function', 'The derivative of the function', 'The slope of the function', 'The maximum value of the function', 1, 'Easy', 52),
(289, 'What is the chain rule in calculus?', 'The derivative of a composite function', 'The integral of a composite function', 'The product of two functions', 'None of the above', 1, 'Medium', 52),
(290, 'What is the antiderivative of cos(x)?', 'sin(x)', '-sin(x)', 'cos(x)', 'None of the above', 1, 'Medium', 52),
(291, 'What does the Fundamental Theorem of Calculus state?', 'The integral and derivative are inverse operations', 'The derivative of a constant is zero', 'The integral of 1 is x', 'The derivative of sin(x) is cos(x)', 1, 'Medium', 52),
(292, 'What is the result of the limit of (1/x) as x approaches infinity?', '0', '1', 'Infinity', 'Undefined', 1, 'Medium', 52),
(293, 'What is the integral of 1/x?', 'ln(x)', 'x^2', 'x', '1/x', 1, 'Medium', 52),
(294, 'What is the derivative of tan(x)?', 'sec^2(x)', 'sec(x)', 'csc^2(x)', 'None of the above', 1, 'Medium', 52),
(295, 'What is the result of the integral of 1?', 'x', '1', 'x^2', 'None of the above', 1, 'Easy', 52),
(296, 'What is the power rule for derivatives?', 'd/dx(x^n) = n*x^(n-1)', 'd/dx(x^n) = n*x^n', 'd/dx(x^n) = n*x^(n+1)', 'None of the above', 1, 'Medium', 52),
(297, 'What is the integral of e^(-x^2)?', 'It cannot be expressed in elementary functions', 'x^2 + C', 'e^(-x^2)', 'None of the above', 1, 'Hard', 52),
(298, 'What is the objective of linear programming?', 'To maximize or minimize a linear objective function', 'To solve a quadratic equation', 'To find the roots of a polynomial', 'To minimize nonlinear functions', 1, 'Easy', 53),
(299, 'What are the constraints in linear programming?', 'Linear inequalities that restrict the feasible region', 'Nonlinear inequalities', 'Equalities', 'None of the above', 1, 'Easy', 53),
(300, 'What is the feasible region in linear programming?', 'The area where all constraints are satisfied', 'The area where the objective function is maximized', 'The area outside the constraints', 'None of the above', 1, 'Medium', 53),
(301, 'What is the simplex method used for?', 'Solving linear programming problems', 'Solving quadratic equations', 'Finding the roots of polynomials', 'None of the above', 1, 'Medium', 53),
(302, 'What does the term \"binding constraint\" refer to in linear programming?', 'A constraint that directly affects the optimal solution', 'A constraint that does not affect the optimal solution', 'A constraint that is violated', 'None of the above', 1, 'Medium', 53),
(303, 'What is an objective function in linear programming?', 'A function that needs to be maximized or minimized', 'A function that defines the constraints', 'A function that defines the feasible region', 'None of the above', 1, 'Easy', 53),
(304, 'Which method is commonly used to solve linear programming problems?', 'Simplex method', 'Newton’s method', 'Bisection method', 'Euler’s method', 1, 'Medium', 53),
(305, 'What is the graphical method in linear programming?', 'A method used for solving problems with two variables', 'A method used for solving systems of nonlinear equations', 'A method for finding integer solutions', 'None of the above', 1, 'Easy', 53),
(306, 'What is the dual of a linear programming problem?', 'A problem derived from the original problem using its constraints and objective function', 'A problem that solves for all the variables', 'A problem that has only one solution', 'None of the above', 1, 'Medium', 53),
(307, 'What is a slack variable in linear programming?', 'A variable used to transform inequalities into equalities', 'A variable representing the objective function', 'A variable that represents the maximum value of the function', 'None of the above', 1, 'Medium', 53),
(308, 'What is a corner point solution?', 'The point where two or more constraints intersect', 'A point where the objective function is maximized', 'A point where the feasible region is empty', 'None of the above', 1, 'Easy', 53),
(309, 'What is the meaning of \"optimal solution\" in linear programming?', 'The best solution that satisfies all constraints and maximizes or minimizes the objective function', 'The solution that satisfies only some constraints', 'The first solution found', 'None of the above', 1, 'Easy', 53),
(310, 'What is the simplex algorithm used for?', 'Finding the optimal solution of a linear programming problem', 'Finding the roots of nonlinear equations', 'Solving integer programming problems', 'None of the above', 1, 'Medium', 53),
(311, 'Which of these is an assumption in linear programming?', 'Proportionality between decision variables', 'Nonlinearity of constraints', 'Infinite number of solutions', 'None of the above', 1, 'Medium', 53),
(312, 'What is the duality theorem in linear programming?', 'The optimal solution of a linear programming problem is the same as that of its dual problem', 'The objective function always has multiple solutions', 'The constraints do not affect the solution', 'None of the above', 1, 'Hard', 53),
(313, 'What is the derivative of e^x?', 'e^x', 'x', '2x', 'e', 1, 'Easy', 54),
(314, 'What is the integral of 1/x?', 'ln(x)', 'x', 'e^x', 'x^2', 1, 'Medium', 54),
(315, 'What is the result of the limit of (x^2 - 1)/(x - 1) as x approaches 1?', '2', '0', '1', 'Infinity', 1, 'Easy', 54),
(316, 'What is the second derivative of x^3?', '6x', '3x^2', '9x', '6x^2', 2, 'Medium', 54),
(317, 'What is the integral of cos(x)?', 'sin(x)', 'x', 'cos(x)', 'ln(x)', 1, 'Easy', 54),
(318, 'What is the formula for the chain rule of differentiation?', 'f\'(g(x)) = f\'(g(x)) * g\'(x)', 'f\'(g(x)) = f\'(g(x)) + g\'(x)', 'f\'(g(x)) = f(g(x)) * g(x)', 'None of the above', 1, 'Hard', 54),
(319, 'What is the limit of (sin(x) / x) as x approaches 0?', '1', '0', 'Infinity', 'Undefined', 1, 'Medium', 54),
(320, 'What is the definition of the derivative of a function?', 'The rate of change of the function with respect to x', 'The area under the curve', 'The integral of the function', 'The slope of the tangent line at a point', 4, 'Easy', 54),
(321, 'What is the integral of x^2?', 'x^3/3', 'x^3', 'x^2', 'x^4/4', 1, 'Easy', 54),
(322, 'What is the formula for integration by parts?', '∫udv = uv - ∫vdu', '∫u dv = uv + ∫vdu', '∫u v = uv', '∫u dx = ux', 1, 'Medium', 54),
(323, 'What is the derivative of ln(x)?', '1/x', 'x', 'ln(x)', 'x^2', 1, 'Easy', 54),
(324, 'What is the integral of e^(x^2)?', 'It cannot be expressed in elementary functions', 'e^(x^2)', 'x^2 + C', 'None of the above', 1, 'Hard', 54),
(325, 'What is the result of the limit of (x^3 - 3x)/(x - 1) as x approaches 1?', '3', '1', '0', '2', 1, 'Hard', 54),
(326, 'What is the derivative of tan(x)?', 'sec^2(x)', 'tan(x)', 'sin(x)', 'cos(x)', 1, 'Medium', 54);
INSERT INTO `store_question` (`QuesID`, `QuesText`, `Option1`, `Option2`, `Option3`, `Option4`, `CorrectAns`, `DifficultyLevel`, `Quiz_id`) VALUES
(327, 'What is the integral of 1/(x^2 + 1)?', 'arctan(x)', 'ln(x)', 'x^2 + C', 'None of the above', 1, 'Medium', 54),
(328, 'What is the result of the limit of (e^x - 1)/x as x approaches 0?', '1', '0', 'Infinity', 'Undefined', 1, 'Medium', 54),
(329, 'What is the integral of 1/x^2?', '-1/x', '1/x', 'x', 'ln(x)', 1, 'Medium', 54),
(330, 'What is the determinant of a 3x3 matrix?', 'The sum of the diagonal elements', 'The product of all elements', 'The sum of the products of the diagonal elements minus the sum of the other products', 'The product of the first row and first column', 3, 'Medium', 55),
(331, 'What is an eigenvector?', 'A non-zero vector that changes only by a scalar factor when a linear transformation is applied', 'A zero vector that changes when a linear transformation is applied', 'A matrix used to transform vectors', 'A set of vectors that are linearly dependent', 1, 'Easy', 55),
(332, 'What is the rank of a matrix?', 'The number of linearly independent rows or columns', 'The number of rows in a matrix', 'The number of zero entries in a matrix', 'The total number of elements in the matrix', 1, 'Easy', 55),
(333, 'What is the inverse of a matrix?', 'A matrix that, when multiplied by the original matrix, results in the identity matrix', 'A matrix that is the transpose of the original matrix', 'A matrix that is symmetric', 'A matrix whose determinant is 1', 1, 'Medium', 55),
(334, 'What is the condition for a matrix to be invertible?', 'Its determinant must not be zero', 'Its rank must be 1', 'It must be square', 'Its rows must be orthogonal', 1, 'Medium', 55),
(335, 'What is the trace of a matrix?', 'The sum of the diagonal elements of a square matrix', 'The sum of all elements in the matrix', 'The number of rows in the matrix', 'The number of columns in the matrix', 1, 'Easy', 55),
(336, 'What is an orthogonal matrix?', 'A matrix whose rows and columns are orthogonal unit vectors', 'A matrix with all entries equal to 1', 'A matrix with equal rows and columns', 'A matrix with only positive entries', 1, 'Hard', 55),
(337, 'What is a vector space?', 'A set of vectors that can be scaled and added together to produce another vector in the same space', 'A set of numbers that can be added and multiplied', 'A set of points on a graph', 'A set of matrices', 1, 'Easy', 55),
(338, 'What is the difference between a row vector and a column vector?', 'A row vector has one row and multiple columns, while a column vector has one column and multiple rows', 'There is no difference', 'A row vector is used in matrix multiplication, while a column vector is used for addition', 'None of the above', 1, 'Medium', 55),
(339, 'What is the dot product of two vectors?', 'The sum of the products of their corresponding components', 'The difference between their corresponding components', 'The product of their magnitudes', 'The angle between the vectors', 1, 'Easy', 55),
(340, 'What is the cross product of two vectors?', 'A vector perpendicular to both input vectors', 'The sum of the two vectors', 'A scalar representing the angle between the vectors', 'The difference of the vectors', 1, 'Medium', 55),
(341, 'What is the Gram-Schmidt process?', 'A method for orthogonalizing a set of vectors', 'A method for calculating the determinant of a matrix', 'A method for solving systems of linear equations', 'A method for finding eigenvectors', 1, 'Hard', 55),
(342, 'What is the characteristic equation of a matrix?', 'det(A - λI) = 0', 'det(A + λI) = 0', 'A = λI', 'None of the above', 1, 'Hard', 55),
(343, 'What is the rank-nullity theorem?', 'The rank of a matrix plus the nullity of the matrix equals the number of columns', 'The rank of a matrix is equal to the number of rows', 'The nullity of a matrix is the number of eigenvectors', 'None of the above', 1, 'Hard', 55),
(344, 'What is a diagonal matrix?', 'A matrix in which all off-diagonal elements are zero', 'A matrix in which all elements are equal', 'A matrix with only one row or one column', 'None of the above', 1, 'Easy', 55),
(345, 'What is the inverse of a diagonal matrix?', 'A diagonal matrix where each diagonal element is the reciprocal of the original diagonal element', 'A matrix with zero diagonal elements', 'A matrix with all elements equal', 'None of the above', 1, 'Medium', 55),
(346, 'What is the spectral theorem?', 'Every symmetric matrix can be diagonalized by an orthogonal matrix', 'Every matrix can be inverted', 'Every matrix has a unique eigenvalue', 'None of the above', 1, 'Hard', 55),
(347, 'What is the difference between eigenvalues and singular values?', 'Eigenvalues are associated with square matrices, while singular values are associated with rectangular matrices', 'Eigenvalues are scalar values, singular values are vectors', 'There is no difference', 'None of the above', 1, 'Hard', 55);

-- --------------------------------------------------------

--
-- Table structure for table `store_quiz`
--

CREATE TABLE `store_quiz` (
  `QuizID` int(11) NOT NULL,
  `QuizTitle` varchar(255) NOT NULL,
  `TimeLimit` int(10) UNSIGNED NOT NULL CHECK (`TimeLimit` >= 0),
  `NumOfQues` int(10) UNSIGNED NOT NULL CHECK (`NumOfQues` >= 0),
  `CreatedAt` datetime(6) NOT NULL,
  `Course_id` int(11) NOT NULL,
  `Faculty_id` int(11) DEFAULT NULL,
  `Faculty_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_quiz`
--

INSERT INTO `store_quiz` (`QuizID`, `QuizTitle`, `TimeLimit`, `NumOfQues`, `CreatedAt`, `Course_id`, `Faculty_id`, `Faculty_name`) VALUES
(15, 'Database Basics', 10, 5, '2025-04-15 20:04:51.000000', 7, 9, 'akhter'),
(37, 'Programming Fundamentals Quiz', 45, 18, '2025-04-15 21:05:00.000000', 8, 33, 'Prof. Jamil Ahmed'),
(38, 'Discrete Mathematics Quiz', 50, 17, '2025-04-15 21:05:00.000000', 9, 34, 'Rabia Rahman'),
(39, 'Data Structures and Algorithms Quiz', 60, 16, '2025-04-15 21:05:00.000000', 10, 35, 'Ahsan Habib'),
(40, 'Computer Networks Quiz', 50, 19, '2025-04-15 21:05:00.000000', 11, 36, 'Nashit Ali'),
(41, 'Database Management Systems Quiz', 55, 16, '2025-04-15 21:05:00.000000', 12, 37, 'Mita Barua'),
(42, 'Digital Logic Design Quiz', 45, 18, '2025-04-15 21:05:00.000000', 13, 38, 'Khairul Alam'),
(43, 'Software Engineering Quiz', 60, 17, '2025-04-15 21:05:00.000000', 14, 39, 'Rafique Khan'),
(44, 'Operating Systems Quiz', 50, 19, '2025-04-15 21:05:00.000000', 15, 40, 'Mizanur Rahman'),
(45, 'Web Development Quiz', 45, 16, '2025-04-15 21:05:00.000000', 16, 41, 'Kazi Nurul Islam'),
(46, 'Calculus I Quiz', 60, 18, '2025-04-15 21:05:00.000000', 17, 42, 'Shama Parveen'),
(47, 'Linear Algebra Quiz', 50, 15, '2025-04-15 21:05:00.000000', 18, 43, 'Fariha Jahan'),
(48, 'English Communication Skills Quiz', 45, 17, '2025-04-15 21:05:00.000000', 19, 44, 'Samiul Haque'),
(49, 'Technical Writing Quiz', 55, 16, '2025-04-15 21:05:00.000000', 20, 45, 'Mariam Chowdhury'),
(50, 'Principles of Management Quiz', 60, 20, '2025-04-15 21:05:00.000000', 21, 46, 'Farida Begum'),
(51, 'Marketing Management Quiz', 45, 18, '2025-04-15 21:05:00.000000', 22, 47, 'Nasim Ahmed'),
(52, 'Financial Accounting Quiz', 50, 19, '2025-04-15 21:05:00.000000', 23, 48, 'Tariq Rehman'),
(53, 'Human Resource Management Quiz', 55, 15, '2025-04-15 21:05:00.000000', 24, 49, 'Shamim Akhtar'),
(54, 'Microeconomics Quiz', 45, 17, '2025-04-15 21:05:00.000000', 25, 50, 'Monirul Islam'),
(55, 'Macroeconomics Quiz', 60, 20, '2025-04-15 21:05:00.000000', 26, 32, 'Dr. Shafiqul Islam'),
(56, 'ABC', 30, 15, '2025-04-15 21:54:18.000000', 20, 9, 'akhter');

-- --------------------------------------------------------

--
-- Table structure for table `store_score`
--

CREATE TABLE `store_score` (
  `ScoreID` int(11) NOT NULL,
  `Score` int(10) UNSIGNED NOT NULL CHECK (`Score` >= 0),
  `SubmittedAt` datetime(6) NOT NULL,
  `Quiz_id` int(11) NOT NULL,
  `Student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_score`
--

INSERT INTO `store_score` (`ScoreID`, `Score`, `SubmittedAt`, `Quiz_id`, `Student_id`) VALUES
(11, 4, '2025-04-15 20:34:25.000000', 15, 10),
(12, 15, '2025-04-15 21:49:31.000000', 37, 10),
(13, 3, '2025-04-17 11:43:07.000000', 54, 51);

-- --------------------------------------------------------

--
-- Table structure for table `store_user`
--

CREATE TABLE `store_user` (
  `password` varchar(128) NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `UserEmail` varchar(254) NOT NULL,
  `UserRole` varchar(7) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_user`
--

INSERT INTO `store_user` (`password`, `UserID`, `UserName`, `UserEmail`, `UserRole`, `is_active`, `last_login`) VALUES
('imti', 5, 'imti', 'imti@gmail.com', 'student', 1, '2025-04-28 02:31:58.000000'),
('imtiaz', 8, 'imtiaz', 'imtiaz@gmail.com', 'admin', 1, '2025-04-28 02:41:46.000000'),
('akhter', 9, 'akhter', 'akhter@gmail.com', 'teacher', 1, '2025-04-28 02:42:04.000000'),
('tomal', 10, 'Tomal', 'tomal@gmail.com', 'student', 1, '2025-04-15 21:43:47.000000'),
('tomal', 11, 'talim', 'talimafrid@gmail.com', 'admin', 1, '2025-04-15 20:36:33.000000'),
('adnan', 12, 'adnan', 'adnan@gmail.com', 'student', 1, NULL),
('password123', 13, 'Towsif Hasan', 'towsifhasan@example.com', 'student', 1, NULL),
('password123', 14, 'Abrarul Islam Badhon', 'abrarulbadhon@example.com', 'student', 1, NULL),
('password123', 15, 'Ovik Ghosh', 'ovikghosh@example.com', 'student', 1, NULL),
('password123', 16, 'Sultana Begum', 'sultana.begum@example.com', 'student', 1, NULL),
('password123', 17, 'Rasheda Sultana', 'rasheda.sultana@example.com', 'student', 1, NULL),
('password123', 18, 'Shahinur Rahman', 'shahinur.rahman@example.com', 'student', 1, NULL),
('password123', 19, 'Amit Roy', 'amit.roy@example.com', 'student', 1, NULL),
('password123', 20, 'Shihab Rahman', 'shihab.rahman@example.com', 'student', 1, NULL),
('password123', 21, 'Imran Hossain', 'imran.hossain@example.com', 'student', 1, NULL),
('password123', 22, 'Tahmina Akter', 'tahmina.akter@example.com', 'student', 1, NULL),
('password123', 23, 'Zakir Hossain', 'zakir.hossain@example.com', 'student', 1, NULL),
('password123', 24, 'Moumita Chatterjee', 'moumita.chatterjee@example.com', 'student', 1, NULL),
('password123', 25, 'Rafiul Islam', 'rafiul.islam@example.com', 'student', 1, NULL),
('password123', 26, 'Fahad Siddique', 'fahad.siddique@example.com', 'student', 1, NULL),
('password123', 27, 'Farhanur Rahman', 'farhanur.rahman@example.com', 'student', 1, NULL),
('password123', 28, 'Hassan Sheikh', 'hassan.sheikh@example.com', 'student', 1, NULL),
('password123', 29, 'Nusrat Jahan', 'nusrat.jahan@example.com', 'student', 1, NULL),
('password123', 30, 'Abir Ahmed', 'abir.ahmed@example.com', 'student', 1, NULL),
('password123', 31, 'Ayesha Sultana', 'ayesha.sultana@example.com', 'student', 1, NULL),
('password123', 32, 'Dr. Shafiqul Islam', 'shafiqul.islam@example.com', 'teacher', 1, NULL),
('password123', 33, 'Prof. Jamil Ahmed', 'jamil.ahmed@example.com', 'teacher', 1, NULL),
('password123', 34, 'Rabia Rahman', 'rabia.rahman@example.com', 'teacher', 1, NULL),
('password123', 35, 'Ahsan Habib', 'ahsan.habib@example.com', 'teacher', 1, NULL),
('password123', 36, 'Nashit Ali', 'nashit.ali@example.com', 'teacher', 1, NULL),
('password123', 37, 'Mita Barua', 'mita.barua@example.com', 'teacher', 1, NULL),
('password123', 38, 'Khairul Alam', 'khairul.alam@example.com', 'teacher', 1, NULL),
('password123', 39, 'Rafique Khan', 'rafique.khan@example.com', 'teacher', 1, NULL),
('password123', 40, 'Mizanur Rahman', 'mizanur.rahman@example.com', 'teacher', 1, NULL),
('password123', 41, 'Kazi Nurul Islam', 'kazi.nurul.islam@example.com', 'teacher', 1, NULL),
('password123', 42, 'Shama Parveen', 'shama.parveen@example.com', 'teacher', 1, NULL),
('password123', 43, 'Fariha Jahan', 'fariha.jahan@example.com', 'teacher', 1, NULL),
('password123', 44, 'Samiul Haque', 'samiul.haque@example.com', 'teacher', 1, NULL),
('password123', 45, 'Mariam Chowdhury', 'mariam.chowdhury@example.com', 'teacher', 1, NULL),
('password123', 46, 'Farida Begum', 'farida.begum@example.com', 'teacher', 1, NULL),
('password123', 47, 'Nasim Ahmed', 'nasim.ahmed@example.com', 'teacher', 1, NULL),
('password123', 48, 'Tariq Rehman', 'tariq.rehman@example.com', 'teacher', 1, NULL),
('password123', 49, 'Shamim Akhtar', 'shamim.akhtar@example.com', 'teacher', 1, NULL),
('password123', 50, 'Monirul Islam', 'monirul.islam@example.com', 'teacher', 1, NULL),
('afrid', 51, 'afrid', 'afrid@gmail.com', 'student', 1, '2025-04-17 11:40:16.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `store_course`
--
ALTER TABLE `store_course`
  ADD PRIMARY KEY (`CourseID`),
  ADD UNIQUE KEY `CourseCode` (`CourseCode`),
  ADD KEY `store_course_Faculty_id_924b6daf_fk_store_user_UserID` (`Faculty_id`);

--
-- Indexes for table `store_question`
--
ALTER TABLE `store_question`
  ADD PRIMARY KEY (`QuesID`),
  ADD KEY `store_question_Quiz_id_77538a6b_fk_store_quiz_QuizID` (`Quiz_id`);

--
-- Indexes for table `store_quiz`
--
ALTER TABLE `store_quiz`
  ADD PRIMARY KEY (`QuizID`),
  ADD KEY `store_quiz_Course_id_13a0f754_fk_store_course_CourseID` (`Course_id`),
  ADD KEY `store_quiz_Faculty_id_b5593441_fk_store_user_UserID` (`Faculty_id`);

--
-- Indexes for table `store_score`
--
ALTER TABLE `store_score`
  ADD PRIMARY KEY (`ScoreID`),
  ADD UNIQUE KEY `store_score_Student_id_Quiz_id_693cca32_uniq` (`Student_id`,`Quiz_id`),
  ADD KEY `store_score_Quiz_id_a78b609f_fk_store_quiz_QuizID` (`Quiz_id`);

--
-- Indexes for table `store_user`
--
ALTER TABLE `store_user`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `UserEmail` (`UserEmail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `store_course`
--
ALTER TABLE `store_course`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `store_question`
--
ALTER TABLE `store_question`
  MODIFY `QuesID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT for table `store_quiz`
--
ALTER TABLE `store_quiz`
  MODIFY `QuizID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `store_score`
--
ALTER TABLE `store_score`
  MODIFY `ScoreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `store_user`
--
ALTER TABLE `store_user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_course`
--
ALTER TABLE `store_course`
  ADD CONSTRAINT `store_course_Faculty_id_924b6daf_fk_store_user_UserID` FOREIGN KEY (`Faculty_id`) REFERENCES `store_user` (`UserID`);

--
-- Constraints for table `store_question`
--
ALTER TABLE `store_question`
  ADD CONSTRAINT `store_question_Quiz_id_77538a6b_fk_store_quiz_QuizID` FOREIGN KEY (`Quiz_id`) REFERENCES `store_quiz` (`QuizID`);

--
-- Constraints for table `store_quiz`
--
ALTER TABLE `store_quiz`
  ADD CONSTRAINT `store_quiz_Course_id_13a0f754_fk_store_course_CourseID` FOREIGN KEY (`Course_id`) REFERENCES `store_course` (`CourseID`),
  ADD CONSTRAINT `store_quiz_Faculty_id_b5593441_fk_store_user_UserID` FOREIGN KEY (`Faculty_id`) REFERENCES `store_user` (`UserID`);

--
-- Constraints for table `store_score`
--
ALTER TABLE `store_score`
  ADD CONSTRAINT `store_score_Quiz_id_a78b609f_fk_store_quiz_QuizID` FOREIGN KEY (`Quiz_id`) REFERENCES `store_quiz` (`QuizID`),
  ADD CONSTRAINT `store_score_Student_id_395bbd59_fk_store_user_UserID` FOREIGN KEY (`Student_id`) REFERENCES `store_user` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
