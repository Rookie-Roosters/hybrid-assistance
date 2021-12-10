-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-12-2021 a las 01:25:46
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hybrid_assistance`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `academic_load`
--

CREATE TABLE `academic_load` (
  `id` int(11) NOT NULL,
  `id_student` int(11) NOT NULL,
  `id_course` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `academic_load`
--

INSERT INTO `academic_load` (`id`, `id_student`, `id_course`) VALUES
(5, 227832, 7),
(4, 228552, 7),
(3, 269547, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `password`, `name`) VALUES
(1, 'Admin1234', 'Admin1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `id_student` int(11) NOT NULL,
  `id_schedule` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `career`
--

CREATE TABLE `career` (
  `id` int(11) NOT NULL,
  `id_department` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `career`
--

INSERT INTO `career` (`id`, `id_department`, `name`) VALUES
(66, 10, 'Ingeniería en Computación Inteligente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `center`
--

CREATE TABLE `center` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `center`
--

INSERT INTO `center` (`id`, `name`) VALUES
(67545, 'Centro de Ciencias Agropecuarias'),
(67546, 'Centro de Ciencias Básicas'),
(67547, 'Centro de Ciencias de la Ingeniería'),
(67548, 'Centro de Ciencias de la Salud'),
(67549, 'Centro de Ciencias del Diseño y la Construcción'),
(67550, 'Centro de Ciencias Económicas y Administrativas'),
(67551, 'Centro de Ciencias Empresariales'),
(67552, 'Centro de Ciencias Sociales y Humanidades'),
(67553, 'Centro de las Artes y la Cultura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `classroom`
--

CREATE TABLE `classroom` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `classroom`
--

INSERT INTO `classroom` (`id`, `name`) VALUES
(1, '54-A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `id_group` int(11) NOT NULL,
  `id_subject` int(11) NOT NULL,
  `id_teacher` int(11) NOT NULL,
  `attendance_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `course`
--

INSERT INTO `course` (`id`, `id_group`, `id_subject`, `id_teacher`, `attendance_code`) VALUES
(7, 1, 10, 9864, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `id_center` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `department`
--

INSERT INTO `department` (`id`, `id_center`, `name`) VALUES
(9, 67546, 'Biología'),
(10, 67546, 'Ciencias de la Computación'),
(11, 67546, 'Estadística'),
(12, 67546, 'Fisiología y Farmacología'),
(13, 67546, 'Ingenería Bioquímica'),
(14, 67546, 'Matemáticas y Física'),
(15, 67546, 'Microbiología'),
(16, 67546, 'Morfología'),
(17, 67546, 'Química'),
(18, 67546, 'Sistemas de Información'),
(19, 67546, 'Sistemas Electrónicos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `group`
--

CREATE TABLE `group` (
  `id` int(11) NOT NULL,
  `id_career` int(11) NOT NULL,
  `generation` varchar(50) NOT NULL,
  `letter` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `group`
--

INSERT INTO `group` (`id`, `id_career`, `generation`, `letter`) VALUES
(1, 66, '2019-2023', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `id_course` int(11) NOT NULL,
  `id_classroom` int(11) NOT NULL,
  `weekday` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstLastName` varchar(100) NOT NULL,
  `secondLastName` varchar(100) NOT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `student`
--

INSERT INTO `student` (`id`, `name`, `password`, `firstLastName`, `secondLastName`, `nickname`, `picture`) VALUES
(227832, 'Sandra Jacqueline', 'Contra1234', 'López', 'Serna', NULL, NULL),
(228552, 'Manuel', 'Contra1234', 'González', 'Martínez', NULL, NULL),
(269547, 'Leonel Iván', 'Contra1234', 'Fernández', 'Carrillo', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subject`
--

CREATE TABLE `subject` (
  `id` int(11) NOT NULL,
  `id_department` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `subject`
--

INSERT INTO `subject` (`id`, `id_department`, `name`) VALUES
(5, 10, 'Optimización Inteligente'),
(6, 10, 'Autómatas I'),
(7, 10, 'Arquitectura Inteligente de Desarrollo Híbrido'),
(8, 10, 'Lenguajes Inteligentes'),
(9, 14, 'Ecuaciones Diferenciales'),
(10, 18, 'Base de Datos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teacher`
--

CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `firstLastName` varchar(100) NOT NULL,
  `secondLastName` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `teacher`
--

INSERT INTO `teacher` (`id`, `name`, `firstLastName`, `secondLastName`, `password`, `picture`) VALUES
(9864, 'Cesar Eduardo', 'Velazquez', 'Amador', 'Profe1234', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `academic_load`
--
ALTER TABLE `academic_load`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_student` (`id_student`,`id_course`),
  ADD KEY `id_course` (`id_course`);

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_student` (`id_student`,`id_schedule`),
  ADD KEY `id_schedule` (`id_schedule`);

--
-- Indices de la tabla `career`
--
ALTER TABLE `career`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `id_department` (`id_department`);

--
-- Indices de la tabla `center`
--
ALTER TABLE `center`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `classroom`
--
ALTER TABLE `classroom`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_group` (`id_group`,`id_subject`,`id_teacher`),
  ADD KEY `id_subject` (`id_subject`),
  ADD KEY `id_teacher` (`id_teacher`);

--
-- Indices de la tabla `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `id_center` (`id_center`);

--
-- Indices de la tabla `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_career` (`id_career`);

--
-- Indices de la tabla `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_course` (`id_course`,`id_classroom`),
  ADD KEY `id_classroom` (`id_classroom`);

--
-- Indices de la tabla `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_department` (`id_department`);

--
-- Indices de la tabla `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `academic_load`
--
ALTER TABLE `academic_load`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `career`
--
ALTER TABLE `career`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `center`
--
ALTER TABLE `center`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67554;

--
-- AUTO_INCREMENT de la tabla `classroom`
--
ALTER TABLE `classroom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `group`
--
ALTER TABLE `group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289025;

--
-- AUTO_INCREMENT de la tabla `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28387;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `academic_load`
--
ALTER TABLE `academic_load`
  ADD CONSTRAINT `academic_load_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `academic_load_ibfk_2` FOREIGN KEY (`id_course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`id_student`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`id_schedule`) REFERENCES `schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `career`
--
ALTER TABLE `career`
  ADD CONSTRAINT `career_ibfk_1` FOREIGN KEY (`id_department`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`id_group`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`id_subject`) REFERENCES `subject` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_ibfk_3` FOREIGN KEY (`id_teacher`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`id_center`) REFERENCES `center` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`id_career`) REFERENCES `career` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`id_classroom`) REFERENCES `classroom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`id_course`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`id_department`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
