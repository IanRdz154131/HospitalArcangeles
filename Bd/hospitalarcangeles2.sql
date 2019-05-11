-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 11-05-2019 a las 05:21:29
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hospitalarcangeles`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficios`
--

DROP TABLE IF EXISTS `beneficios`;
CREATE TABLE IF NOT EXISTS `beneficios` (
  `idPlan` int(11) NOT NULL,
  `idEspecialidad` int(11) NOT NULL,
  PRIMARY KEY (`idPlan`,`idEspecialidad`),
  KEY `idEspecialidad` (`idEspecialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `beneficios`
--

INSERT INTO `beneficios` (`idPlan`, `idEspecialidad`) VALUES
(1, 1),
(1, 2),
(2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

DROP TABLE IF EXISTS `citas`;
CREATE TABLE IF NOT EXISTS `citas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idMedico` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idMedico` (`idMedico`),
  KEY `idUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id`, `idUsuario`, `idMedico`, `fecha`) VALUES
(1, 3, 1, '2019-05-11 08:00:00'),
(4, 3, 1, '2019-05-11 09:00:00'),
(5, 3, 1, '2019-05-11 10:00:00'),
(6, 3, 1, '2019-05-11 11:00:00'),
(7, 3, 1, '2019-05-11 12:00:00'),
(8, 3, 1, '2019-05-11 13:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;
CREATE TABLE IF NOT EXISTS `especialidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `costoCita` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `nombre`, `costoCita`) VALUES
(1, 'General', '300.00'),
(2, 'Oftalmologo', '500.00'),
(3, 'Ortopedista', '1000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

DROP TABLE IF EXISTS `medicos`;
CREATE TABLE IF NOT EXISTS `medicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `correo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `especialidad` int(11) NOT NULL,
  `consultorio` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `fk_especialidad` (`especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`id`, `correo`, `password`, `nombre`, `especialidad`, `consultorio`, `telefono`) VALUES
(1, 'juan.martinez@hospitalarcngeles.com', '111', 'Juan Martinez Soto', 1, '101', '6563432122'),
(2, 'adrian.garcia@hospitalarcangeles.com', '222', 'Adrian Garcia', 2, '102', '6564433456'),
(3, 'roberto.gomez@hospitalarcangeles.com', '333', 'Roberto Gomez', 3, '200', '6563322111'),
(4, 'karla.estrada@hospitalarcangeles.com', '111', 'Karla Estrada Solis', 1, '100', '6567766666');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes`
--

DROP TABLE IF EXISTS `planes`;
CREATE TABLE IF NOT EXISTS `planes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `porcentajeDesc` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `planes`
--

INSERT INTO `planes` (`id`, `nombre`, `porcentajeDesc`) VALUES
(1, 'Basico', '0.15'),
(2, 'Medio', '0.30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `correo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contra` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `plan` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numTarjeta` varchar(16) COLLATE utf8_spanish_ci NOT NULL,
  `fechaVencimiento` date NOT NULL,
  `cvv` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipoPlan` (`plan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `correo`, `contra`, `plan`, `nombre`, `telefono`, `numTarjeta`, `fechaVencimiento`, `cvv`) VALUES
(3, 'veramartin293@gmail.com', '123', 1, 'Martin Vera', '6560394874', '123456789', '2019-05-06', '123');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `beneficios`
--
ALTER TABLE `beneficios`
  ADD CONSTRAINT `beneficios_ibfk_1` FOREIGN KEY (`idPlan`) REFERENCES `planes` (`id`),
  ADD CONSTRAINT `beneficios_ibfk_2` FOREIGN KEY (`idEspecialidad`) REFERENCES `especialidades` (`id`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`idMedico`) REFERENCES `medicos` (`id`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `fk_especialidad` FOREIGN KEY (`especialidad`) REFERENCES `especialidades` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`plan`) REFERENCES `planes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
