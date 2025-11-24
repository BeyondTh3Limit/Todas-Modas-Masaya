-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2025 a las 17:30:59
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `todamodamasayaweb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `IdCargo` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`IdCargo`, `Nombre`) VALUES
(1, 'Gerente'),
(2, 'Cajero'),
(3, 'Gerente General'),
(4, 'Barredor'),
(5, 'Paquetero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`IdCategoria`, `Descripcion`) VALUES
(1, 'Infantil'),
(3, 'Masculino'),
(4, 'Femenino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `IdDepartamento` int(11) NOT NULL,
  `Direccion` varchar(150) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `TipoCliente` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `Nombre`, `Apellido`, `IdDepartamento`, `Direccion`, `Telefono`, `TipoCliente`) VALUES
(1, 'Felipe', 'Garcia', 1, 'Santa Rosa', '86909754', 'Unico'),
(2, 'adsdf', 'sdfsd', 1, 'sdf', 'sdfsdf', 'sdfsdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `IdCompra` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  `IdProveedor` int(11) NOT NULL,
  `Fecha` date DEFAULT curdate(),
  `Total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`IdCompra`, `IdUsuario`, `IdProveedor`, `Fecha`, `Total`) VALUES
(2, 2, 3, '2025-11-06', NULL),
(6, 2, 3, '2025-11-07', NULL),
(7, 2, 2, '2025-11-07', NULL),
(8, 2, 1, '2025-11-11', NULL),
(9, 2, 1, '2025-11-11', NULL),
(10, 2, 2, '2025-11-11', NULL),
(11, 2, 1, '2025-11-11', NULL),
(12, 2, 1, '2025-11-11', NULL),
(13, 2, 3, '2025-11-12', NULL),
(14, 2, 3, '2025-11-17', NULL),
(15, 5, 3, '2025-11-20', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `IdDepartamento` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`IdDepartamento`, `Nombre`) VALUES
(1, 'Managua');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallenomina`
--

CREATE TABLE `detallenomina` (
  `IdDetNomina` int(11) NOT NULL,
  `IdNomina` int(11) NOT NULL,
  `HorasExtras` float DEFAULT 0,
  `Bonos` float DEFAULT 0,
  `Incentivos` float DEFAULT 0,
  `Prestamos` float DEFAULT 0,
  `ValorHorasExtra` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallenomina`
--

INSERT INTO `detallenomina` (`IdDetNomina`, `IdNomina`, `HorasExtras`, `Bonos`, `Incentivos`, `Prestamos`, `ValorHorasExtra`) VALUES
(9, 9, 2, 0, 0, 8, 216.667),
(10, 10, 30, 0, 0, 0, 3000),
(20, 16, 0, 0, 0, 0, 0),
(21, 16, 0, 0, 0, 0, 0),
(22, 17, 5, 0, 0, 0, 583.333),
(23, 17, 5, 0, 0, 0, 583.333);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `IdDetCompra` int(11) NOT NULL,
  `IdCompra` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `PrecioUnitario` float NOT NULL,
  `Subtotal` float GENERATED ALWAYS AS (`Cantidad` * `PrecioUnitario`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`IdDetCompra`, `IdCompra`, `IdProducto`, `Cantidad`, `PrecioUnitario`) VALUES
(2, 2, 2, 1, 4),
(12, 6, 3, 30, 1),
(13, 7, 3, 15, 1),
(14, 8, 2, 1, 0),
(15, 8, 1, 1, 0),
(16, 8, 1, 1, 0),
(17, 9, 3, 1, 97),
(18, 10, 2, 1, 78),
(19, 10, 1, 1, 87),
(20, 11, 1, 1, 54),
(21, 11, 3, 1, 43),
(22, 11, 3, 1, 23),
(23, 12, 2, 100, 1),
(24, 13, 1, 5, 656),
(25, 13, 3, 1, 45),
(27, 14, 2, 100, 100),
(28, 15, 2, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_de_salida`
--

CREATE TABLE `detalle_de_salida` (
  `IdDetVenta` int(11) NOT NULL,
  `IdVenta` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `PrecioUnitario` float NOT NULL,
  `Subtotal` float GENERATED ALWAYS AS (`Cantidad` * `PrecioUnitario`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_de_salida`
--

INSERT INTO `detalle_de_salida` (`IdDetVenta`, `IdVenta`, `IdProducto`, `Cantidad`, `PrecioUnitario`) VALUES
(5, 3, 2, 2, 600),
(6, 3, 2, 11, 600),
(7, 2, 2, 12, 600),
(8, 2, 1, 1, 90),
(9, 4, 2, 8, 600),
(10, 4, 1, 13, 90),
(12, 6, 2, 100, 600),
(13, 7, 1, 1, 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Cedula` varchar(25) NOT NULL,
  `IdCargo` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Cedula`, `IdCargo`, `Nombre`, `Apellido`, `Direccion`, `Telefono`) VALUES
('001-000000-0000A', 3, 'John', 'Doe', 'Managua, Nicaragua', '8888-0000'),
('001-120800-0001X', 1, 'María', 'Gutiérrez', 'Masaya, barrio San Juan', '8888-1111'),
('001-120800-0002X', 2, 'Carlos', 'Lopezaurio del caremn', 'Masaya, Monimbó', '8888-2222'),
('123-345656-14345X', 1, 'Pollo', 'Lopez', 'dgfdfg', '8690 9568'),
('601-040709-1000H', 2, 'Abdiel Enmanuel', 'Garcia Espinoza', 'Mi casa', '86909568'),
('sdfvdfgvb', 2, 'Abdiel', 'asedd', 'asdsa', 'sdfsd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `IdModulo` int(11) NOT NULL,
  `Clave` varchar(50) NOT NULL,
  `Titulo` varchar(100) NOT NULL,
  `Ruta` varchar(100) NOT NULL,
  `Activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`IdModulo`, `Clave`, `Titulo`, `Ruta`, `Activo`) VALUES
(1, 'inicio', 'Inicio', 'modulos/inicio/index.php', 1),
(2, 'clientes', 'Clientes', 'modulos/clientes/index.php', 1),
(3, 'departamentos', 'Departamentos', 'modulos/departamentos/index.php', 1),
(4, 'empleados', 'Empleados', 'modulos/empleados/index.php', 1),
(5, 'cargos', 'Cargos', 'modulos/cargos/index.php', 1),
(6, 'nomina', 'Nómina', 'modulos/nomina/index.php', 1),
(7, 'productos', 'Productos', 'modulos/productos/index.php', 1),
(8, 'categorias', 'Categorías', 'modulos/categorias/index.php', 1),
(9, 'proveedores', 'Proveedores', 'modulos/proveedores/index.php', 1),
(10, 'compras', 'Compras', 'modulos/compras/index.php', 1),
(11, 'salidas', 'Salidas', 'modulos/salidas/index.php', 1),
(12, 'usuarios', 'Usuarios', 'modulos/usuarios/index.php', 1),
(13, 'roles', 'Roles', 'modulos/roles/index.php', 1),
(14, 'reportes', 'Reportes', 'modulos/reportes/index.php', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nomina`
--

CREATE TABLE `nomina` (
  `IdNomina` int(11) NOT NULL,
  `Cedula` varchar(25) NOT NULL,
  `SalarioBasico` float NOT NULL,
  `SalarioBruto` float NOT NULL,
  `INNS` float NOT NULL,
  `IR` float NOT NULL,
  `DeduccionTotal` float NOT NULL,
  `SalarioNeto` float NOT NULL,
  `FechaRegistro` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nomina`
--

INSERT INTO `nomina` (`IdNomina`, `Cedula`, `SalarioBasico`, `SalarioBruto`, `INNS`, `IR`, `DeduccionTotal`, `SalarioNeto`, `FechaRegistro`) VALUES
(9, '001-120800-0001X', 13000, 13000, 910, 0, 918, 12082, '2025-11-14'),
(10, '001-120800-0001X', 12000, 12200, 854, 0, 854, 11346, '2025-11-14'),
(16, '001-120800-0001X', 120000, 120000, 8400, 1740, 10140, 109860, '2025-11-15'),
(17, '001-000000-0000A', 14000, 14583.3, 1020.83, 0, 1020.83, 13562.5, '2025-11-18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `Marca` varchar(60) DEFAULT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `Talla` varchar(20) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `Cantidad` int(11) NOT NULL DEFAULT 0,
  `Precio_de_Venta` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`IdProducto`, `IdCategoria`, `Marca`, `Nombre`, `Descripcion`, `Talla`, `Color`, `Cantidad`, `Precio_de_Venta`) VALUES
(1, 4, 'Shein', 'Pantalon', 'Roja', 'M', 'Roja', 2, 90),
(2, 1, 'Nike', 'Camisa', 'Camisa con el logo de Michael Jordan', 'S', 'Negra', 77, 600),
(3, 3, 'Nike', 'Short', 'Rayado', '34', 'Rojo', 49, 300);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `IdProveedor` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `FechaRegistro` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`IdProveedor`, `Nombre`, `Telefono`, `Email`, `Direccion`, `FechaRegistro`) VALUES
(1, 'Distribuidora Nica S.A.', '8888-1111', 'contacto@distribuidoranica.com', 'Managua, Carretera Norte km 5 ½', '2025-10-20'),
(2, 'Textiles El Sol', '8855-2233', 'ventas@textileselsol.com', 'Masaya, barrio San Juan', '2025-10-22'),
(3, 'Calzados del Lago', '8700-7788', 'info@calzadosdellago.com', 'Granada, Calle Real Xalteva', '2025-10-25'),
(6, 'NIKE', '89607056', 'nike@gmail.com', 'sdfsdfsdf', '2025-11-17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IdRol` int(11) NOT NULL,
  `Descripcion` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IdRol`, `Descripcion`) VALUES
(5, 'Administrador'),
(9, 'Pedro'),
(10, 'Clientes'),
(12, 'Vendedor'),
(13, 'Rol Prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolmodulo`
--

CREATE TABLE `rolmodulo` (
  `IdRol` int(11) NOT NULL,
  `IdModulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rolmodulo`
--

INSERT INTO `rolmodulo` (`IdRol`, `IdModulo`) VALUES
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(5, 10),
(5, 11),
(5, 12),
(5, 13),
(5, 14),
(9, 1),
(9, 2),
(9, 5),
(9, 8),
(9, 10),
(9, 14),
(10, 2),
(10, 4),
(10, 7),
(10, 13),
(12, 3),
(12, 5),
(12, 6),
(12, 8),
(12, 9),
(12, 10),
(12, 11),
(13, 5),
(13, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida_de_stock`
--

CREATE TABLE `salida_de_stock` (
  `IdVenta` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `Fecha` date DEFAULT curdate(),
  `Metodo_de_pago` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salida_de_stock`
--

INSERT INTO `salida_de_stock` (`IdVenta`, `IdUsuario`, `IdCliente`, `Fecha`, `Metodo_de_pago`) VALUES
(2, 2, 1, '2025-11-01', 'Efectivo'),
(3, 2, 1, '2025-11-13', 'Efectivo'),
(4, 2, 1, '2025-11-13', 'Efectivo'),
(6, 2, 1, '2025-11-18', 'Efectivo'),
(7, 7, 2, '2025-11-21', 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `IdUsuario` int(11) NOT NULL,
  `Cedula` varchar(25) NOT NULL,
  `Nombre_de_Usuario` varchar(60) NOT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `IdRol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Cedula`, `Nombre_de_Usuario`, `Correo`, `Contrasena`, `IdRol`) VALUES
(2, '001-120800-0001X', 'Admin Prueba', 'admin@todamoda.com', 'e10adc3949ba59abbe56e057f20f883e', 5),
(5, '001-000000-0000A', 'Felip', 'prueba@gmail.com', '202cb962ac59075b964b07152d234b70', 10),
(7, '123-345656-14345X', 'Abdiel', 'a@gmail.com', '202cb962ac59075b964b07152d234b70', 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`IdCargo`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`),
  ADD KEY `IdDepartamento` (`IdDepartamento`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`IdCompra`),
  ADD KEY `IdUsuario` (`IdUsuario`),
  ADD KEY `IdProveedor` (`IdProveedor`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`IdDepartamento`);

--
-- Indices de la tabla `detallenomina`
--
ALTER TABLE `detallenomina`
  ADD PRIMARY KEY (`IdDetNomina`),
  ADD KEY `IdNomina` (`IdNomina`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`IdDetCompra`),
  ADD KEY `IdCompra` (`IdCompra`),
  ADD KEY `IdProducto` (`IdProducto`);

--
-- Indices de la tabla `detalle_de_salida`
--
ALTER TABLE `detalle_de_salida`
  ADD PRIMARY KEY (`IdDetVenta`),
  ADD KEY `IdVenta` (`IdVenta`),
  ADD KEY `IdProducto` (`IdProducto`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Cedula`),
  ADD KEY `IdCargo` (`IdCargo`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`IdModulo`),
  ADD UNIQUE KEY `Clave` (`Clave`);

--
-- Indices de la tabla `nomina`
--
ALTER TABLE `nomina`
  ADD PRIMARY KEY (`IdNomina`),
  ADD KEY `Cedula` (`Cedula`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`),
  ADD KEY `fk_categoria` (`IdCategoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IdRol`);

--
-- Indices de la tabla `rolmodulo`
--
ALTER TABLE `rolmodulo`
  ADD PRIMARY KEY (`IdRol`,`IdModulo`),
  ADD KEY `IdModulo` (`IdModulo`);

--
-- Indices de la tabla `salida_de_stock`
--
ALTER TABLE `salida_de_stock`
  ADD PRIMARY KEY (`IdVenta`),
  ADD KEY `IdUsuario` (`IdUsuario`),
  ADD KEY `IdCliente` (`IdCliente`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`),
  ADD UNIQUE KEY `Cedula` (`Cedula`),
  ADD UNIQUE KEY `Nombre_de_Usuario` (`Nombre_de_Usuario`),
  ADD UNIQUE KEY `Correo` (`Correo`),
  ADD KEY `IdRol` (`IdRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `IdCargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `IdCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `IdDepartamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detallenomina`
--
ALTER TABLE `detallenomina`
  MODIFY `IdDetNomina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `IdDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `detalle_de_salida`
--
ALTER TABLE `detalle_de_salida`
  MODIFY `IdDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `IdModulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `nomina`
--
ALTER TABLE `nomina`
  MODIFY `IdNomina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `IdRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `salida_de_stock`
--
ALTER TABLE `salida_de_stock`
  MODIFY `IdVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`IdDepartamento`) REFERENCES `departamento` (`IdDepartamento`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`);

--
-- Filtros para la tabla `detallenomina`
--
ALTER TABLE `detallenomina`
  ADD CONSTRAINT `detallenomina_ibfk_1` FOREIGN KEY (`IdNomina`) REFERENCES `nomina` (`IdNomina`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`IdCompra`) REFERENCES `compra` (`IdCompra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`);

--
-- Filtros para la tabla `detalle_de_salida`
--
ALTER TABLE `detalle_de_salida`
  ADD CONSTRAINT `detalle_de_salida_ibfk_1` FOREIGN KEY (`IdVenta`) REFERENCES `salida_de_stock` (`IdVenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_de_salida_ibfk_2` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`IdCargo`) REFERENCES `cargo` (`IdCargo`);

--
-- Filtros para la tabla `nomina`
--
ALTER TABLE `nomina`
  ADD CONSTRAINT `nomina_ibfk_1` FOREIGN KEY (`Cedula`) REFERENCES `empleado` (`Cedula`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_categoria` FOREIGN KEY (`IdCategoria`) REFERENCES `categoria` (`IdCategoria`),
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `categoria` (`IdCategoria`);

--
-- Filtros para la tabla `rolmodulo`
--
ALTER TABLE `rolmodulo`
  ADD CONSTRAINT `rolmodulo_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`) ON DELETE CASCADE,
  ADD CONSTRAINT `rolmodulo_ibfk_2` FOREIGN KEY (`IdModulo`) REFERENCES `modulo` (`IdModulo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `salida_de_stock`
--
ALTER TABLE `salida_de_stock`
  ADD CONSTRAINT `salida_de_stock_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`),
  ADD CONSTRAINT `salida_de_stock_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`IdCliente`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`),
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`Cedula`) REFERENCES `empleado` (`Cedula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
