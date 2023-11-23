use proyect_schema;

CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `numero` varchar(12) DEFAULT NULL,
  `direccion` varchar(20) DEFAULT NULL,
  `id_pedidos` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`id_pedidos`) REFERENCES `pedidos` (`id`);

CREATE TABLE `cobros` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ventas` int DEFAULT NULL,
  `datos` text,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `cobros`
  ADD CONSTRAINT `cobros_ibfk_1` FOREIGN KEY (`id_ventas`) REFERENCES `ventas` (`id`);



CREATE TABLE `consumibles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  PRIMARY KEY (`id`)
);

CREATE TABLE `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) DEFAULT NULL,
  `lider` varchar(20) DEFAULT NULL,
  `especialidad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `pedido_proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedido` text,
  `pago` varchar(20) DEFAULT '$400',
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) NOT NULL,
  `id_presupuesto` int DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

ALTER TABLE pedidos
ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_presupuesto`) REFERENCES `presupuestos` (`id`),
ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clients` (`id`);

CREATE TABLE `presupuestos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datos` text,
  `valor` float DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) DEFAULT NULL,
  `cuit` varchar(20) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `id_pedido_proveedores` int DEFAULT NULL,
  PRIMARY KEY (`id`)
  ) ;
ALTER TABLE proveedores
ADD CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_pedido_proveedores`) REFERENCES `pedido_proveedores` (`id`)
;

CREATE TABLE `proyectos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `descripcion` text,
  `fecha_inicio` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `id_consumibles` int DEFAULT NULL,
  PRIMARY KEY (`id`)
  ) ;
  
  ALTER TABLE proyectos
  ADD CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`id_consumibles`) REFERENCES `consumibles` (`id`),
  ADD CONSTRAINT `proyectos_ibfk_2` FOREIGN KEY (`id_consumibles`) REFERENCES `consumibles` (`id`)
;

CREATE TABLE `servicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `descripcion` text,
  `id_equipo` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

ALTER TABLE servicio
ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`)
;


CREATE TABLE `tareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `descripcion` text,
  `clasificacion` varchar(30) DEFAULT NULL,
  `id_equipo` int DEFAULT NULL,
  `id_proyecto` int DEFAULT NULL,
  PRIMARY KEY (`id`)  
) ;

ALTER TABLE tareas
ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`),
ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id`);

CREATE TABLE `ventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `id_presupuestos` int DEFAULT NULL,
  `id_cobros` int DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

ALTER TABLE ventas
ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clients` (`id`),
ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_presupuestos`) REFERENCES `presupuestos` (`id`),
ADD CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_cobros`) REFERENCES `cobros` (`id`);

SELECT
    id AS id_c,
    nombre AS nom_c,
    email AS em_c,
    numero AS num_c,
    direccion AS Dir_c,
    id_pedidos AS id_ped_c
FROM clients;

SELECT
    id AS id_cob,
    id_ventas AS id_v,
    datos AS d_cob,
    fecha AS f_cob
FROM cobros;

SELECT
    id AS Id_cons_pr,
    descripcion AS Des_cons_pr
FROM consumibles;

SELECT
    id AS id_Eq,
    nombre AS nom_Eq,
    lider AS l_Eq,
    especialidad AS espe_Eq
FROM Equipos;


SELECT
    id AS id_pres,
    datos AS dt_pres,
    valor AS v_pres,
    aprobado AS ok_c
FROM presupuesto;

SELECT
    id AS id_ped_c,
    descripcion ASped_des ,
    id_presupuesto AS id_pres ,
    id_cliente AS id_c
FROM pedidos;

SELECT
    id AS Id_prov,
    nombre AS nom_prov,
    email AS e_prov,
    numero AS num_cont_prov,
    cuit AS ct_prov,
    id_pedidos_proveedores AS id_ped_prov
    FROM proveedores;
    
SELECT
    id AS id_ped_prov,
    pedido AS ped_re_prov,
    pago AS pa_re
FROM pedido_proveedores;

SELECT
    id AS id_pr,
    nombre AS nom_pr,
    descripcion AS des_Pr,
    fecha_inicio AS ini_Pr,
    estado AS est_Pr,
    fecha_fin AS f_Fin_Pr,
    id_consumibles AS Id_cons_pr
FROM proyectos;

SELECT
    id AS id_s,
    nombre AS nom_s,
    descripcion AS desc_s,
    id_equipo AS id_eq
FROM servicio;

SELECT
    id AS id_t,
    nombre AS t_nom,
    descripcion AS t_des,
    clasificacion AS cla_t,
    id_equipo AS id_Eq,
    id_proyecto AS id_p
FROM tareas;

SELECT
    id AS id_V,
    id_cliente AS id_c,
    id_presupuestos AS id_pres,
    id_cobros AS id_cob,
    email AS em_c
FROM ventas;

SELECT * FROM clients;
SELECT * FROM pedidos;

-- Insertar datos en la tabla clients
INSERT INTO clients (nombre, email, numero, direccion, id_pedidos)
VALUES
  ('Cliente1', 'cliente1@email.com', '123456789', 'Dirección Cliente 1', 1),
  ('Cliente2', 'cliente2@email.com', '987654321', 'Dirección Cliente 2', 2);

-- Insertar datos en la tabla cobros
INSERT INTO cobros (id_ventas, datos, fecha)
VALUES
  (1, 'Datos del cobro 1', '2023-01-01'),
  (2, 'Datos del cobro 2', '2023-02-02');
  -- Agrega más cobros según sea necesario...

-- Insertar datos en la tabla consumibles
INSERT INTO consumibles (descripcion)
VALUES
  ('Descripción Consumible 1'),
  ('Descripción Consumible 2');
  -- Agrega más consumibles según sea necesario...

-- Insertar datos en la tabla equipos
INSERT INTO equipos (nombre, lider, especialidad)
VALUES
  ('Equipo1', 'Líder Equipo 1', 'Especialidad 1'),
  ('Equipo2', 'Líder Equipo 2', 'Especialidad 2');
  -- Agrega más equipos según sea necesario...

-- Insertar datos en la tabla pedido_proveedores
INSERT INTO pedido_proveedores (pedido, pago)
VALUES
  ('Pedido proveedor 1', '$500'),
  ('Pedido proveedor 2', '$600');
  -- Agrega más pedidos a proveedores según sea necesario...

-- Insertar datos en la tabla pedidos
INSERT INTO pedidos (descripcion, id_presupuesto, id_cliente)
VALUES
  ('Descripción Pedido 1', 1, 1),
  ('Descripción Pedido 2', 2, 2);
  -- Agrega más pedidos según sea necesario...

-- Insertar datos en la tabla presupuestos
INSERT INTO presupuestos (datos, valor, aprobado)
VALUES
  ('Datos Presupuesto 1', 1000.00, 1),
  ('Datos Presupuesto 2', 1500.00, 0);
  -- Agrega más presupuestos según sea necesario...

-- Insertar datos en la tabla proveedores
INSERT INTO proveedores (nombre, cuit, numero, email, id_pedido_proveedores)
VALUES
  ('Proveedor1', 'CUIT1', '123456789', 'proveedor1@email.com', 1),
  ('Proveedor2', 'CUIT2', '987654321', 'proveedor2@email.com', 2);
  -- Agrega más proveedores según sea necesario...

-- Insertar datos en la tabla proyectos
INSERT INTO proyectos (nombre, descripcion, fecha_inicio, estado, fecha_fin, id_consumibles)
VALUES
  ('Proyecto1', 'Descripción Proyecto 1', '2023-01-01', 1, '2023-12-31', 1),
  ('Proyecto2', 'Descripción Proyecto 2', '2023-03-01', 0, '2023-12-31', 2);
  -- Agrega más proyectos según sea necesario...

-- Insertar datos en la tabla servicio
INSERT INTO servicio (nombre, descripcion, id_equipo)
VALUES
  ('Servicio1', 'Descripción Servicio 1', 1),
  ('Servicio2', 'Descripción Servicio 2', 2);
  -- Agrega más servicios según sea necesario...

-- Insertar datos en la tabla tareas
INSERT INTO tareas (nombre, descripcion, clasificacion, id_equipo, id_proyecto)
VALUES
  ('Tarea1', 'Descripción Tarea 1', 'Clasificación 1', 1, 1),
  ('Tarea2', 'Descripción Tarea 2', 'Clasificación 2', 2, 2);
  -- Agrega más tareas según sea necesario...

-- Insertar datos en la tabla ventas
INSERT INTO ventas (id_cliente, id_presupuestos, id_cobros, email)
VALUES
  (1, 1, 1, 'venta1@email.com'),
  (2, 2, 2, 'venta2@email.com');
  -- Agrega más ventas según sea necesario...






