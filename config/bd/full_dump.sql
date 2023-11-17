DROP SCHEMA IF EXISTS `sprinf_bd`;
CREATE SCHEMA `sprinf_bd`;

CREATE TABLE `sprinf_bd`.`periodo` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `fecha_inicio` date,
  `fecha_cierre` date
);

CREATE TABLE `sprinf_bd`.`trayecto` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `periodo_id` int,
  `calificacion_minima` float,
  `nombre` varchar(255),
  `siguiente_trayecto` varchar(255)
);

CREATE TABLE `sprinf_bd`.`fase` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `trayecto_id` varchar(255),
  `nombre` varchar(255),
  `siguiente_fase` varchar(255)
);

CREATE TABLE `sprinf_bd`.`seccion` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `trayecto_id` varchar(255),
  `observacion` varchar(255)
);

CREATE TABLE `sprinf_bd`.`malla_curricular` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `materia_id` varchar(255),
  `fase_id` varchar(255),
  `ponderacion` float
);

CREATE TABLE `sprinf_bd`.`materias` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `nombre` varchar(255),
  `htasist` int,
  `htind` int,
  `ucredito` int,
  `hrs_acad` int,
  `eje` varchar(255),
  `cursable` bool DEFAULT true
);

CREATE TABLE `sprinf_bd`.`profesor` (
  `codigo` varchar(255) UNIQUE PRIMARY KEY,
  `persona_id` int
);

CREATE TABLE `sprinf_bd`.`dimension` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `unidad_id` varchar(255),
  `nombre` varchar(255),
  `grupal` bool
);

CREATE TABLE `sprinf_bd`.`indicadores` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `dimension_id` int,
  `nombre` varchar(255),
  `ponderacion` float
);

CREATE TABLE `sprinf_bd`.`estudiante` (
  `id` varchar(255) UNIQUE PRIMARY KEY,
  `persona_id` int
);

CREATE TABLE `sprinf_bd`.`inscripcion` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `profesor_id` varchar(255),
  `seccion_id` varchar(255),
  `unidad_curricular_id` varchar(255),
  `estudiante_id` varchar(255),
  `calificacion` float,
  `estatus` int DEFAULT 1
);

CREATE TABLE `sprinf_bd`.`municipios` (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE `sprinf_bd`.`parroquias` (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    municipio INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE `sprinf_bd`.`sector_consejo_comunal` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `parroquia_id` int,
  `nombre` varchar(255)
);

CREATE TABLE `sprinf_bd`.`consejo_comunal` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255),
  `nombre_vocero` varchar(255),
  `telefono` varchar(255),
  `sector_id` int
);

CREATE TABLE `sprinf_bd`.`proyecto` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `fase_id` varchar(255) NOT NULL,
  `parroquia_id` int NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `comunidad` varchar(255) NOT NULL,
  `comunidad_autonoma` bool NOT NULL,
  `motor_productivo` varchar(255),
  `resumen` varchar(255),
  `direccion` varchar(255),
  `consejo_comunal_id` int,
  `observaciones` text,
  `tutor_in` varchar(255),
  `tutor_ex` varchar(255),
  `tlf_tin` varchar(12),
  `tlf_tex` varchar(12),
  `estatus` int,
  `cerrado` bool DEFAULT false
);

CREATE TABLE `sprinf_bd`.`integrante_proyecto` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `estudiante_id` varchar(255),
  `proyecto_id` int,
  `estatus` int DEFAULT 1
);

CREATE TABLE `sprinf_bd`.`notas_integrante_proyecto` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `indicador_id` int,
  `integrante_id` int,
  `calificacion` float
);

CREATE TABLE `sprinf_bd`.`persona` (
  `cedula` int UNIQUE PRIMARY KEY,
  `usuario_id` int,
  `nombre` varchar(255),
  `apellido` varchar(255),
  `direccion` text,
  `telefono` text,
  `estatus` bool
);

CREATE TABLE `sprinf_bd`.`usuario` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `rol_id` int,
  `email` varchar(255),
  `contrasena` varchar(255),
  `token` varchar(255)
);

CREATE TABLE `sprinf_bd`.`roles` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255)
);

CREATE TABLE `sprinf_bd`.`modulo` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255)
);

CREATE TABLE `sprinf_bd`.`permisos` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `rol_id` int,
  `modulo_id` int,
  `crear` bool,
  `consultar` bool,
  `actualizar` bool,
  `eliminar` bool
);

CREATE TABLE `sprinf_bd`.`proyecto_historico` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `id_proyecto` int,
  `consejo_comunal_id` int,
  `codigo_trayecto` varchar(255),
  `codigo_siguiente_trayecto` varchar(255),
  `nombre_estudiante` varchar(255),
  `cedula_estudiante` int,
  `nombre_proyecto` varchar(255),
  `nombre_trayecto` varchar(255),
  `resumen` varchar(255),
  `direccion` varchar(255),
  `comunidad` varchar(255),
  `motor_productivo` varchar(255),
  `nombre_consejo_comunal` varchar(255),
  `nombre_vocero_consejo_comunal` varchar(255),
  `telefono_consejo_comunal` varchar(255),
  `sector_consejo_comunal` varchar(255),
  `municipio` varchar(255),
  `parroquia_id` int,
  `parroquia` varchar(255),
  `observaciones` text,
  `tutor_in` varchar(255),
  `tutor_ex` varchar(255),
  `tlf_tex` varchar(255),
  `nota_fase_1` float,
  `nota_fase_2` float,
  `estatus` int,
  `periodo_inicio` date,
  `periodo_final` date
);

CREATE TABLE `sprinf_bd`.`bitacora` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `navegador` varchar(105) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_cierre` time DEFAULT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(80) NOT NULL,
  `token` varchar(85) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bitacora_usuario1_idx` (`usuario_id`),
  CONSTRAINT `fk_bitacora_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `sprinf_bd`.`pregunta` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `pregunta` varchar(255)
);

CREATE TABLE `sprinf_bd`.`respuestas` (
  `id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `respuesta` varchar(255) NOT NULL,
  `pregunta_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
);


ALTER TABLE `sprinf_bd`.`trayecto` ADD FOREIGN KEY (`periodo_id`) REFERENCES `sprinf_bd`.`periodo` (`id`);

ALTER TABLE `sprinf_bd`.`trayecto` ADD FOREIGN KEY (`siguiente_trayecto`) REFERENCES `sprinf_bd`.`trayecto` (`codigo`);

ALTER TABLE `sprinf_bd`.`fase` ADD FOREIGN KEY (`trayecto_id`) REFERENCES `sprinf_bd`.`trayecto` (`codigo`);

ALTER TABLE `sprinf_bd`.`fase` ADD FOREIGN KEY (`siguiente_fase`) REFERENCES `sprinf_bd`.`fase` (`codigo`);

ALTER TABLE `sprinf_bd`.`seccion` ADD FOREIGN KEY (`trayecto_id`) REFERENCES `sprinf_bd`.`trayecto` (`codigo`);

ALTER TABLE `sprinf_bd`.`malla_curricular` ADD FOREIGN KEY (`materia_id`) REFERENCES `sprinf_bd`.`materias` (`codigo`);

ALTER TABLE `sprinf_bd`.`malla_curricular` ADD FOREIGN KEY (`fase_id`) REFERENCES `sprinf_bd`.`fase` (`codigo`);

ALTER TABLE `sprinf_bd`.`profesor` ADD FOREIGN KEY (`persona_id`) REFERENCES `sprinf_bd`.`persona` (`cedula`);

ALTER TABLE `sprinf_bd`.`dimension` ADD FOREIGN KEY (`unidad_id`) REFERENCES `sprinf_bd`.`malla_curricular` (`codigo`);

ALTER TABLE `sprinf_bd`.`indicadores` ADD FOREIGN KEY (`dimension_id`) REFERENCES `sprinf_bd`.`dimension` (`id`) ON DELETE CASCADE;

ALTER TABLE `sprinf_bd`.`estudiante` ADD FOREIGN KEY (`persona_id`) REFERENCES `sprinf_bd`.`persona` (`cedula`);

ALTER TABLE `sprinf_bd`.`inscripcion` ADD FOREIGN KEY (`profesor_id`) REFERENCES `sprinf_bd`.`profesor` (`codigo`);

ALTER TABLE `sprinf_bd`.`inscripcion` ADD FOREIGN KEY (`seccion_id`) REFERENCES `sprinf_bd`.`seccion` (`codigo`);

ALTER TABLE `sprinf_bd`.`inscripcion` ADD FOREIGN KEY (`unidad_curricular_id`) REFERENCES `sprinf_bd`.`malla_curricular` (`codigo`);

ALTER TABLE `sprinf_bd`.`inscripcion` ADD FOREIGN KEY (`estudiante_id`) REFERENCES `sprinf_bd`.`estudiante` (`id`);

ALTER TABLE `sprinf_bd`.`parroquias` ADD FOREIGN KEY (`municipio`) REFERENCES `sprinf_bd`.`municipios` (`id`);

ALTER TABLE `sprinf_bd`.`sector_consejo_comunal` ADD FOREIGN KEY (`parroquia_id`) REFERENCES `sprinf_bd`.`parroquias` (`id`);

ALTER TABLE `sprinf_bd`.`consejo_comunal` ADD FOREIGN KEY (`sector_id`) REFERENCES `sprinf_bd`.`sector_consejo_comunal` (`id`);

ALTER TABLE `sprinf_bd`.`proyecto` ADD FOREIGN KEY (`fase_id`) REFERENCES `sprinf_bd`.`fase` (`codigo`);

ALTER TABLE `sprinf_bd`.`proyecto` ADD FOREIGN KEY (`tutor_in`) REFERENCES `sprinf_bd`.`profesor` (`codigo`);


ALTER TABLE `sprinf_bd`.`proyecto` ADD FOREIGN KEY (`consejo_comunal_id`) REFERENCES `sprinf_bd`.`consejo_comunal` (`id`);

ALTER TABLE `sprinf_bd`.`proyecto` ADD FOREIGN KEY (`parroquia_id`) REFERENCES `sprinf_bd`.`parroquias` (`id`);

ALTER TABLE `sprinf_bd`.`integrante_proyecto` ADD FOREIGN KEY (`estudiante_id`) REFERENCES `sprinf_bd`.`estudiante` (`id`);

ALTER TABLE `sprinf_bd`.`integrante_proyecto` ADD FOREIGN KEY (`proyecto_id`) REFERENCES `sprinf_bd`.`proyecto` (`id`);

ALTER TABLE `sprinf_bd`.`notas_integrante_proyecto` ADD FOREIGN KEY (`indicador_id`) REFERENCES `sprinf_bd`.`indicadores` (`id`) ON DELETE CASCADE;

ALTER TABLE `sprinf_bd`.`notas_integrante_proyecto` ADD FOREIGN KEY (`integrante_id`) REFERENCES `sprinf_bd`.`integrante_proyecto` (`id`) ON DELETE CASCADE;

ALTER TABLE `sprinf_bd`.`persona` ADD FOREIGN KEY (`usuario_id`) REFERENCES `sprinf_bd`.`usuario` (`id`);

ALTER TABLE `sprinf_bd`.`usuario` ADD FOREIGN KEY (`rol_id`) REFERENCES `sprinf_bd`.`roles` (`id`);

ALTER TABLE `sprinf_bd`.`permisos` ADD FOREIGN KEY (`rol_id`) REFERENCES `sprinf_bd`.`roles` (`id`);

ALTER TABLE `sprinf_bd`.`permisos` ADD FOREIGN KEY (`modulo_id`) REFERENCES `sprinf_bd`.`modulo` (`id`);

ALTER TABLE `sprinf_bd`.`respuestas` ADD FOREIGN KEY (`usuario_id`) REFERENCES `sprinf_bd`.`usuario` (`id`);

ALTER TABLE `sprinf_bd`.`respuestas` ADD FOREIGN KEY (`pregunta_id`) REFERENCES `sprinf_bd`.`pregunta` (`id`);


use sprinf_bd;
-- 1_usuarios
delete from permisos where true;
delete from modulo where true;
delete from roles where true;
delete from persona where true;
delete from usuario where true;

-- ROLES
insert into roles (id, nombre) values (1, 'administrador'), (2, 'profesor'), (3, 'coordinador'), (4, 'estudiante');

-- modulos
insert into modulo (id, nombre) values (1, 'Proyecto');
insert into modulo (id, nombre) values (2, 'Materias');

-- permisos
insert into permisos (id, consultar, actualizar, crear, eliminar, rol_id, modulo_id) values (1, 1, 1, 1, 1, 1, 1);
insert into permisos (id, consultar, actualizar, crear, eliminar, rol_id, modulo_id) values (2, 1, 1, 1, 1, 1, 2);


-- usuarios
insert into usuario (rol_id, email, contrasena, token) values (1,'root@gmail.com',"$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72", 'fsadfsadfsadf');

insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (1, '28566432', 'Admin', 'admin', 'Urb. La Concordia', '04247777777', 1);

-- usuarios roles
-- insert into roles_usuarios (rol_id, usuario_id) values (1,1);


-- 2_profesores
delete from profesor where true;
delete from persona where usuario_id != 1;
delete from usuario where id != 1;


-- Profesora Sonia
insert into usuario (id,rol_id,email, contrasena, token)
values (2,2,'sonia@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (2, '9619518', 'Sonia', 'Cordoba', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', '2548475154', 1);
insert into profesor (codigo, persona_id) values ('p-135482354',135482354);

-- Profesor Ricardo Tillero
insert into usuario (id,rol_id,email, contrasena, token)
values (3,2,'ricardo@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (3, '654854354', 'Ricardo', 'Tillero', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', '2548475154', 1);
insert into profesor (codigo, persona_id) values ('p-654854354',654854354);


-- Profesor Orlando 
insert into usuario (id,rol_id,email, contrasena, token)
values (4,2,'orlando@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (4, '234565423', 'Orlando', 'Guerra', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', '2548475154', 1);
insert into profesor (codigo, persona_id) values ('p-234565423',234565423);

-- Profesora Lisset
insert into usuario (id,rol_id,email, contrasena, token)
values (5,2,'lisset@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (5, '125487', 'Lissette', 'Torrealba', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', '2548475154', 1);
insert into profesor (codigo, persona_id) values ('p-125487',125487);

-- Profesor orlando 
insert into usuario (id,rol_id,email, contrasena, token)
values (6,2,'oswaldo@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (6, '7404027', 'Oswaldo', 'Aparicio', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-132654318',132654318);

-- Profesora pura
insert into usuario (id,rol_id,email, contrasena, token)
values (7,2,'pura@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (7, '7392496', 'Pura', 'Castillo', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-52844735',52844735);

-- profesora Ligia
insert into usuario (id,rol_id,email, contrasena, token)
values (9,2,'ligia@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (9, '13991250', 'Ligia', 'Durán', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-354487534',354487534);


-- profesora Ingrid
insert into usuario (id,rol_id,email, contrasena, token)
values (10,2,'ingrid@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (10, '7423485', 'Ingrid', 'Figueroa', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-3542874',3542874);

-- profesora Lerida
insert into usuario (id,rol_id,email, contrasena, token)
values (11,2,'lerida@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (11, '11264888', 'Lerida', 'Figueroa', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-54875538',54875538);

-- profesora Ruben
insert into usuario (id,rol_id,email, contrasena, token)
values (12,2,'ruben@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (12, '9629702', 'Ruben', 'Godoy', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-5487531',5487531);

-- profesora Indira
insert into usuario (id,rol_id,email, contrasena, token)
values (13,2,'indira@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (13, '15693145', 'Indira', 'Gonzáles', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-523156847',523156847);

-- profesora Indira
insert into usuario (id,rol_id,email, contrasena, token)
values (14,2,'marling@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (14, '13527711', 'Marling', 'Brito', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-2658475',2658475);


insert into usuario (id,rol_id,email, contrasena, token)
values (17,2,'josesequera@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (17, '5428468', 'Jose', 'Sequera', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-5428468',5428468);


insert into usuario (id,rol_id,email, contrasena, token)
values (18,2,'pedro@gmail.com','$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono, estatus) 
values (18, '52213548', 'Pedro', 'Castillo', 'ZoV52kTa1gsiY4C37GxsEUz1PPSEB7l3EWTrsLmPMkdElicxxx/X1iTzEY9v3T3S/b0YgDano3dNQwpdtLgHd4mL8dqEbaogXO5rZ7SdQIdP2mbamjq2lchTzzJiWEaTAs/S60fjoqBTM6dH9R6W5QgjHBXdrybwjnXvZl3doRzlTqJAr7rt/jnRDtiAZbAwxWJ6Q1/8u6p8dEK0ZPmeGYiXRPPMT6D3zG6RzoARHYzPeWAsTIiLCZi/Cn5j1E7cOoY1or9xsNxDL8IlUMCF6ljL0KNrn1wYLJ35kAycUEPm4JZqTcP4Y5F1K5ftCHwbQxwhvQHMoIdaYY05gaZOnyU2uwHKuf1JuGa8805sB3hOIl9IWjuhBh5CtbHFPwVn9oB7neR6qxmtARPozSXaou3GM5bc98OAlKiP48BaQ01ktxu9Wzr20nFDiMn+H3wVqYoTkQZ3eikrN2rrVyV9ixKrp0AkppoJUAXb9qMCqdP+UHAOIIwLAMiVuOx0ki+hZvPJTRx//NnpcHC+PrGEQSDMVBFj7ai+nFIjBnjRKvwRgu0Cw26e7l6Xa2dXrx92W4vZPgGO2bMWQ7KXgSeseOIbprS/iw+XsAEEH5WZMRx0Nai/YG4wCD3x9a7OkJQiIy92AJgarO0FOtvvUXjlIMf/1E8iJn3pecY5E+Y1msM=', 'WXsjxxCSSjrih+s2QwNSEUPPoE/D+jUqfv0W33mehLZjThcOO34Gpz/FxGACG+ivQOKrbgLnYoIpQm0npRBMtL9ZMpqzAkcXLMErvMXJED8IXXfJG0aBDH6JFKkqZSFCbNofpPI8ieEn+iiJ2QZryH/h4X3SgVlBGROWMlNboh8wX5HzihPoat8u976BT85RfUfzC1KJ+/hEJV7U2AA4z8+qXJwj+fmE2GuiIGsmZ8R1xkcDlZyqzVUPxoagxJSwJtoD9H3/cSYJJSwrd5pe/JQmxxRMdRydD78aEMxh9Y+aZX5XIZb0x9s+VLiR/3kUA3GSJ5gw/c0n5QpMQVkNjZtEfRIJAaRumOBGpL8qJcHQHd0w+MAuig1HzkTJcWVdPY8SPC8OkRoAbV3SKxWg0UQHPHnor7frlshd+3AiPy7IGibue2g2C6zQgecCDEhr0QPnhPV/Ti8/Q9RW6UHJ4JUOoBTHaoDf8OvvA7x74u5CHOGtOUsu2kL1WjgZ36jn7iOwZcxSGTKHGJDtXuckSYWB0ua5uc/HYzabn4dxS4Sxro4dpEg/kicFeeIiUoHBoosgKrIGkUhKY3/x6CnJklJ0+2oc6W/K1H5SKODRceoVLOtNjZXj6IK6hVTyumOW8T7/lanvHM8AnpK7EjRTW9xt/njNs1nVdaThX+KyLkU=', 1);
insert into profesor (codigo, persona_id) values ('p-52213548',52213548);

-- 3_estudiante.sql

insert into usuario (id, rol_id, email, contrasena, token) values( 19, 4, 'Carlosestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (19,15408, 'Carlos', 'Ramirez', 'Urb. La Concordia', 6309710917);
insert into estudiante (id, persona_id) values ('e-15408',15408);

insert into usuario (id, rol_id, email, contrasena, token) values( 20, 4, 'Saraiestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (20,63578, 'Sarai', 'Perez', '4th Floor', 5994995192);
insert into estudiante (id, persona_id) values ('e-63578',63578);

insert into usuario (id, rol_id, email, contrasena, token) values( 21, 4, 'Kevinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (21,39263, 'Kevin', 'Heredia', 'Suite 3', 8337046607);
insert into estudiante (id, persona_id) values ('e-39263',39263);

insert into usuario (id, rol_id, email, contrasena, token) values( 22, 4, 'Dardaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (22,60621, 'Darda', 'Hawse', 'PO Box 53964', 5321483304);
insert into estudiante (id, persona_id) values ('e-60621',60621);

insert into usuario (id, rol_id, email, contrasena, token) values( 23, 4, 'Ivettestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (23,61587, 'Ivett', 'Cristofor', '7th Floor', 1376234675);
insert into estudiante (id, persona_id) values ('e-61587',61587);

insert into usuario (id, rol_id, email, contrasena, token) values( 24, 4, 'Marlenaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (24,13870, 'Marlena', 'Elleyne', 'PO Box 46998', 9441765234);
insert into estudiante (id, persona_id) values ('e-13870',13870);

insert into usuario (id, rol_id, email, contrasena, token) values( 25, 4, 'Isabelleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (25,20184, 'Isabelle', 'Iskower', 'Room 1186', 1024228847);
insert into estudiante (id, persona_id) values ('e-20184',20184);

insert into usuario (id, rol_id, email, contrasena, token) values( 26, 4, 'Esteleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (26,62153, 'Estele', 'Fantin', 'Room 1692', 8182714338);
insert into estudiante (id, persona_id) values ('e-62153',62153);

insert into usuario (id, rol_id, email, contrasena, token) values( 27, 4, 'Lanieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (27,37236, 'Lanie', 'Kalker', 'PO Box 12000', 5921709020);
insert into estudiante (id, persona_id) values ('e-37236',37236);

insert into usuario (id, rol_id, email, contrasena, token) values( 28, 4, 'Findlayestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (28,68999, 'Findlay', 'Collingworth', 'Room 1873', 4917882637);
insert into estudiante (id, persona_id) values ('e-68999',68999);

insert into usuario (id, rol_id, email, contrasena, token) values( 29, 4, 'Sophieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (29,48778, 'Sophie', 'Gluyus', 'Room 1563', 1802695771);
insert into estudiante (id, persona_id) values ('e-48778',48778);

insert into usuario (id, rol_id, email, contrasena, token) values( 30, 4, 'Jenifferestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (30,49908, 'Jeniffer', 'Brolechan', 'PO Box 35480', 6128084682);
insert into estudiante (id, persona_id) values ('e-49908',49908);

insert into usuario (id, rol_id, email, contrasena, token) values( 31, 4, 'Humfriedestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (31,23764, 'Humfried', 'Jozef', 'Suite 40', 8389817223);
insert into estudiante (id, persona_id) values ('e-23764',23764);

insert into usuario (id, rol_id, email, contrasena, token) values( 32, 4, 'Bartholemyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (32,37616, 'Bartholemy', 'Adami', 'Apt 448', 2171245276);
insert into estudiante (id, persona_id) values ('e-37616',37616);

insert into usuario (id, rol_id, email, contrasena, token) values( 33, 4, 'Earvinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (33,77765, 'Earvin', 'Roblett', 'PO Box 16438', 9196383852);
insert into estudiante (id, persona_id) values ('e-77765',77765);

insert into usuario (id, rol_id, email, contrasena, token) values( 34, 4, 'Dionneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (34,14595, 'Dionne', 'Alfonso', 'Room 529', 5029447898);
insert into estudiante (id, persona_id) values ('e-14595',14595);

insert into usuario (id, rol_id, email, contrasena, token) values( 35, 4, 'Saxeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (35,81438, 'Saxe', 'Bartot', 'PO Box 1398', 3104239329);
insert into estudiante (id, persona_id) values ('e-81438',81438);

insert into usuario (id, rol_id, email, contrasena, token) values( 36, 4, 'Karolaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (36,52673, 'Karola', 'O''Bruen', 'Apt 1865', 5721362085);
insert into estudiante (id, persona_id) values ('e-52673',52673);

insert into usuario (id, rol_id, email, contrasena, token) values( 37, 4, 'Alessandroestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (37,74599, 'Alessandro', 'Brosius', 'Apt 903', 2072310319);
insert into estudiante (id, persona_id) values ('e-74599',74599);

insert into usuario (id, rol_id, email, contrasena, token) values( 38, 4, 'Terenceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (38,80516, 'Terence', 'McNirlan', 'Room 958', 2689941275);
insert into estudiante (id, persona_id) values ('e-80516',80516);

insert into usuario (id, rol_id, email, contrasena, token) values( 39, 4, 'Cosimoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (39,71403, 'Cosimo', 'Corbally', 'Suite 12', 7355350697);
insert into estudiante (id, persona_id) values ('e-71403',71403);

insert into usuario (id, rol_id, email, contrasena, token) values( 40, 4, 'Zebedeeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (40,45059, 'Zebedee', 'Manolov', '1st Floor', 5859909971);
insert into estudiante (id, persona_id) values ('e-45059',45059);

insert into usuario (id, rol_id, email, contrasena, token) values( 41, 4, 'Sharlaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (41,80292, 'Sharla', 'Torri', '10th Floor', 6648559209);
insert into estudiante (id, persona_id) values ('e-80292',80292);

insert into usuario (id, rol_id, email, contrasena, token) values( 42, 4, 'Addaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (42,57692, 'Adda', 'Cammacke', 'Room 34', 3042762435);
insert into estudiante (id, persona_id) values ('e-57692',57692);

insert into usuario (id, rol_id, email, contrasena, token) values( 43, 4, 'Eileenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (43,20828, 'Eileen', 'Temporal', 'PO Box 42455', 9539277299);
insert into estudiante (id, persona_id) values ('e-20828',20828);

insert into usuario (id, rol_id, email, contrasena, token) values( 44, 4, 'Roannaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (44,62963, 'Roanna', 'Bavage', 'PO Box 1875', 5958629767);
insert into estudiante (id, persona_id) values ('e-62963',62963);

insert into usuario (id, rol_id, email, contrasena, token) values( 45, 4, 'Jamieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (45,86463, 'Jamie', 'Meneghi', 'Apt 1350', 1643168980);
insert into estudiante (id, persona_id) values ('e-86463',86463);

insert into usuario (id, rol_id, email, contrasena, token) values( 46, 4, 'Adrienaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (46,79346, 'Adriena', 'Cunniffe', 'Suite 42', 6388329604);
insert into estudiante (id, persona_id) values ('e-79346',79346);

insert into usuario (id, rol_id, email, contrasena, token) values( 47, 4, 'Baldestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (47,75652, 'Bald', 'Rowlstone', 'PO Box 48805', 9993137416);
insert into estudiante (id, persona_id) values ('e-75652',75652);

insert into usuario (id, rol_id, email, contrasena, token) values( 48, 4, 'Packstonestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (48,20796, 'Packston', 'Marlen', '15th Floor', 5778285183);
insert into estudiante (id, persona_id) values ('e-20796',20796);

insert into usuario (id, rol_id, email, contrasena, token) values( 49, 4, 'Pearlestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (49,64905, 'Pearl', 'Kennewell', 'Apt 1780', 5194271275);
insert into estudiante (id, persona_id) values ('e-64905',64905);

insert into usuario (id, rol_id, email, contrasena, token) values( 50, 4, 'Chickyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (50,50334, 'Chicky', 'Kimbell', 'Apt 70', 6407749735);
insert into estudiante (id, persona_id) values ('e-50334',50334);

insert into usuario (id, rol_id, email, contrasena, token) values( 51, 4, 'Dorieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (51,45159, 'Dorie', 'Doughty', 'PO Box 57248', 9487118110);
insert into estudiante (id, persona_id) values ('e-45159',45159);

insert into usuario (id, rol_id, email, contrasena, token) values( 52, 4, 'Skippestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (52,32079, 'Skipp', 'MacEllen', 'Apt 121', 7616833734);
insert into estudiante (id, persona_id) values ('e-32079',32079);

insert into usuario (id, rol_id, email, contrasena, token) values( 53, 4, 'Brynneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (53,23888, 'Brynne', 'Teresi', 'Room 1248', 2752897733);
insert into estudiante (id, persona_id) values ('e-23888',23888);

insert into usuario (id, rol_id, email, contrasena, token) values( 54, 4, 'Merylestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (54,41657, 'Meryl', 'Handes', 'Suite 80', 8798319701);
insert into estudiante (id, persona_id) values ('e-41657',41657);

insert into usuario (id, rol_id, email, contrasena, token) values( 55, 4, 'Emmyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (55,75011, 'Emmy', 'Dryburgh', 'Apt 606', 1511178117);
insert into estudiante (id, persona_id) values ('e-75011',75011);

insert into usuario (id, rol_id, email, contrasena, token) values( 56, 4, 'Aubineestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (56,49467, 'Aubine', 'Eddie', 'PO Box 40197', 7089997433);
insert into estudiante (id, persona_id) values ('e-49467',49467);

insert into usuario (id, rol_id, email, contrasena, token) values( 57, 4, 'Janeanestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (57,87722, 'Janean', 'Bloschke', 'Suite 40', 9094430342);
insert into estudiante (id, persona_id) values ('e-87722',87722);

insert into usuario (id, rol_id, email, contrasena, token) values( 58, 4, 'Jeddyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (58,16082, 'Jeddy', 'Andrews', 'Suite 79', 9501297593);
insert into estudiante (id, persona_id) values ('e-16082',16082);

insert into usuario (id, rol_id, email, contrasena, token) values( 59, 4, 'Juninaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (59,57345, 'Junina', 'Prescott', 'Room 191', 4421683103);
insert into estudiante (id, persona_id) values ('e-57345',57345);

insert into usuario (id, rol_id, email, contrasena, token) values( 60, 4, 'Randyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (60,21796, 'Randy', 'Goskar', 'Suite 96', 9171525853);
insert into estudiante (id, persona_id) values ('e-21796',21796);

insert into usuario (id, rol_id, email, contrasena, token) values( 61, 4, 'Janayaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (61,22377, 'Janaya', 'Tart', '16th Floor', 2238677288);
insert into estudiante (id, persona_id) values ('e-22377',22377);

insert into usuario (id, rol_id, email, contrasena, token) values( 62, 4, 'Nigelestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (62,35799, 'Nigel', 'Levesque', 'Room 1634', 6468697250);
insert into estudiante (id, persona_id) values ('e-35799',35799);

insert into usuario (id, rol_id, email, contrasena, token) values( 63, 4, 'Julieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (63,19528, 'Julie', 'Kinkead', 'Suite 37', 1331286513);
insert into estudiante (id, persona_id) values ('e-19528',19528);

insert into usuario (id, rol_id, email, contrasena, token) values( 64, 4, 'Nickeyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (64,53322, 'Nickey', 'Brose', 'Apt 1319', 9045575180);
insert into estudiante (id, persona_id) values ('e-53322',53322);

insert into usuario (id, rol_id, email, contrasena, token) values( 65, 4, 'Jeannineestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (65,11288, 'Jeannine', 'Castan', 'Apt 237', 6528481168);
insert into estudiante (id, persona_id) values ('e-11288',11288);

insert into usuario (id, rol_id, email, contrasena, token) values( 66, 4, 'Doreestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (66,19805, 'Dore', 'Aldie', 'Apt 1674', 9745762617);
insert into estudiante (id, persona_id) values ('e-19805',19805);

insert into usuario (id, rol_id, email, contrasena, token) values( 67, 4, 'Bernhardestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (67,78117, 'Bernhard', 'Withnall', '2nd Floor', 2209331499);
insert into estudiante (id, persona_id) values ('e-78117',78117);

insert into usuario (id, rol_id, email, contrasena, token) values( 68, 4, 'Stormieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (68,34330, 'Stormie', 'Junkison', 'PO Box 13374', 4697983058);
insert into estudiante (id, persona_id) values ('e-34330',34330);

insert into usuario (id, rol_id, email, contrasena, token) values( 69, 4, 'Sheereeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (69,53890, 'Sheeree', 'Gilding', '16th Floor', 5217095845);
insert into estudiante (id, persona_id) values ('e-53890',53890);

insert into usuario (id, rol_id, email, contrasena, token) values( 70, 4, 'Malchyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (70,49746, 'Malchy', 'Dollimore', 'Apt 1915', 6978190304);
insert into estudiante (id, persona_id) values ('e-49746',49746);

insert into usuario (id, rol_id, email, contrasena, token) values( 71, 4, 'Stephanusestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (71,72439, 'Stephanus', 'Rippon', '6th Floor', 3014677293);
insert into estudiante (id, persona_id) values ('e-72439',72439);

insert into usuario (id, rol_id, email, contrasena, token) values( 72, 4, 'Nobleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (72,35658, 'Noble', 'Jurges', 'Suite 72', 3772675562);
insert into estudiante (id, persona_id) values ('e-35658',35658);

insert into usuario (id, rol_id, email, contrasena, token) values( 73, 4, 'Hunfredoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (73,52260, 'Hunfredo', 'Vaskov', 'Suite 22', 4352382927);
insert into estudiante (id, persona_id) values ('e-52260',52260);

insert into usuario (id, rol_id, email, contrasena, token) values( 74, 4, 'Heywoodestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (74,87958, 'Heywood', 'Impleton', '15th Floor', 5051032810);
insert into estudiante (id, persona_id) values ('e-87958',87958);

insert into usuario (id, rol_id, email, contrasena, token) values( 75, 4, 'Goldaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (75,23393, 'Golda', 'Rubinfajn', 'Room 946', 2663111280);
insert into estudiante (id, persona_id) values ('e-23393',23393);

insert into usuario (id, rol_id, email, contrasena, token) values( 76, 4, 'Abbyeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (76,88439, 'Abbye', 'Kissock', 'Apt 349', 7091696196);
insert into estudiante (id, persona_id) values ('e-88439',88439);

insert into usuario (id, rol_id, email, contrasena, token) values( 77, 4, 'Susanestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (77,20746, 'Susan', 'Fehner', 'Room 10', 8234538049);
insert into estudiante (id, persona_id) values ('e-20746',20746);

insert into usuario (id, rol_id, email, contrasena, token) values( 78, 4, 'Thorpeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (78,53133, 'Thorpe', 'Burkinshaw', '7th Floor', 7203909706);
insert into estudiante (id, persona_id) values ('e-53133',53133);

insert into usuario (id, rol_id, email, contrasena, token) values( 79, 4, 'Ingridestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (79,48538, 'Ingrid', 'Neesam', 'Apt 1711', 7132896717);
insert into estudiante (id, persona_id) values ('e-48538',48538);

insert into usuario (id, rol_id, email, contrasena, token) values( 80, 4, 'Harrietestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (80,22078, 'Harriet', 'Ohlsen', 'Apt 326', 4299278559);
insert into estudiante (id, persona_id) values ('e-22078',22078);

insert into usuario (id, rol_id, email, contrasena, token) values( 81, 4, 'Colasestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (81,84692, 'Colas', 'Vanyukov', '19th Floor', 1146410243);
insert into estudiante (id, persona_id) values ('e-84692',84692);

insert into usuario (id, rol_id, email, contrasena, token) values( 82, 4, 'Verieeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (82,42693, 'Veriee', 'Eskrigg', 'Apt 924', 1446799661);
insert into estudiante (id, persona_id) values ('e-42693',42693);

insert into usuario (id, rol_id, email, contrasena, token) values( 83, 4, 'Lynnestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (83,43280, 'Lynn', 'Menchenton', 'Room 1343', 5459450754);
insert into estudiante (id, persona_id) values ('e-43280',43280);

insert into usuario (id, rol_id, email, contrasena, token) values( 84, 4, 'Lorrinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (84,20589, 'Lorrin', 'Durgan', 'Suite 90', 5725952836);
insert into estudiante (id, persona_id) values ('e-20589',20589);

insert into usuario (id, rol_id, email, contrasena, token) values( 85, 4, 'Renelleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (85,82420, 'Renelle', 'Olanda', 'Room 34', 2323173517);
insert into estudiante (id, persona_id) values ('e-82420',82420);

insert into usuario (id, rol_id, email, contrasena, token) values( 86, 4, 'Kassandraestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (86,35839, 'Kassandra', 'Grassin', 'Suite 19', 1083908556);
insert into estudiante (id, persona_id) values ('e-35839',35839);

insert into usuario (id, rol_id, email, contrasena, token) values( 87, 4, 'Heddiestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (87,38303, 'Heddi', 'Sorbey', 'Apt 1689', 6465071618);
insert into estudiante (id, persona_id) values ('e-38303',38303);

insert into usuario (id, rol_id, email, contrasena, token) values( 88, 4, 'Martheestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (88,79810, 'Marthe', 'Ambrogio', 'PO Box 23891', 9496222326);
insert into estudiante (id, persona_id) values ('e-79810',79810);

insert into usuario (id, rol_id, email, contrasena, token) values( 89, 4, 'Deboraestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (89,58929, 'Debora', 'Geldeford', 'Apt 1532', 5612734104);
insert into estudiante (id, persona_id) values ('e-58929',58929);

insert into usuario (id, rol_id, email, contrasena, token) values( 90, 4, 'Gustavestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (90,35822, 'Gustav', 'Rothman', '7th Floor', 2066186687);
insert into estudiante (id, persona_id) values ('e-35822',35822);

insert into usuario (id, rol_id, email, contrasena, token) values( 91, 4, 'Idaliaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (91,35336, 'Idalia', 'Carratt', 'Suite 25', 7226149062);
insert into estudiante (id, persona_id) values ('e-35336',35336);

insert into usuario (id, rol_id, email, contrasena, token) values( 92, 4, 'Alieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (92,79153, 'Alie', 'Doumenc', 'Apt 1094', 7206570728);
insert into estudiante (id, persona_id) values ('e-79153',79153);

insert into usuario (id, rol_id, email, contrasena, token) values( 93, 4, 'Leonieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (93,79969, 'Leonie', 'Vasse', '1st Floor', 1918440867);
insert into estudiante (id, persona_id) values ('e-79969',79969);

insert into usuario (id, rol_id, email, contrasena, token) values( 94, 4, 'Bootestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (94,68428, 'Boot', 'Steaning', 'Suite 8', 3848141845);
insert into estudiante (id, persona_id) values ('e-68428',68428);

insert into usuario (id, rol_id, email, contrasena, token) values( 95, 4, 'Yuriestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (95,52038, 'Yuri', 'Osmar', 'Apt 863', 3427224290);
insert into estudiante (id, persona_id) values ('e-52038',52038);

insert into usuario (id, rol_id, email, contrasena, token) values( 96, 4, 'Theodoricestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (96,23646, 'Theodoric', 'Silversmidt', 'Room 1809', 1784221325);
insert into estudiante (id, persona_id) values ('e-23646',23646);

insert into usuario (id, rol_id, email, contrasena, token) values( 97, 4, 'Levonestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (97,59506, 'Levon', 'Stuttard', '8th Floor', 7414852821);
insert into estudiante (id, persona_id) values ('e-59506',59506);

insert into usuario (id, rol_id, email, contrasena, token) values( 98, 4, 'Leighestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (98,51182, 'Leigh', 'Ruppert', 'Room 83', 8045802131);
insert into estudiante (id, persona_id) values ('e-51182',51182);

insert into usuario (id, rol_id, email, contrasena, token) values( 99, 4, 'Demetraestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (99,74060, 'Demetra', 'Lochran', 'Suite 41', 3706349413);
insert into estudiante (id, persona_id) values ('e-74060',74060);

insert into usuario (id, rol_id, email, contrasena, token) values( 100, 4, 'Joeannestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (100,51942, 'Joeann', 'Boule', 'Apt 1329', 2419868870);
insert into estudiante (id, persona_id) values ('e-51942',51942);

insert into usuario (id, rol_id, email, contrasena, token) values( 101, 4, 'Arielestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (101,70199, 'Ariel', 'Barlie', 'Suite 37', 7208747862);
insert into estudiante (id, persona_id) values ('e-70199',70199);

insert into usuario (id, rol_id, email, contrasena, token) values( 102, 4, 'Rawleyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (102,31622, 'Rawley', 'Bauser', '17th Floor', 5441809991);
insert into estudiante (id, persona_id) values ('e-31622',31622);

insert into usuario (id, rol_id, email, contrasena, token) values( 103, 4, 'Olenolinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (103,26201, 'Olenolin', 'Stanwix', 'Room 1442', 2668588091);
insert into estudiante (id, persona_id) values ('e-26201',26201);

insert into usuario (id, rol_id, email, contrasena, token) values( 104, 4, 'Vickestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (104,84669, 'Vick', 'Beckwith', 'Apt 1093', 3682297458);
insert into estudiante (id, persona_id) values ('e-84669',84669);

insert into usuario (id, rol_id, email, contrasena, token) values( 105, 4, 'Benedictaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (105,54550, 'Benedicta', 'Rolles', 'Suite 51', 7598721412);
insert into estudiante (id, persona_id) values ('e-54550',54550);

insert into usuario (id, rol_id, email, contrasena, token) values( 106, 4, 'Lucilaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (106,11663, 'Lucila', 'Canwell', 'Apt 709', 7712401143);
insert into estudiante (id, persona_id) values ('e-11663',11663);

insert into usuario (id, rol_id, email, contrasena, token) values( 107, 4, 'Bobbieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (107,89609, 'Bobbie', 'Semaine', '19th Floor', 7896007919);
insert into estudiante (id, persona_id) values ('e-89609',89609);

insert into usuario (id, rol_id, email, contrasena, token) values( 108, 4, 'Hurleeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (108,81233, 'Hurlee', 'Girardoni', 'PO Box 69262', 2739975417);
insert into estudiante (id, persona_id) values ('e-81233',81233);

insert into usuario (id, rol_id, email, contrasena, token) values( 109, 4, 'Hieronymusestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (109,85473, 'Hieronymus', 'Benet', 'Room 1888', 2824767282);
insert into estudiante (id, persona_id) values ('e-85473',85473);

insert into usuario (id, rol_id, email, contrasena, token) values( 110, 4, 'Elijahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (110,73409, 'Elijah', 'Colgan', 'PO Box 11081', 3994175392);
insert into estudiante (id, persona_id) values ('e-73409',73409);

insert into usuario (id, rol_id, email, contrasena, token) values( 111, 4, 'Peirceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (111,57391, 'Peirce', 'Bream', 'Room 168', 8575215209);
insert into estudiante (id, persona_id) values ('e-57391',57391);

insert into usuario (id, rol_id, email, contrasena, token) values( 112, 4, 'Casperestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (112,31631, 'Casper', 'Ackerman', 'PO Box 67376', 9281447962);
insert into estudiante (id, persona_id) values ('e-31631',31631);

insert into usuario (id, rol_id, email, contrasena, token) values( 113, 4, 'Ulickestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (113,73377, 'Ulick', 'Bartozzi', 'Apt 1294', 8063427244);
insert into estudiante (id, persona_id) values ('e-73377',73377);

insert into usuario (id, rol_id, email, contrasena, token) values( 114, 4, 'Calhounestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (114,45807, 'Calhoun', 'Haszard', 'PO Box 64965', 5376303812);
insert into estudiante (id, persona_id) values ('e-45807',45807);

insert into usuario (id, rol_id, email, contrasena, token) values( 115, 4, 'Monicaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (115,84611, 'Monica', 'Pridden', '9th Floor', 5348325287);
insert into estudiante (id, persona_id) values ('e-84611',84611);

insert into usuario (id, rol_id, email, contrasena, token) values( 116, 4, 'Aleksandrestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (116,54554, 'Aleksandr', 'Dy', 'Apt 609', 2348363610);
insert into estudiante (id, persona_id) values ('e-54554',54554);

insert into usuario (id, rol_id, email, contrasena, token) values( 117, 4, 'Vivieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (117,87569, 'Vivie', 'Blaase', 'PO Box 21641', 7556321009);
insert into estudiante (id, persona_id) values ('e-87569',87569);

insert into usuario (id, rol_id, email, contrasena, token) values( 118, 4, 'Loyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (118,44702, 'Loy', 'Dulany', 'Apt 1803', 5626192130);
insert into estudiante (id, persona_id) values ('e-44702',44702);

insert into usuario (id, rol_id, email, contrasena, token) values( 119, 4, 'Tawnyaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (119,69504, 'Tawnya', 'Castard', 'Apt 258', 9337489168);
insert into estudiante (id, persona_id) values ('e-69504',69504);

insert into usuario (id, rol_id, email, contrasena, token) values( 120, 4, 'Milkaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (120,12451, 'Milka', 'Ramet', 'PO Box 70119', 5019478723);
insert into estudiante (id, persona_id) values ('e-12451',12451);

insert into usuario (id, rol_id, email, contrasena, token) values( 121, 4, 'Mariceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (121,16269, 'Marice', 'Pedri', 'Room 210', 4134459762);
insert into estudiante (id, persona_id) values ('e-16269',16269);

insert into usuario (id, rol_id, email, contrasena, token) values( 122, 4, 'Minervaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (122,79591, 'Minerva', 'Kiljan', 'PO Box 74614', 9921689379);
insert into estudiante (id, persona_id) values ('e-79591',79591);

insert into usuario (id, rol_id, email, contrasena, token) values( 123, 4, 'Darrenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (123,62403, 'Darren', 'Marques', 'Suite 52', 6657241755);
insert into estudiante (id, persona_id) values ('e-62403',62403);

insert into usuario (id, rol_id, email, contrasena, token) values( 124, 4, 'Delilahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (124,23896, 'Delilah', 'Dominelli', '7th Floor', 1829289317);
insert into estudiante (id, persona_id) values ('e-23896',23896);

insert into usuario (id, rol_id, email, contrasena, token) values( 125, 4, 'Joyannestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (125,40207, 'Joyann', 'Tustin', 'Room 27', 6794971974);
insert into estudiante (id, persona_id) values ('e-40207',40207);

insert into usuario (id, rol_id, email, contrasena, token) values( 126, 4, 'Astrixestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (126,89755, 'Astrix', 'Nuzzetti', 'Suite 100', 2152034312);
insert into estudiante (id, persona_id) values ('e-89755',89755);

insert into usuario (id, rol_id, email, contrasena, token) values( 127, 4, 'Otheliaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (127,19879, 'Othelia', 'Barthel', 'Apt 424', 1918937329);
insert into estudiante (id, persona_id) values ('e-19879',19879);

insert into usuario (id, rol_id, email, contrasena, token) values( 128, 4, 'Charlotestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (128,26143, 'Charlot', 'Manvell', '10th Floor', 6389622640);
insert into estudiante (id, persona_id) values ('e-26143',26143);

insert into usuario (id, rol_id, email, contrasena, token) values( 129, 4, 'Natanielestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (129,70354, 'Nataniel', 'Puckinghorne', 'PO Box 91236', 8029807414);
insert into estudiante (id, persona_id) values ('e-70354',70354);

insert into usuario (id, rol_id, email, contrasena, token) values( 130, 4, 'Corrinneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (130,14496, 'Corrinne', 'Edson', 'Apt 611', 9816599280);
insert into estudiante (id, persona_id) values ('e-14496',14496);

insert into usuario (id, rol_id, email, contrasena, token) values( 131, 4, 'Hewittestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (131,11277, 'Hewitt', 'Boseley', 'PO Box 38229', 8918698627);
insert into estudiante (id, persona_id) values ('e-11277',11277);

insert into usuario (id, rol_id, email, contrasena, token) values( 132, 4, 'Wilburtestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (132,59318, 'Wilburt', 'McGiff', '12th Floor', 6384046626);
insert into estudiante (id, persona_id) values ('e-59318',59318);

insert into usuario (id, rol_id, email, contrasena, token) values( 133, 4, 'Karlikestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (133,61007, 'Karlik', 'Emms', 'Suite 8', 1032090919);
insert into estudiante (id, persona_id) values ('e-61007',61007);

insert into usuario (id, rol_id, email, contrasena, token) values( 134, 4, 'Deedeeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (134,32736, 'Deedee', 'Phillcox', '4th Floor', 3173105875);
insert into estudiante (id, persona_id) values ('e-32736',32736);

insert into usuario (id, rol_id, email, contrasena, token) values( 135, 4, 'Danyaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (135,58303, 'Danya', 'Kidston', 'Apt 170', 4337461034);
insert into estudiante (id, persona_id) values ('e-58303',58303);

insert into usuario (id, rol_id, email, contrasena, token) values( 136, 4, 'Karleneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (136,73131, 'Karlene', 'McDermott', 'Apt 1808', 8792508026);
insert into estudiante (id, persona_id) values ('e-73131',73131);

insert into usuario (id, rol_id, email, contrasena, token) values( 137, 4, 'Mollieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (137,30367, 'Mollie', 'Nickolls', 'Suite 90', 4233486186);
insert into estudiante (id, persona_id) values ('e-30367',30367);

insert into usuario (id, rol_id, email, contrasena, token) values( 138, 4, 'Orbadiahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (138,16737, 'Orbadiah', 'Garlic', 'Suite 69', 8083924642);
insert into estudiante (id, persona_id) values ('e-16737',16737);

insert into usuario (id, rol_id, email, contrasena, token) values( 139, 4, 'Parsifalestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (139,76947, 'Parsifal', 'Valadez', '3rd Floor', 1553868092);
insert into estudiante (id, persona_id) values ('e-76947',76947);

insert into usuario (id, rol_id, email, contrasena, token) values( 140, 4, 'Keenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (140,55667, 'Keen', 'Merrigan', 'Room 1846', 9378709317);
insert into estudiante (id, persona_id) values ('e-55667',55667);

insert into usuario (id, rol_id, email, contrasena, token) values( 141, 4, 'Aurieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (141,16677, 'Aurie', 'Cleynman', 'Apt 1010', 2198570999);
insert into estudiante (id, persona_id) values ('e-16677',16677);

insert into usuario (id, rol_id, email, contrasena, token) values( 142, 4, 'Carrolestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (142,74528, 'Carrol', 'Hick', 'Room 444', 4603291406);
insert into estudiante (id, persona_id) values ('e-74528',74528);

insert into usuario (id, rol_id, email, contrasena, token) values( 143, 4, 'Sandeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (143,56670, 'Sande', 'Saintpierre', 'Apt 1363', 1123519995);
insert into estudiante (id, persona_id) values ('e-56670',56670);

insert into usuario (id, rol_id, email, contrasena, token) values( 144, 4, 'Randalestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (144,89226, 'Randal', 'Gledhall', 'Suite 88', 2586920618);
insert into estudiante (id, persona_id) values ('e-89226',89226);

insert into usuario (id, rol_id, email, contrasena, token) values( 145, 4, 'Hobardestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (145,31661, 'Hobard', 'Volks', 'Room 414', 4582439929);
insert into estudiante (id, persona_id) values ('e-31661',31661);

insert into usuario (id, rol_id, email, contrasena, token) values( 146, 4, 'Lenaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (146,77527, 'Lena', 'Fordy', '7th Floor', 9694201103);
insert into estudiante (id, persona_id) values ('e-77527',77527);

insert into usuario (id, rol_id, email, contrasena, token) values( 147, 4, 'Emaleeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (147,73677, 'Emalee', 'Younghusband', 'PO Box 68062', 7136041601);
insert into estudiante (id, persona_id) values ('e-73677',73677);

insert into usuario (id, rol_id, email, contrasena, token) values( 148, 4, 'Thayneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (148,58669, 'Thayne', 'Christoffe', 'Suite 45', 8237916756);
insert into estudiante (id, persona_id) values ('e-58669',58669);

insert into usuario (id, rol_id, email, contrasena, token) values( 149, 4, 'Eliseestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (149,60677, 'Elise', 'Petry', 'Suite 21', 6244131153);
insert into estudiante (id, persona_id) values ('e-60677',60677);

insert into usuario (id, rol_id, email, contrasena, token) values( 150, 4, 'Evaniaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (150,62117, 'Evania', 'Simper', 'PO Box 16936', 4235777329);
insert into estudiante (id, persona_id) values ('e-62117',62117);

insert into usuario (id, rol_id, email, contrasena, token) values( 151, 4, 'Boyceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (151,58233, 'Boyce', 'Hunnicutt', 'Room 876', 5881465997);
insert into estudiante (id, persona_id) values ('e-58233',58233);

insert into usuario (id, rol_id, email, contrasena, token) values( 152, 4, 'Traceyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (152,23820, 'Tracey', 'Linthead', 'Apt 1880', 3302327781);
insert into estudiante (id, persona_id) values ('e-23820',23820);

insert into usuario (id, rol_id, email, contrasena, token) values( 153, 4, 'Robeniaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (153,26315, 'Robenia', 'Cumes', 'Room 1183', 2044435559);
insert into estudiante (id, persona_id) values ('e-26315',26315);

insert into usuario (id, rol_id, email, contrasena, token) values( 154, 4, 'Issieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (154,47193, 'Issie', 'Kaspar', 'Room 1359', 9163196146);
insert into estudiante (id, persona_id) values ('e-47193',47193);

insert into usuario (id, rol_id, email, contrasena, token) values( 155, 4, 'Maiseyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (155,78438, 'Maisey', 'Errichiello', 'Suite 28', 9608671279);
insert into estudiante (id, persona_id) values ('e-78438',78438);

insert into usuario (id, rol_id, email, contrasena, token) values( 156, 4, 'Nolanestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (156,53383, 'Nolan', 'Prince', '7th Floor', 9651629851);
insert into estudiante (id, persona_id) values ('e-53383',53383);

insert into usuario (id, rol_id, email, contrasena, token) values( 157, 4, 'Agataestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (157,34765, 'Agata', 'Gebhard', 'Suite 77', 9639835495);
insert into estudiante (id, persona_id) values ('e-34765',34765);

insert into usuario (id, rol_id, email, contrasena, token) values( 158, 4, 'Antoniettaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (158,80325, 'Antonietta', 'MacBey', 'Apt 1383', 7934581646);
insert into estudiante (id, persona_id) values ('e-80325',80325);

insert into usuario (id, rol_id, email, contrasena, token) values( 159, 4, 'Selindaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (159,50464, 'Selinda', 'Batchellor', 'Suite 77', 8907240097);
insert into estudiante (id, persona_id) values ('e-50464',50464);

insert into usuario (id, rol_id, email, contrasena, token) values( 160, 4, 'Dennaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (160,77922, 'Denna', 'Forrington', '1st Floor', 5159439431);
insert into estudiante (id, persona_id) values ('e-77922',77922);

insert into usuario (id, rol_id, email, contrasena, token) values( 161, 4, 'Natalestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (161,49506, 'Natal', 'Davidov', 'Room 1507', 7793402590);
insert into estudiante (id, persona_id) values ('e-49506',49506);

insert into usuario (id, rol_id, email, contrasena, token) values( 162, 4, 'Burgestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (162,10464, 'Burg', 'Curness', 'PO Box 71346', 1986621337);
insert into estudiante (id, persona_id) values ('e-10464',10464);

insert into usuario (id, rol_id, email, contrasena, token) values( 163, 4, 'Curryestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (163,63987, 'Curry', 'Harnwell', 'Room 1792', 4854091782);
insert into estudiante (id, persona_id) values ('e-63987',63987);

insert into usuario (id, rol_id, email, contrasena, token) values( 164, 4, 'Townsendestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (164,58279, 'Townsend', 'McDavid', 'Suite 58', 9324828968);
insert into estudiante (id, persona_id) values ('e-58279',58279);

insert into usuario (id, rol_id, email, contrasena, token) values( 165, 4, 'Gerrieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (165,38407, 'Gerrie', 'Dawidowitz', 'Room 1485', 5254109373);
insert into estudiante (id, persona_id) values ('e-38407',38407);

insert into usuario (id, rol_id, email, contrasena, token) values( 166, 4, 'Barnardestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (166,32296, 'Barnard', 'Hamlet', 'Suite 55', 7282416331);
insert into estudiante (id, persona_id) values ('e-32296',32296);

insert into usuario (id, rol_id, email, contrasena, token) values( 167, 4, 'Marcyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (167,67958, 'Marcy', 'Catling', 'Suite 69', 8783997936);
insert into estudiante (id, persona_id) values ('e-67958',67958);

insert into usuario (id, rol_id, email, contrasena, token) values( 168, 4, 'Tonyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (168,73592, 'Tony', 'Fancutt', 'Suite 55', 1117236177);
insert into estudiante (id, persona_id) values ('e-73592',73592);

insert into usuario (id, rol_id, email, contrasena, token) values( 169, 4, 'Ingabergestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (169,82031, 'Ingaberg', 'Mousdall', '7th Floor', 5472580372);
insert into estudiante (id, persona_id) values ('e-82031',82031);

insert into usuario (id, rol_id, email, contrasena, token) values( 170, 4, 'Ingraestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (170,36013, 'Ingra', 'Beniesh', '4th Floor', 3983775311);
insert into estudiante (id, persona_id) values ('e-36013',36013);

insert into usuario (id, rol_id, email, contrasena, token) values( 171, 4, 'Orlandoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (171,58674, 'Orlando', 'Hancorn', '14th Floor', 1114111000);
insert into estudiante (id, persona_id) values ('e-58674',58674);

insert into usuario (id, rol_id, email, contrasena, token) values( 172, 4, 'Irisestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (172,29439, 'Iris', 'Cheverell', '2nd Floor', 5086803816);
insert into estudiante (id, persona_id) values ('e-29439',29439);

insert into usuario (id, rol_id, email, contrasena, token) values( 173, 4, 'Sashaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (173,64988, 'Sasha', 'Menego', '4th Floor', 6935537923);
insert into estudiante (id, persona_id) values ('e-64988',64988);

insert into usuario (id, rol_id, email, contrasena, token) values( 174, 4, 'Aerielestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (174,81658, 'Aeriel', 'Bromidge', 'Suite 71', 4446179632);
insert into estudiante (id, persona_id) values ('e-81658',81658);

insert into usuario (id, rol_id, email, contrasena, token) values( 175, 4, 'Benjyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (175,42116, 'Benjy', 'Ganniclifft', 'Suite 55', 7202378165);
insert into estudiante (id, persona_id) values ('e-42116',42116);

insert into usuario (id, rol_id, email, contrasena, token) values( 176, 4, 'Ealestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (176,75304, 'Eal', 'Bault', '18th Floor', 8352646383);
insert into estudiante (id, persona_id) values ('e-75304',75304);

insert into usuario (id, rol_id, email, contrasena, token) values( 177, 4, 'Ainsleyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (177,80009, 'Ainsley', 'Edginton', '19th Floor', 1634339037);
insert into estudiante (id, persona_id) values ('e-80009',80009);

insert into usuario (id, rol_id, email, contrasena, token) values( 178, 4, 'Reaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (178,50315, 'Rea', 'Thecham', 'Room 461', 1378201737);
insert into estudiante (id, persona_id) values ('e-50315',50315);

insert into usuario (id, rol_id, email, contrasena, token) values( 179, 4, 'Mickieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (179,87563, 'Mickie', 'Husbands', 'Room 1488', 8321980269);
insert into estudiante (id, persona_id) values ('e-87563',87563);

insert into usuario (id, rol_id, email, contrasena, token) values( 180, 4, 'Valinaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (180,86117, 'Valina', 'Blanshard', 'Suite 81', 2176189600);
insert into estudiante (id, persona_id) values ('e-86117',86117);

insert into usuario (id, rol_id, email, contrasena, token) values( 181, 4, 'Alanoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (181,54276, 'Alano', 'Rains', 'Suite 56', 3955316807);
insert into estudiante (id, persona_id) values ('e-54276',54276);

insert into usuario (id, rol_id, email, contrasena, token) values( 182, 4, 'Joshuaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (182,58639, 'Joshua', 'Grunwald', 'PO Box 64934', 5048577373);
insert into estudiante (id, persona_id) values ('e-58639',58639);

insert into usuario (id, rol_id, email, contrasena, token) values( 183, 4, 'Angelicoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (183,44738, 'Angelico', 'Tinston', 'Suite 37', 3746605304);
insert into estudiante (id, persona_id) values ('e-44738',44738);

insert into usuario (id, rol_id, email, contrasena, token) values( 184, 4, 'Raphaelaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (184,62506, 'Raphaela', 'Cullinan', 'Apt 195', 7169544160);
insert into estudiante (id, persona_id) values ('e-62506',62506);

insert into usuario (id, rol_id, email, contrasena, token) values( 185, 4, 'Triciaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (185,85747, 'Tricia', 'McGinley', 'Room 1297', 4488079280);
insert into estudiante (id, persona_id) values ('e-85747',85747);

insert into usuario (id, rol_id, email, contrasena, token) values( 186, 4, 'Shemestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (186,68347, 'Shem', 'Bidder', 'Suite 3', 6371669023);
insert into estudiante (id, persona_id) values ('e-68347',68347);

insert into usuario (id, rol_id, email, contrasena, token) values( 187, 4, 'Gardyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (187,81694, 'Gardy', 'Meade', 'Apt 722', 2881284625);
insert into estudiante (id, persona_id) values ('e-81694',81694);

insert into usuario (id, rol_id, email, contrasena, token) values( 188, 4, 'Dewittestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (188,54221, 'Dewitt', 'Coventry', 'Suite 5', 9443601444);
insert into estudiante (id, persona_id) values ('e-54221',54221);

insert into usuario (id, rol_id, email, contrasena, token) values( 189, 4, 'Aurlieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (189,47303, 'Aurlie', 'Caslane', 'PO Box 83046', 2558179535);
insert into estudiante (id, persona_id) values ('e-47303',47303);

insert into usuario (id, rol_id, email, contrasena, token) values( 190, 4, 'Harleyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (190,19101, 'Harley', 'Fourmy', 'Suite 40', 9278084331);
insert into estudiante (id, persona_id) values ('e-19101',19101);

insert into usuario (id, rol_id, email, contrasena, token) values( 191, 4, 'Emmelineestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (191,83350, 'Emmeline', 'Fernandez', 'Suite 43', 5339847991);
insert into estudiante (id, persona_id) values ('e-83350',83350);

insert into usuario (id, rol_id, email, contrasena, token) values( 192, 4, 'Pegeenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (192,42745, 'Pegeen', 'Bucklan', 'Room 1678', 2484109904);
insert into estudiante (id, persona_id) values ('e-42745',42745);

insert into usuario (id, rol_id, email, contrasena, token) values( 193, 4, 'Kelliestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (193,39586, 'Kelli', 'Sloley', 'Apt 170', 3049503178);
insert into estudiante (id, persona_id) values ('e-39586',39586);

insert into usuario (id, rol_id, email, contrasena, token) values( 194, 4, 'Arabeleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (194,77809, 'Arabele', 'Tamburo', '6th Floor', 4082530276);
insert into estudiante (id, persona_id) values ('e-77809',77809);

insert into usuario (id, rol_id, email, contrasena, token) values( 195, 4, 'Trudeyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (195,44366, 'Trudey', 'Blaxeland', '4th Floor', 9252799623);
insert into estudiante (id, persona_id) values ('e-44366',44366);

insert into usuario (id, rol_id, email, contrasena, token) values( 196, 4, 'Vivyanneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (196,18367, 'Vivyanne', 'MacGilmartin', 'Room 252', 9895527453);
insert into estudiante (id, persona_id) values ('e-18367',18367);

insert into usuario (id, rol_id, email, contrasena, token) values( 197, 4, 'Lawrenceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (197,86385, 'Lawrence', 'Lofty', 'Apt 821', 4185699169);
insert into estudiante (id, persona_id) values ('e-86385',86385);

insert into usuario (id, rol_id, email, contrasena, token) values( 198, 4, 'Patestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (198,22847, 'Pat', 'Sahnow', 'PO Box 48936', 6544215104);
insert into estudiante (id, persona_id) values ('e-22847',22847);

insert into usuario (id, rol_id, email, contrasena, token) values( 199, 4, 'Madelonestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (199,55688, 'Madelon', 'Tuberfield', 'Apt 1356', 3697989197);
insert into estudiante (id, persona_id) values ('e-55688',55688);

insert into usuario (id, rol_id, email, contrasena, token) values( 200, 4, 'Isaiahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (200,10878, 'Isaiah', 'Seaborne', '13th Floor', 9767125659);
insert into estudiante (id, persona_id) values ('e-10878',10878);

insert into usuario (id, rol_id, email, contrasena, token) values( 201, 4, 'Virginiaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (201,30603, 'Virginia', 'Jerratsch', 'Apt 443', 9301934925);
insert into estudiante (id, persona_id) values ('e-30603',30603);

insert into usuario (id, rol_id, email, contrasena, token) values( 202, 4, 'Cornelleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (202,40385, 'Cornelle', 'Hassell', 'Room 1077', 2878168381);
insert into estudiante (id, persona_id) values ('e-40385',40385);

insert into usuario (id, rol_id, email, contrasena, token) values( 203, 4, 'Ethelbertestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (203,54482, 'Ethelbert', 'Mc Mechan', '4th Floor', 6525296597);
insert into estudiante (id, persona_id) values ('e-54482',54482);

insert into usuario (id, rol_id, email, contrasena, token) values( 204, 4, 'Rosemarieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (204,45550, 'Rosemarie', 'Belderson', 'PO Box 12910', 2433293206);
insert into estudiante (id, persona_id) values ('e-45550',45550);

insert into usuario (id, rol_id, email, contrasena, token) values( 205, 4, 'Ronaldaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (205,18581, 'Ronalda', 'Rookeby', '16th Floor', 5451029943);
insert into estudiante (id, persona_id) values ('e-18581',18581);

insert into usuario (id, rol_id, email, contrasena, token) values( 206, 4, 'Jeffestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (206,32117, 'Jeff', 'Duddin', 'Room 792', 1634563893);
insert into estudiante (id, persona_id) values ('e-32117',32117);

insert into usuario (id, rol_id, email, contrasena, token) values( 207, 4, 'Tarynestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (207,26712, 'Taryn', 'Crosetto', 'PO Box 14845', 9493924989);
insert into estudiante (id, persona_id) values ('e-26712',26712);

insert into usuario (id, rol_id, email, contrasena, token) values( 208, 4, 'Cariottaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (208,82940, 'Cariotta', 'Warnock', 'Room 210', 7755987589);
insert into estudiante (id, persona_id) values ('e-82940',82940);

insert into usuario (id, rol_id, email, contrasena, token) values( 209, 4, 'Mellisaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (209,87437, 'Mellisa', 'MacAvaddy', 'Suite 29', 5265540206);
insert into estudiante (id, persona_id) values ('e-87437',87437);

insert into usuario (id, rol_id, email, contrasena, token) values( 210, 4, 'Happyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (210,37106, 'Happy', 'Courtin', 'Room 1974', 2336023692);
insert into estudiante (id, persona_id) values ('e-37106',37106);

insert into usuario (id, rol_id, email, contrasena, token) values( 211, 4, 'Codieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (211,75067, 'Codie', 'Laidlow', 'Apt 560', 9049856662);
insert into estudiante (id, persona_id) values ('e-75067',75067);

insert into usuario (id, rol_id, email, contrasena, token) values( 212, 4, 'Gregoorestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (212,68228, 'Gregoor', 'Gray', 'Room 208', 8924947930);
insert into estudiante (id, persona_id) values ('e-68228',68228);

insert into usuario (id, rol_id, email, contrasena, token) values( 213, 4, 'Wolfyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (213,55872, 'Wolfy', 'Bagshawe', 'PO Box 57590', 2412265547);
insert into estudiante (id, persona_id) values ('e-55872',55872);

insert into usuario (id, rol_id, email, contrasena, token) values( 214, 4, 'Lorainestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (214,18141, 'Lorain', 'Knapton', 'Apt 260', 7691912222);
insert into estudiante (id, persona_id) values ('e-18141',18141);

insert into usuario (id, rol_id, email, contrasena, token) values( 215, 4, 'Napestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (215,30946, 'Nap', 'MacMenemy', 'PO Box 44151', 4719594980);
insert into estudiante (id, persona_id) values ('e-30946',30946);

insert into usuario (id, rol_id, email, contrasena, token) values( 216, 4, 'Klimentestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (216,55595, 'Kliment', 'Gumery', 'Room 1101', 2076766144);
insert into estudiante (id, persona_id) values ('e-55595',55595);

insert into usuario (id, rol_id, email, contrasena, token) values( 217, 4, 'Felicioestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (217,16599, 'Felicio', 'Isley', 'Suite 4', 7446167762);
insert into estudiante (id, persona_id) values ('e-16599',16599);

insert into usuario (id, rol_id, email, contrasena, token) values( 218, 4, 'Katharinaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (218,88211, 'Katharina', 'Buggs', 'PO Box 84095', 2104622560);
insert into estudiante (id, persona_id) values ('e-88211',88211);

insert into usuario (id, rol_id, email, contrasena, token) values( 219, 4, 'Dinahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (219,80299, 'Dinah', 'Atteridge', 'Apt 1202', 6507602465);
insert into estudiante (id, persona_id) values ('e-80299',80299);

insert into usuario (id, rol_id, email, contrasena, token) values( 220, 4, 'Retaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (220,21853, 'Reta', 'Meins', 'PO Box 31402', 4123085639);
insert into estudiante (id, persona_id) values ('e-21853',21853);

insert into usuario (id, rol_id, email, contrasena, token) values( 221, 4, 'Jdavieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (221,68018, 'Jdavie', 'Vigus', 'Room 634', 2106946477);
insert into estudiante (id, persona_id) values ('e-68018',68018);

insert into usuario (id, rol_id, email, contrasena, token) values( 222, 4, 'Oliaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (222,39061, 'Olia', 'Playfair', 'Apt 1690', 3092281771);
insert into estudiante (id, persona_id) values ('e-39061',39061);

insert into usuario (id, rol_id, email, contrasena, token) values( 223, 4, 'Heindrickestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (223,21933, 'Heindrick', 'Ingrem', '10th Floor', 2347514915);
insert into estudiante (id, persona_id) values ('e-21933',21933);

insert into usuario (id, rol_id, email, contrasena, token) values( 224, 4, 'Valeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (224,72240, 'Vale', 'Mayte', '9th Floor', 6303532569);
insert into estudiante (id, persona_id) values ('e-72240',72240);

insert into usuario (id, rol_id, email, contrasena, token) values( 225, 4, 'Juddestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (225,38318, 'Judd', 'Southon', 'Room 193', 9974897481);
insert into estudiante (id, persona_id) values ('e-38318',38318);

insert into usuario (id, rol_id, email, contrasena, token) values( 226, 4, 'Georgettaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (226,69632, 'Georgetta', 'Keveren', 'Suite 77', 1367116223);
insert into estudiante (id, persona_id) values ('e-69632',69632);

insert into usuario (id, rol_id, email, contrasena, token) values( 227, 4, 'Carolyneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (227,43718, 'Carolyne', 'Rubinlicht', '20th Floor', 1629021428);
insert into estudiante (id, persona_id) values ('e-43718',43718);

insert into usuario (id, rol_id, email, contrasena, token) values( 228, 4, 'Jeffieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (228,29942, 'Jeffie', 'De La Cote', 'Room 1966', 2412436832);
insert into estudiante (id, persona_id) values ('e-29942',29942);

insert into usuario (id, rol_id, email, contrasena, token) values( 229, 4, 'Dominiqueestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (229,86489, 'Dominique', 'Woollett', 'Suite 91', 3279687967);
insert into estudiante (id, persona_id) values ('e-86489',86489);

insert into usuario (id, rol_id, email, contrasena, token) values( 230, 4, 'Desestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (230,14078, 'Des', 'Heed', 'Room 90', 6007555636);
insert into estudiante (id, persona_id) values ('e-14078',14078);

insert into usuario (id, rol_id, email, contrasena, token) values( 231, 4, 'Lillaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (231,37847, 'Lilla', 'Rikel', 'Room 1669', 7772486656);
insert into estudiante (id, persona_id) values ('e-37847',37847);

insert into usuario (id, rol_id, email, contrasena, token) values( 232, 4, 'Corenaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (232,72416, 'Corena', 'Barthot', 'Apt 1940', 1714978228);
insert into estudiante (id, persona_id) values ('e-72416',72416);

insert into usuario (id, rol_id, email, contrasena, token) values( 233, 4, 'Readestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (233,48644, 'Read', 'Hubback', 'PO Box 90297', 1871473951);
insert into estudiante (id, persona_id) values ('e-48644',48644);

insert into usuario (id, rol_id, email, contrasena, token) values( 234, 4, 'Evelineestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (234,30384, 'Eveline', 'Kikke', 'Room 1453', 4293541657);
insert into estudiante (id, persona_id) values ('e-30384',30384);

insert into usuario (id, rol_id, email, contrasena, token) values( 235, 4, 'Aubreeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (235,33986, 'Aubree', 'Kennerley', '4th Floor', 3638448484);
insert into estudiante (id, persona_id) values ('e-33986',33986);

insert into usuario (id, rol_id, email, contrasena, token) values( 236, 4, 'Lennardestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (236,34791, 'Lennard', 'Gosnall', 'Suite 34', 6523768451);
insert into estudiante (id, persona_id) values ('e-34791',34791);

insert into usuario (id, rol_id, email, contrasena, token) values( 237, 4, 'Philestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (237,49327, 'Phil', 'Strute', 'Suite 82', 2369719228);
insert into estudiante (id, persona_id) values ('e-49327',49327);

insert into usuario (id, rol_id, email, contrasena, token) values( 238, 4, 'Katestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (238,83472, 'Kat', 'Stienton', 'Room 1994', 8413738826);
insert into estudiante (id, persona_id) values ('e-83472',83472);

insert into usuario (id, rol_id, email, contrasena, token) values( 239, 4, 'Rudigerestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (239,54539, 'Rudiger', 'Hildrew', 'Apt 74', 7078930268);
insert into estudiante (id, persona_id) values ('e-54539',54539);

insert into usuario (id, rol_id, email, contrasena, token) values( 240, 4, 'Lanieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (240,28925, 'Lanie', 'Neilly', '3rd Floor', 2276908780);
insert into estudiante (id, persona_id) values ('e-28925',28925);

insert into usuario (id, rol_id, email, contrasena, token) values( 241, 4, 'Kalinaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (241,68229, 'Kalina', 'Lawther', 'PO Box 86968', 2426890030);
insert into estudiante (id, persona_id) values ('e-68229',68229);

insert into usuario (id, rol_id, email, contrasena, token) values( 242, 4, 'Hamestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (242,34539, 'Ham', 'Ellse', 'PO Box 3442', 1363469412);
insert into estudiante (id, persona_id) values ('e-34539',34539);

insert into usuario (id, rol_id, email, contrasena, token) values( 243, 4, 'Norrieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (243,25557, 'Norrie', 'Meynell', 'Suite 44', 9394349324);
insert into estudiante (id, persona_id) values ('e-25557',25557);

insert into usuario (id, rol_id, email, contrasena, token) values( 244, 4, 'Garvinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (244,63316, 'Garvin', 'Franz-Schoninger', 'Suite 74', 6285286359);
insert into estudiante (id, persona_id) values ('e-63316',63316);

insert into usuario (id, rol_id, email, contrasena, token) values( 245, 4, 'Courtnayestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (245,45305, 'Courtnay', 'MacGuffog', 'PO Box 50128', 6977298060);
insert into estudiante (id, persona_id) values ('e-45305',45305);

insert into usuario (id, rol_id, email, contrasena, token) values( 246, 4, 'Sabaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (246,15517, 'Saba', 'Sholem', 'PO Box 57499', 9816448614);
insert into estudiante (id, persona_id) values ('e-15517',15517);

insert into usuario (id, rol_id, email, contrasena, token) values( 247, 4, 'Bernardoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (247,41686, 'Bernardo', 'Snowding', 'PO Box 79970', 5304883911);
insert into estudiante (id, persona_id) values ('e-41686',41686);

insert into usuario (id, rol_id, email, contrasena, token) values( 248, 4, 'Rafaeliaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (248,58882, 'Rafaelia', 'Prozescky', 'Room 1916', 7587550949);
insert into estudiante (id, persona_id) values ('e-58882',58882);

insert into usuario (id, rol_id, email, contrasena, token) values( 249, 4, 'Sigestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (249,24592, 'Sig', 'Melling', 'PO Box 23831', 6895637337);
insert into estudiante (id, persona_id) values ('e-24592',24592);

insert into usuario (id, rol_id, email, contrasena, token) values( 250, 4, 'Karaleeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (250,40259, 'Karalee', 'Maynell', 'Apt 1512', 4594782874);
insert into estudiante (id, persona_id) values ('e-40259',40259);

insert into usuario (id, rol_id, email, contrasena, token) values( 251, 4, 'Auberonestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (251,37175, 'Auberon', 'Killingworth', 'Apt 958', 9855584687);
insert into estudiante (id, persona_id) values ('e-37175',37175);

insert into usuario (id, rol_id, email, contrasena, token) values( 252, 4, 'Deccaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (252,56614, 'Decca', 'Edgeley', 'Suite 63', 6499499642);
insert into estudiante (id, persona_id) values ('e-56614',56614);

insert into usuario (id, rol_id, email, contrasena, token) values( 253, 4, 'Ronnyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (253,20044, 'Ronny', 'Basindale', 'PO Box 33509', 3913431591);
insert into estudiante (id, persona_id) values ('e-20044',20044);

insert into usuario (id, rol_id, email, contrasena, token) values( 254, 4, 'Katiestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (254,51835, 'Kati', 'Millery', '15th Floor', 2129601454);
insert into estudiante (id, persona_id) values ('e-51835',51835);

insert into usuario (id, rol_id, email, contrasena, token) values( 255, 4, 'Jasminaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (255,80228, 'Jasmina', 'MacKerley', 'PO Box 29831', 8309167645);
insert into estudiante (id, persona_id) values ('e-80228',80228);

insert into usuario (id, rol_id, email, contrasena, token) values( 256, 4, 'Vykyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (256,56111, 'Vyky', 'Zanetello', '17th Floor', 6029422516);
insert into estudiante (id, persona_id) values ('e-56111',56111);

insert into usuario (id, rol_id, email, contrasena, token) values( 257, 4, 'Avaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (257,74749, 'Ava', 'Ralestone', '2nd Floor', 1234852126);
insert into estudiante (id, persona_id) values ('e-74749',74749);

insert into usuario (id, rol_id, email, contrasena, token) values( 258, 4, 'Clemensestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (258,72984, 'Clemens', 'Groucutt', 'Suite 20', 3998623693);
insert into estudiante (id, persona_id) values ('e-72984',72984);

insert into usuario (id, rol_id, email, contrasena, token) values( 259, 4, 'Aileestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (259,83593, 'Aile', 'Leatherborrow', 'Suite 57', 8742332799);
insert into estudiante (id, persona_id) values ('e-83593',83593);

insert into usuario (id, rol_id, email, contrasena, token) values( 260, 4, 'Kamilahestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (260,26923, 'Kamilah', 'Winslow', '19th Floor', 7066444642);
insert into estudiante (id, persona_id) values ('e-26923',26923);

insert into usuario (id, rol_id, email, contrasena, token) values( 261, 4, 'Karnaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (261,24213, 'Karna', 'Carriage', 'Suite 82', 8777827020);
insert into estudiante (id, persona_id) values ('e-24213',24213);

insert into usuario (id, rol_id, email, contrasena, token) values( 262, 4, 'Lewissestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (262,29958, 'Lewiss', 'Mitskevich', 'PO Box 23887', 2389976183);
insert into estudiante (id, persona_id) values ('e-29958',29958);

insert into usuario (id, rol_id, email, contrasena, token) values( 263, 4, 'Dennisonestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (263,82134, 'Dennison', 'Murt', 'PO Box 82446', 7272825244);
insert into estudiante (id, persona_id) values ('e-82134',82134);

insert into usuario (id, rol_id, email, contrasena, token) values( 264, 4, 'Devlinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (264,25743, 'Devlin', 'Canavan', 'Suite 77', 4898594624);
insert into estudiante (id, persona_id) values ('e-25743',25743);

insert into usuario (id, rol_id, email, contrasena, token) values( 265, 4, 'Emelitaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (265,85460, 'Emelita', 'Jellicorse', 'PO Box 21702', 5368319130);
insert into estudiante (id, persona_id) values ('e-85460',85460);

insert into usuario (id, rol_id, email, contrasena, token) values( 266, 4, 'Hadleighestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (266,69364, 'Hadleigh', 'Bloxham', 'PO Box 63196', 5578328488);
insert into estudiante (id, persona_id) values ('e-69364',69364);

insert into usuario (id, rol_id, email, contrasena, token) values( 267, 4, 'Kristenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (267,23435, 'Kristen', 'Croce', 'Suite 13', 6839792657);
insert into estudiante (id, persona_id) values ('e-23435',23435);

insert into usuario (id, rol_id, email, contrasena, token) values( 268, 4, 'Cheryestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (268,85497, 'Chery', 'Hoyle', '13th Floor', 4864077145);
insert into estudiante (id, persona_id) values ('e-85497',85497);

insert into usuario (id, rol_id, email, contrasena, token) values( 269, 4, 'Hermanestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (269,13002, 'Herman', 'Pourvoieur', '20th Floor', 5335063986);
insert into estudiante (id, persona_id) values ('e-13002',13002);

insert into usuario (id, rol_id, email, contrasena, token) values( 270, 4, 'Perleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (270,75302, 'Perle', 'Sarvar', 'Apt 83', 9175254897);
insert into estudiante (id, persona_id) values ('e-75302',75302);

insert into usuario (id, rol_id, email, contrasena, token) values( 271, 4, 'Durestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (271,36529, 'Dur', 'Coote', '6th Floor', 4469575752);
insert into estudiante (id, persona_id) values ('e-36529',36529);

insert into usuario (id, rol_id, email, contrasena, token) values( 272, 4, 'Hananestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (272,29504, 'Hanan', 'Flynn', 'Apt 773', 1439336344);
insert into estudiante (id, persona_id) values ('e-29504',29504);

insert into usuario (id, rol_id, email, contrasena, token) values( 273, 4, 'Madeleineestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (273,13627, 'Madeleine', 'Baldetti', '17th Floor', 6671550725);
insert into estudiante (id, persona_id) values ('e-13627',13627);

insert into usuario (id, rol_id, email, contrasena, token) values( 274, 4, 'Lewesestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (274,56589, 'Lewes', 'Hemms', 'Apt 1893', 5212135282);
insert into estudiante (id, persona_id) values ('e-56589',56589);

insert into usuario (id, rol_id, email, contrasena, token) values( 275, 4, 'Elonoreestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (275,19873, 'Elonore', 'Dominichelli', 'PO Box 84939', 4428220956);
insert into estudiante (id, persona_id) values ('e-19873',19873);

insert into usuario (id, rol_id, email, contrasena, token) values( 276, 4, 'Ashleyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (276,71934, 'Ashley', 'Vickers', 'Apt 1183', 6057517208);
insert into estudiante (id, persona_id) values ('e-71934',71934);

insert into usuario (id, rol_id, email, contrasena, token) values( 277, 4, 'Ulbertoestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (277,80536, 'Ulberto', 'Axelbey', 'Suite 1', 8212936860);
insert into estudiante (id, persona_id) values ('e-80536',80536);

insert into usuario (id, rol_id, email, contrasena, token) values( 278, 4, 'Leoneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (278,89303, 'Leone', 'Benitez', '11th Floor', 8985861687);
insert into estudiante (id, persona_id) values ('e-89303',89303);

insert into usuario (id, rol_id, email, contrasena, token) values( 279, 4, 'Malvinaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (279,24676, 'Malvina', 'Kauble', '12th Floor', 3925255615);
insert into estudiante (id, persona_id) values ('e-24676',24676);

insert into usuario (id, rol_id, email, contrasena, token) values( 280, 4, 'Deweyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (280,89421, 'Dewey', 'Walford', '14th Floor', 7647875312);
insert into estudiante (id, persona_id) values ('e-89421',89421);

insert into usuario (id, rol_id, email, contrasena, token) values( 281, 4, 'Treverestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (281,77260, 'Trever', 'Camm', '9th Floor', 6154243001);
insert into estudiante (id, persona_id) values ('e-77260',77260);

insert into usuario (id, rol_id, email, contrasena, token) values( 282, 4, 'Zeligestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (282,17551, 'Zelig', 'Helkin', 'Suite 14', 2035268349);
insert into estudiante (id, persona_id) values ('e-17551',17551);

insert into usuario (id, rol_id, email, contrasena, token) values( 283, 4, 'Christinestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (283,89496, 'Christin', 'Blowing', 'Room 802', 3374539569);
insert into estudiante (id, persona_id) values ('e-89496',89496);

insert into usuario (id, rol_id, email, contrasena, token) values( 284, 4, 'Winnifredestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (284,29547, 'Winnifred', 'Ambrosoli', 'Suite 60', 7848785859);
insert into estudiante (id, persona_id) values ('e-29547',29547);

insert into usuario (id, rol_id, email, contrasena, token) values( 285, 4, 'Shurlockeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (285,83922, 'Shurlocke', 'Goldhill', 'PO Box 50124', 2512409439);
insert into estudiante (id, persona_id) values ('e-83922',83922);

insert into usuario (id, rol_id, email, contrasena, token) values( 286, 4, 'Sheridanestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (286,87644, 'Sheridan', 'Stabbins', '13th Floor', 6107558668);
insert into estudiante (id, persona_id) values ('e-87644',87644);

insert into usuario (id, rol_id, email, contrasena, token) values( 287, 4, 'Calestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (287,77432, 'Cal', 'Smaridge', '19th Floor', 5292176526);
insert into estudiante (id, persona_id) values ('e-77432',77432);

insert into usuario (id, rol_id, email, contrasena, token) values( 288, 4, 'Giffordestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (288,71654, 'Gifford', 'Smidmoor', 'Suite 74', 6352466477);
insert into estudiante (id, persona_id) values ('e-71654',71654);

insert into usuario (id, rol_id, email, contrasena, token) values( 289, 4, 'Gwenethestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (289,79460, 'Gweneth', 'Gilhouley', 'Suite 27', 2782386580);
insert into estudiante (id, persona_id) values ('e-79460',79460);

insert into usuario (id, rol_id, email, contrasena, token) values( 290, 4, 'Selaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (290,72617, 'Sela', 'Lavrick', 'Suite 64', 7076489289);
insert into estudiante (id, persona_id) values ('e-72617',72617);

insert into usuario (id, rol_id, email, contrasena, token) values( 291, 4, 'Jerrieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (291,11475, 'Jerrie', 'Fourmy', 'Apt 35', 7224504497);
insert into estudiante (id, persona_id) values ('e-11475',11475);

insert into usuario (id, rol_id, email, contrasena, token) values( 292, 4, 'Dolliestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (292,46313, 'Dolli', 'Baudts', 'Room 541', 5854050140);
insert into estudiante (id, persona_id) values ('e-46313',46313);

insert into usuario (id, rol_id, email, contrasena, token) values( 293, 4, 'Hollyanneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (293,35756, 'Hollyanne', 'Kinnoch', 'Room 21', 6197306347);
insert into estudiante (id, persona_id) values ('e-35756',35756);

insert into usuario (id, rol_id, email, contrasena, token) values( 294, 4, 'Luluestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (294,39229, 'Lulu', 'Aleshintsev', 'Apt 242', 4271682312);
insert into estudiante (id, persona_id) values ('e-39229',39229);

insert into usuario (id, rol_id, email, contrasena, token) values( 295, 4, 'Magdaleneestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (295,52743, 'Magdalene', 'Giovanetti', 'PO Box 14720', 7412593471);
insert into estudiante (id, persona_id) values ('e-52743',52743);

insert into usuario (id, rol_id, email, contrasena, token) values( 296, 4, 'Doriseestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (296,35977, 'Dorise', 'Prothero', 'Room 712', 9988091473);
insert into estudiante (id, persona_id) values ('e-35977',35977);

insert into usuario (id, rol_id, email, contrasena, token) values( 297, 4, 'Martelleestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (297,28782, 'Martelle', 'Bassilashvili', 'Room 1795', 4381008373);
insert into estudiante (id, persona_id) values ('e-28782',28782);

insert into usuario (id, rol_id, email, contrasena, token) values( 298, 4, 'Hyacinthiaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (298,76155, 'Hyacinthia', 'Masseo', 'Apt 1239', 9362503883);
insert into estudiante (id, persona_id) values ('e-76155',76155);

insert into usuario (id, rol_id, email, contrasena, token) values( 299, 4, 'Brandieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (299,47022, 'Brandie', 'Wickersley', 'PO Box 24842', 3144988582);
insert into estudiante (id, persona_id) values ('e-47022',47022);

insert into usuario (id, rol_id, email, contrasena, token) values( 300, 4, 'Friedrichestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (300,26509, 'Friedrich', 'Sivills', 'Apt 975', 1921746382);
insert into estudiante (id, persona_id) values ('e-26509',26509);

insert into usuario (id, rol_id, email, contrasena, token) values( 301, 4, 'Arleyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (301,80853, 'Arley', 'Kemmish', 'Room 62', 4256951802);
insert into estudiante (id, persona_id) values ('e-80853',80853);

insert into usuario (id, rol_id, email, contrasena, token) values( 302, 4, 'Jessikaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (302,27032, 'Jessika', 'Martina', '13th Floor', 1312246658);
insert into estudiante (id, persona_id) values ('e-27032',27032);

insert into usuario (id, rol_id, email, contrasena, token) values( 303, 4, 'Maceestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (303,41584, 'Mace', 'Neillans', 'Suite 66', 2514369092);
insert into estudiante (id, persona_id) values ('e-41584',41584);

insert into usuario (id, rol_id, email, contrasena, token) values( 304, 4, 'Nolieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (304,17666, 'Nolie', 'Lodwick', '9th Floor', 7869524650);
insert into estudiante (id, persona_id) values ('e-17666',17666);

insert into usuario (id, rol_id, email, contrasena, token) values( 305, 4, 'Ewenestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (305,37667, 'Ewen', 'Cansfield', 'Room 1079', 1799284410);
insert into estudiante (id, persona_id) values ('e-37667',37667);

insert into usuario (id, rol_id, email, contrasena, token) values( 306, 4, 'Bennyestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (306,23907, 'Benny', 'Philbrook', '1st Floor', 7072338117);
insert into estudiante (id, persona_id) values ('e-23907',23907);

insert into usuario (id, rol_id, email, contrasena, token) values( 307, 4, 'Taitestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (307,13214, 'Tait', 'Edyson', '20th Floor', 1576987846);
insert into estudiante (id, persona_id) values ('e-13214',13214);

insert into usuario (id, rol_id, email, contrasena, token) values( 308, 4, 'Kalindaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (308,84054, 'Kalinda', 'Colhoun', '2nd Floor', 9878357105);
insert into estudiante (id, persona_id) values ('e-84054',84054);

insert into usuario (id, rol_id, email, contrasena, token) values( 309, 4, 'Fraydaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (309,80711, 'Frayda', 'Shopcott', 'Apt 713', 9511156756);
insert into estudiante (id, persona_id) values ('e-80711',80711);

insert into usuario (id, rol_id, email, contrasena, token) values( 310, 4, 'Chesterestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (310,47103, 'Chester', 'Lyffe', '11th Floor', 8713588055);
insert into estudiante (id, persona_id) values ('e-47103',47103);

insert into usuario (id, rol_id, email, contrasena, token) values( 311, 4, 'Zacherieestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (311,29654, 'Zacherie', 'Hernik', 'PO Box 4043', 2284105127);
insert into estudiante (id, persona_id) values ('e-29654',29654);

insert into usuario (id, rol_id, email, contrasena, token) values( 312, 4, 'Celiaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (312,40841, 'Celia', 'Cardello', 'Suite 63', 4685882225);
insert into estudiante (id, persona_id) values ('e-40841',40841);

insert into usuario (id, rol_id, email, contrasena, token) values( 313, 4, 'Penelopeestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (313,48782, 'Penelope', 'Gifkins', 'PO Box 10282', 7777215677);
insert into estudiante (id, persona_id) values ('e-48782',48782);

insert into usuario (id, rol_id, email, contrasena, token) values( 314, 4, 'Sabinaestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (314,87306, 'Sabina', 'Geggus', 'Room 279', 2188799383);
insert into estudiante (id, persona_id) values ('e-87306',87306);

insert into usuario (id, rol_id, email, contrasena, token) values( 315, 4, 'Destudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (315,39829, 'D''arcy', 'Jacke', 'PO Box 73071', 8494529499);
insert into estudiante (id, persona_id) values ('e-39829',39829);

insert into usuario (id, rol_id, email, contrasena, token) values( 316, 4, 'Louisestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (316,51130, 'Louis', 'Tonepohl', 'Suite 35', 5419941109);
insert into estudiante (id, persona_id) values ('e-51130',51130);

insert into usuario (id, rol_id, email, contrasena, token) values( 317, 4, 'Geriestudiante@gmail.com', '$2y$10$rLBxGygGRsLKk.nNNhbs1OD5PeH4ST/.LNG/93b49/lUA2/iaeM72', '');
insert into persona (usuario_id, cedula, nombre, apellido, direccion, telefono) values (317,73076, 'Geri', 'Youle', 'Apt 1940', 5269988072);
insert into estudiante (id, persona_id) values ('e-73076',73076);

-- 4_periodo.sql
delete from periodo where true;
insert into periodo (id, fecha_inicio, fecha_cierre) values (1, '2023-03-01', '2024-02-01');

-- 5_trayecto-fase.sql
insert into trayecto (codigo, periodo_id, nombre, calificacion_minima, siguiente_trayecto) values ('TR4',1,'Trayecto IV',80, NULL);
insert into fase (codigo, trayecto_id, nombre) values ('TR4_2','TR4','Fase 2'); 
insert into fase (codigo, trayecto_id, nombre, siguiente_fase) values ('TR4_1','TR4','Fase 1', 'TR4_2');

insert into trayecto (codigo, periodo_id, nombre, calificacion_minima, siguiente_trayecto) values ('TR3',1,'Trayecto III',80, 'TR4');
insert into fase (codigo, trayecto_id, nombre) values ('TR3_2','TR3','Fase 2'); 
insert into fase (codigo, trayecto_id, nombre, siguiente_fase) values ('TR3_1','TR3','Fase 1', 'TR3_2'); 

insert into trayecto (codigo, periodo_id, nombre, calificacion_minima, siguiente_trayecto) values ('TR2',1,'Trayecto II',80, 'TR3');
insert into fase (codigo, trayecto_id, nombre) values ('TR2_2','TR2','Fase 2');
insert into fase (codigo, trayecto_id, nombre,siguiente_fase) values ('TR2_1','TR2','Fase 1', 'TR2_2');

insert into trayecto (codigo, periodo_id, nombre, calificacion_minima, siguiente_trayecto) values ('TR1',1,'Trayecto I',80, 'TR2');
insert into fase (codigo, trayecto_id, nombre) values ('TR1_2','TR1','Fase 2');
insert into fase (codigo, trayecto_id, nombre, siguiente_fase) values ('TR1_1','TR1','Fase 1', 'TR1_2');

-- 6_seccion.sql
-- // Trayecto 1
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1104', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1114', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1124', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1134', 'REPITENCIA');

insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1203', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1213', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR1','IN1202', '');

-- // Trayecto 2
insert into seccion (trayecto_id, codigo, observacion) values ('TR2','IN2103', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR2','IN2113', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR2','IN2102', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR2','IN2112', '');

-- // Trayecto 3
insert into seccion (trayecto_id, codigo, observacion) values ('TR3','IN3301', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR3','IN3302', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR3','IN3102', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR3','IN3103', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR3','IN3104', '');

-- // trayecto 4
insert into seccion (trayecto_id, codigo, observacion) values ('TR4','IN4401', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR4','IN4402', '');
insert into seccion (trayecto_id, codigo, observacion) values ('TR4','IN4403', 'IUJO');

-- materias-malla.sql

delete from malla_curricular where true;
delete from materias where true;

-- ------------------ TRAYECTO I -------------------------------
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('ASESOR3078554', 'Tutor Asesor Proyecto II', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078554_1', 'TR1_1','ASESOR3078554');
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078554_2', 'TR1_2','ASESOR3078554');

-- arquitectura del computador
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('ARQUIT1254578', 'Tutor Asesor Proyecto II', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('ARQUIT1254578_1', 'TR1_1','ARQUIT1254578');
insert into malla_curricular (codigo, fase_id, materia_id) values ('ARQUIT1254578_2', 'TR1_2','ARQUIT1254578');
-- proyecto
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIPST548751', 'Proyecto Socio Tecnológico', 216, 18, 9, 6, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST548751_1', 'TR1_1','PIPST548751');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST548751_2', 'TR1_2','PIPST548751');
-- electiva
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIELE548756', 'Electiva I', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIELE548756_1', 'TR1_1','PIELE548756');

-- ------------------ TRAYECTO II -------------------------------
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('ASESOR3078845', 'Tutor Asesor Proyecto II', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078845_1', 'TR2_1','ASESOR3078845');
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078845_2', 'TR2_2','ASESOR3078845');

-- base de datos
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('PIBAD090203', 'Base de Datos', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIBAD090203_1', 'TR2_1','PIBAD090203');

-- ing de software
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('PIINS090203', 'Ingenieria del Software I', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIINS090203_1', 'TR2_1','PIINS090203');
-- proyecto
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('PIPST234209', 'Proyecto Socio Tecnológico II', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST234209_1', 'TR2_1','PIPST234209');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST234209_2', 'TR2_2','PIPST234209');

-- programacion II
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('PIPRO306212', 'Programación II', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPRO306212_1', 'TR2_1','PIPRO306212');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPRO306212_2', 'TR2_2','PIPRO306212');
-- ------------------ TRAYECTO III -------------------------------
-- Matemática Aplicada anual trayecto 3
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIMAT156306', 'Matemática Aplicada', 120, 36, 6, 3, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIMAT156306_1', 'TR3_1','PIMAT156306');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIMAT156306_2', 'TR3_2','PIMAT156306');


-- modelado de bases de datos fase 1 trayecto 3
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIMOB078303', 'Modelado de bases de datos', 72, 6, 3, 2, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIMOB078303_1','TR3_1','PIMOB078303');
-- vincula a proyecto por lo que se crean dimensiones e indicadores
-- ....


-- Proyecto Solcio Tecnológico III anual trayecto 3
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIPST078303', 'Proyecto Socio Tecnológico', 216, 18, 9, 6, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST078303_1', 'TR3_1','PIPST078303');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST078303_2', 'TR3_2','PIPST078303');


-- Sistemas Operativos fase 1 trayecto 3
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PISIO078303', 'Sistemas Operativos', 72, 6, 3, 4, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PISIO078303_1', 'TR3_1','PISIO078303');
-- vincula a proyecto por lo que se crean dimensiones e indicadores
-- ....

-- Ingenieria de software anual trayecto 3
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PINGSO078303', 'Ingenieria de Software', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PINGSO078303_1', 'TR3_1','PINGSO078303');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PINGSO078303_2', 'TR3_2','PINGSO078303');
-- vincula a proyecto por lo que se crean dimensiones e indicadores
-- ....


-- Tutor Asesor Proyecto anual trayecto 3
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('ASESOR3078303', 'Tutor Asesor Proyecto III', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078303_1', 'TR3_1','ASESOR3078303');
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR3078303_2', 'TR3_2','ASESOR3078303');
-- vincula a proyecto por lo que se crean dimensiones e indicadores
-- ....

-- ------------ TRAYECTO IV ------------------------

-- Actividades acreditables IV anual trayecto 4 
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIACA078303', 'Actividades acreditables IV', 72, 6, 3, 4, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIACA078303_1', 'TR4_1','PIACA078303');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIACA078303_2', 'TR4_2','PIACA078303');

-- Administración de bases de datos
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIABD078303', 'Administración de bases de datos', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIABD078303_1','TR4_1','PIABD078303');


-- Auditoria Informática
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIAUI078303', 'Auditoria Informática', 72, 6, 3, 4, '');

insert into malla_curricular (codigo, fase_id, materia_id) values ('PIAUI078303_2','TR4_2','PIAUI078303');

-- Electiva IV
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIELE078303', 'Electiva IV', 72, 6, 3, 4, '');

-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIELE078303_2', 'TR4_2','PIELE078303');

-- Formación Crítica IV
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIFOC078303', 'Formación Crítica IV', 72, 6, 3, 4, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIFOC078303_1', 'TR4_1','PIFOC078303');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIFOC078303_2', 'TR4_2','PIFOC078303');

-- Gestión de proyecto informático
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIGPI078303', 'Gestión de proyecto informático', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIGPI078303_1', 'TR4_1','PIGPI078303');


-- Idiomas II
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIIDI078303', 'Idiomas II', 72, 6, 3, 4, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIIDI078303_1', 'TR4_1','PIIDI078303');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIIDI078303_2', 'TR4_2','PIIDI078303');

-- Proyecto Socio Tecnológico IV 
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIPST078304', 'Proyecto Socio Tecnológico IV', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST078304_1', 'TR4_1','PIPST078304');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PIPST078304_2', 'TR4_2','PIPST078304');

-- Redes Avanzadas 
-- insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PIREA078303', 'Redes Avanzadas', 72, 6, 3, 4, '');
-- insert into malla_curricular (codigo, fase_id, materia_id) values ('PIREA078303_2', 'TR4_2','PIREA078303');

-- Seguridad Informática
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje) values ('PISEI078303', 'Seguridad Informática', 72, 6, 3, 4, '');
insert into malla_curricular (codigo, fase_id, materia_id) values ('PISEI078303_1', 'TR4_1','PISEI078303');


-- Tutor Asesor Proyecto IV
insert into materias (codigo, nombre, htasist, htind, ucredito, hrs_acad, eje, cursable) values ('ASESOR4078303', 'Tutor Asesor Proyecto IV', 72, 6, 3, 4, '',0);
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR4078303_1', 'TR4_1','ASESOR4078303');
insert into malla_curricular (codigo, fase_id, materia_id) values ('ASESOR4078303_2', 'TR4_2','ASESOR4078303');

-- baremos.sql

delete from indicadores where true;
delete from dimension where true;
-- --------------------- trayecto 4 fase 1 ---------------------------
-- TUTORA
insert into dimension (id, unidad_id, nombre, grupal) values(1,'ASESOR4078303_1','Desempeño Individual',0);

insert into indicadores (dimension_id, nombre, ponderacion) values(1, 'Responsabilidad', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(1, 'Activo y participativo', 0.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(1, 'Integración al grupo', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(1, 'Sensibilidad Social', 0.25);

insert into dimension (id, unidad_id, nombre, grupal) values(2,'ASESOR4078303_1','Desempeño Grupal', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(2, 'Manejo de conflictos', 0.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(2, 'Proactividad', 0.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(2, 'Recibe de su equipo de proyecto los entregables de trayecto IV', 2);

insert into dimension (id, unidad_id, nombre, grupal) values(3,'ASESOR4078303_1','Avance del Producto Final', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(3, 'Se evidencia que los riesgos presentados en el proyecto están vinculados con la comunidad.', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(3, 'Se verifica la existencia de elementos técnicos en cuanto a la base de datos, están aplicados en el proyecto', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(3, 'Los aspectos relacionados a seguridad informática (Métodos de cifrado) están presentes en el proyecto', 2);

-- Gestión de proyecto informatico
insert into dimension (id, unidad_id, nombre, grupal) values(4,'PIGPI078303_1','Evaluación Tecnica Individual', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(4, 'Gestiona los riesgos del proyecto', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(4, 'Analiza y crea estrategias para la administración de riesgo', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(4, 'Controla el proyecto mediante rutas críticas en PERT/CPM', 2.5);

-- Administración de base de datos
insert into dimension (id, unidad_id, nombre, grupal) values(5,'PIABD078303_1','Evaluación Tecnica Individual', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(5, 'Presenta plan de optimización de la base de datos.', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(5, 'Presenta plan de monitoreo del rendimiento de la base de datos', 3);
insert into indicadores (dimension_id, nombre, ponderacion) values(5, 'Presenta plan de control de seguridad de la base de datos', 4);
insert into indicadores (dimension_id, nombre, ponderacion) values(5, 'Presenta plan de respaldos y recuperación de la base de datos', 4);
insert into indicadores (dimension_id, nombre, ponderacion) values(5, 'Presenta plan de cambios de la base de datos, para la integración de sistemas.', 2);

-- Docente de proyecto
insert into dimension (id, unidad_id, nombre, grupal) values(6,'PIPST078304_1','Evaluación Del Docente de Proyecto', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Presenta en forma coherente el diagnóstico del proyecto instalado en la comunidad.', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'El objetivo general se relaciona con los alcances requeridos en Trayecto IV.', .5);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Los objetivos específicos reflejan el alcance del proyecto y se relacionan con la propuesta del objetivo general.', .5);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Aborda teorías y conocimientos relacionados al Trayecto respectivo y su acreditación', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Presenta la planificación de actividades del proyecto. (Gestión de Proyecto, Base de Datos y Seguridad Informática)', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Identifican, analizan y valoran los riesgos del proyecto con propuestas de administración, monitoreo o mitigación.', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Presenta la evaluación de la base de datos del proyecto considerando las transacciones, la concurrencia, el volumen de crecimiento con planes de administración; además de la integración del sistema.', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Incorpora el análisis de la seguridad física y lógica donde está ubicado el proyecto en la comunidad.', .5);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Describe la aplicación de métodos de cifrado al sistema con su respectivo algoritmo y establecen políticas de seguridad del proyecto de acuerdo a los resultados generados en el diagnóstico.', .5);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Evidencia el cumplimiento de las tareas y actividades Programadas. (Entregaron Plan de trabajo y avances del Proyecto de acuerdo a sus requerimientos).', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'Presenta de forma correcta la sistematizaciónde los Capítulos I, II y III en conjunto con las páginas preliminares, de acuerdo a los requerimientos exigidos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(6, 'La redacción, análisis y ortografía se adecua a las características de un informe técnico.', 1);

-- seguridad informatica
insert into dimension (id, unidad_id, nombre, grupal) values(7,'PISEI078303_1','Evaluación Tecnica Individual', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(7, 'Explica como realizo el Diagnóstico sobre la Seguridad Física, Lógica, Redes y Estaciones de Trabajo, BD en proyecto.', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(7, 'Demuestra que el Algoritmo asimétrico fue el empleado según el método de cifrado seleccionado en el sistema.', 11);
insert into indicadores (dimension_id, nombre, ponderacion) values(7, 'Analiza la matriz de riesgo de seguridad.', 2);

-- --------------------- trayecto 4 fase 2 ---------------------------

-- Tutor Asesor
insert into dimension (id, unidad_id, nombre, grupal) values(8,'ASESOR4078303_2','Desempeño Individual', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(8, 'Responsabilidad', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(8, 'Activo y participativo', 0.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(8, 'Integración al grupo', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(8, 'Sensibilidad Social', 0.25);

insert into dimension (id, unidad_id, nombre, grupal) values(9,'ASESOR4078303_2','Desempeño Grupal', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(9, '', .5);
insert into indicadores (dimension_id, nombre, ponderacion) values(9, '', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(9, '', 1);

insert into dimension (id, unidad_id, nombre, grupal) values(10,'ASESOR4078303_2','Evaluacion Tecnica Individual', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(10, '', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(10, '', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(10, '', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(10, '', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(10, '', 2);

insert into dimension (id, unidad_id, nombre, grupal) values(11,'ASESOR4078303_2','Plan de Mantenimiento al sistema', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(11, '', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(11, '', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(11, '', 2);


-- Docente de proyecto 
insert into dimension (id, unidad_id, nombre, grupal) values(13,'PIPST078304_2','Aspectos a Evaluar en el Informe de Proyecto', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Refleja la planificación de actividades del proyecto. Auditoría informática y plan de mantenimiento al sistema)', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Plasma la Identificación, análisis y aplicación de la auditoría al sistema. ', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Presenta el análisis del tipo de mantenimiento que deben aplicar y resultados del plan de mantenimiento', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Se evidencia el cumplimiento de las tareas y actividades programadas. (Entregaron Plan de trabajo y avances del Proyecto de acuerdo a sus requerimientos). ', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Presenta la sistematización de los Capítulos IV, V y VI', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Presenta las Conclusiones y Recomendaciones, Referencias y Anexos.', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'La redacción, análisis y ortografía se adecuan a las características de un informe técnico.', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(13, 'Se entrega, en el tiempo indicado,  el informe final de proyecto IV con todos los requerimientos exigidos', 1);

-- Auditoria Informatica 
insert into dimension (id, unidad_id, nombre, grupal) values(14,'PIAUI078303_2','Tipo de Auditoria', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(14, 'Auditoría aplicada al sistema (Explicación del módulo auditado) Tipo de auditoría seleccionada.', 1.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(14, 'Herramienta utilizada. ¿Cuál Utilizo?', 1.25);
insert into indicadores (dimension_id, nombre, ponderacion) values(14, 'Metodología y técnica empleada.', 2.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(14, 'Resultado en el sistema. (Visualizarlo).', 2.5);

insert into dimension (id, unidad_id, nombre, grupal) values(15,'PIAUI078303_2','Plan de Mantenimiento', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(15, 'Explicar  el propósito del mantenimiento', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(15, 'Equipos, periféricos, servidores,  sistemas y documentación. ', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(15, 'Tipo de mantenimiento. (Predictivo, correctivo, preventivo). (A corto y largo plazo). ', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(15, 'Establecimiento del plan de mantenimiento Informe de resultados del Mantenimiento.', 1.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(15, 'Visualizar en el sistema cuál fue el mantenimiento aplicado.', 1.5);


-- -------------------- trayecto 3 fase 1 ---------------------------
-- TUTOR
insert into dimension (id, unidad_id, nombre, grupal) values(16,'ASESOR3078303_1','Sistema', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Interfaz de menú amigable al usuario', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Interfaz de inserción o captura de datos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Interfaz de confirmación de eliminación de datos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Interfaz de consultar con filtros de búsqueda', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Demuestra conocimiento en la programación modular del Sistema', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Modulo de reportes básicos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Utiliza modelo vista-controlador', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Codifica basado en el Diseño', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(16, 'Justifica la Metodología', 1);

insert into dimension (id, unidad_id, nombre, grupal) values(17,'ASESOR3078303_1','Informe', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(17, 'Capitulo 1', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(17, 'Capitulo 2', 2);

insert into dimension (id, unidad_id, nombre, grupal) values(18,'ASESOR3078303_1','Manejo de Equipo', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(18, 'Manejo de conflictos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(18, 'Responsabilidad', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(18, 'Hábitos de trabajo', 2);

-- INGENIERIA DEL SOFTWARE
insert into dimension (id, unidad_id, nombre, grupal) values(19,'PINGSO078303_1','Modelado del Negocio', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(19, 'Documento de Requisitos S.R.S', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(19, 'Diagramas y Plantilla IBM', 5);

insert into dimension (id, unidad_id, nombre, grupal) values(20,'PINGSO078303_1','Modelado del Sistema', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(20, 'Diagrama de Casos de Uso', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(20, 'Diagrama de Actividad', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(20, 'Descripción de casos de uso en Plantillas IBM', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(20, 'Diagrama de clase', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(20, 'Mapa Navegacional', 1);


-- Modelado de base de datos 
insert into dimension (id, unidad_id, nombre, grupal) values(21,'PIMOB078303_1','Diseño de la Base de datos', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(21, 'Modelo Entidad Relacion', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(21, 'Modelo Logico Relacional', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(21, 'Modelo Fisico', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(21, 'Utiliza postgres para el diseño fisico de la base de datos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(21, 'Diccionario de datos', 1);

-- Docente de proyecto
insert into dimension (id, unidad_id, nombre, grupal) values(22,'PIPST078303_1','Aspectos a evaluar', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Titulo del proyecto', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'La descripcion del diagnostico situacional', 0.75);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Aplica e interpreta instrumentos para el levantamiento de la niformación y captura de requisitos', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Presenta una propuesta de solución coherente', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Objetivo general se relaciona con la propuesta de solución', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Objetivos especificos: reflejan el alcance del proyecto y se relacionan con la propuesta de solución del objetivo general', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Justifica las razones para el uso de la propuesta de solución', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'El proyecto describe los procesos llevados a cabo dentro de la comunidad', 0.75);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Aborda teorías y conocimientos cónsonos al trayecto respectivo y su acreditación', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Se aborda el marco legal', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Realiza planificación de actividades del proyecto', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Entrega a tiempo de artefactos correspondientes al diseño del sistema', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Sistematiza Capitulo 1 y 2 del proyecto', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Aplica normas para representar cuadros y figuras', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Redacción, analisis y ortografia', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Los participantes se integraron como equipo de trabajo para la resolución de conflictos', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Los participantes aplicaron instrumentos de recolección de información', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(22, 'Los participantes cumplieron con las tareas y actividades programadas', 0.5);

-- --------------------- trayecto 3 fase 2 ------------------------------

-- TUTORA
insert into dimension (id, unidad_id, nombre, grupal) values(23,'ASESOR3078303_2','Desempeño Individual',0);
insert into indicadores (dimension_id, nombre, ponderacion) values(23, 'CRUD del sistema. (Por Modulo)', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(23, 'Validación de datos. (Por Modulo)', 1);

insert into dimension (id, unidad_id, nombre, grupal) values(24,'ASESOR3078303_2','Desempeño grupal',1);
insert into indicadores (dimension_id, nombre, ponderacion) values(24, 'Responsabilidad', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(24, 'Integración al grupo', 0.5);
insert into indicadores (dimension_id, nombre, ponderacion) values(24, 'proactividad', 0.5);

insert into dimension (id, unidad_id, nombre, grupal) values(25,'ASESOR3078303_2','Avances de programación (Por Modulo)', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Instalación del software necesario para la ejecución de la aplicación o componentes', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Pantallas bien conectadas con la Base de datos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Los módulos de modificación de base de datos garantizan la integridad referencial', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Desarrollo de todos los modulos diseñados en los diagramas de casos de uso', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Módulos acordes al Diagrama de clases', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Funcionamiento completo de los módulos de automatización', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Correctitud en los reportes estadisticos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Cumplimiento del estandar de programación entregado', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Control de errores', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Gestión de bitácora', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(25, 'Manejo de sesiones respecto a concurrencia de usuarios', 1);

insert into dimension (id, unidad_id, nombre, grupal) values(26,'ASESOR3078303_2','Interfaz y estilo', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(26, 'Uso adecuado de los colores en la aplicación', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(26, 'Fondos claros y sencillos', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(26, 'Uso de iamgenes', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(26, 'Distribución de la interfaz', 2);

-- Ingeniera de Software
insert into dimension (id, unidad_id, nombre, grupal) values(27,'PINGSO078303_2','Desempeño Tecnico', 0);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Cumple con actividades Asignadas', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Conoce con exactitud el Sistema', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Conoce el uso de Bitacora', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Codifica los requerimientos dados por el docente', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Desarrollo y programo el módulo asignado', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Integro el módulo desarrollado', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Planifica el proceso de Desarrollo del software', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Identifica los escenarios y casos de prueba en el sistema', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Detecta errores, fallas, defectos en el sistema', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(27, 'Planifica las activdades de capacitación', 1);

insert into dimension (id, unidad_id, nombre, grupal) values(28,'PINGSO078303_2','Usabilidad', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Facilidad de uso', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Tiempos de respuesta del sistema', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Interactividad con el usuario', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Ayuda al Usuario', 1);

-- -- Docente de Proyecto
insert into dimension (id, unidad_id, nombre, grupal) values(29,'PIPST078303_2','Capitulo III', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Manual de usuario', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Manual de Sistema', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Plan de Pruebas', 3);
insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Plan de Instalación', 2);
insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Plan de Capacitación', 2);

insert into dimension (id, unidad_id, nombre, grupal) values(30,'PIPST078303_2','Capitulo IV', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(30, 'Recomendaciones y Evolución Previsible del sistema.', 2);

insert into dimension (id, unidad_id, nombre, grupal) values(31,'PIPST078303_2','Capitulo V', 1);
insert into indicadores (dimension_id, nombre, ponderacion) values(31, 'Anexos y Referencias', 2);

-- --------------------- trayecto 2 fase 1 ---------------------------
-- insert into dimension (id, unidad_id, nombre, grupal) values(28,'ASESOR3078845_1','Desempeño Grupal', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Manejo de Conflictos', 0.5);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Proactividad', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(28, 'Hábitos de Trabajo', 1);

-- --------------------- trayecto 2 fase 2 ---------------------------
-- insert into dimension (id, unidad_id, nombre, grupal) values(29,'ASESOR3078845_2','Desempeño Grupal', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Manejo de Conflictos', 0.5);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Proactividad', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(29, 'Hábitos de Trabajo', 1);

-- --------------------- trayecto 1 fase 1 ---------------------------
-- insert into dimension (id, unidad_id, nombre, grupal) values(30,'ASESOR3078554_1','Desempeño Grupal', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(30, 'Manejo de Conflictos', 0.5);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(30, 'Proactividad', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(30, 'Hábitos de Trabajo', 1);

-- insert into dimension (id, unidad_id, nombre, grupal) values(31,'PIELE548756_1','Desempeño Grupal', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(31, 'Manejo de Conflictos', 0.5);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(31, 'Proactividad', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(31, 'Hábitos de Trabajo', 1);

-- --------------------- trayecto 1 fase 2 ---------------------------
-- insert into dimension (id, unidad_id, nombre, grupal) values(32,'ASESOR3078554_2','Desempeño Grupal', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(32, 'Manejo de Conflictos', 0.5);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(32, 'Proactividad', 1);
-- insert into indicadores (dimension_id, nombre, ponderacion) values(32, 'Hábitos de Trabajo', 1);
-- Proyecto


-- 9_clases.sql

delete from inscripcion where true;
-- delete from clase where true;
-- actividades acrediables fase 1
-- prof: hermes 

-- fase 2
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-23154875', 'IN4401', 'PIACA078303_2', 'e-15408');
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-23154875', 'IN4401', 'PIACA078303_2', 'e-63578');
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-23154875', 'IN4401', 'PIACA078303_2', 'e-39263');

-- administración de base de datos
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-654854354', 'IN4401', 'PIABD078303_1', 'e-15408');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-654854354', 'IN4401', 'PIABD078303_1', 'e-63578');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-654854354', 'IN4401', 'PIABD078303_1', 'e-39263');

-- gestión de proyecto informatico
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-234565423','IN4401', 'PIGPI078303_1', 'e-15408');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-234565423','IN4401', 'PIGPI078303_1', 'e-63578');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-234565423','IN4401', 'PIGPI078303_1', 'e-39263');

-- idiomas II
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-52213548','IN4401', 'PIIDI078303_1', 'e-15408');
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-52213548','IN4401', 'PIIDI078303_1', 'e-63578');
-- insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-52213548','IN4401', 'PIIDI078303_1', 'e-39263');

-- Seguridad Informatica
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-5428468','IN4401', 'PISEI078303_1', 'e-15408');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-5428468','IN4401', 'PISEI078303_1', 'e-63578');
insert into inscripcion (profesor_id, seccion_id, unidad_curricular_id, estudiante_id) values ('p-5428468','IN4401', 'PISEI078303_1', 'e-39263');

-- 10_proyectos.sql
delete from integrante_proyecto where true;
delete from proyecto where true;
delete from parroquias where true;
delete from municipios where true;

insert into municipios(id,nombre) values (1, 'Iribarren');
insert into parroquias(id,municipio,nombre) values (1,1, 'Ana Soto');
insert into parroquias(id,municipio,nombre) values (2,1, 'Santa Rosa');
insert into parroquias(id,municipio,nombre) values (3,1, 'Tamaca');
insert into parroquias(id,municipio,nombre) values (4,1, 'Catedral');
insert into parroquias(id,municipio,nombre) values (5,1, 'Concepción');
insert into parroquias(id,municipio,nombre) values (6,1, 'El Cují');
insert into parroquias(id,municipio,nombre) values (7,1, 'Buena Vista');
insert into parroquias(id,municipio,nombre) values (8,1, 'Aguedo Felipe Alvarado');
insert into parroquias(id,municipio,nombre) values (9,1, 'Unión');

insert into municipios(id,nombre) values (2, 'Jiménez');
insert into parroquias(id,municipio,nombre) values (10,2, 'Coronel Mariano Peraza');
insert into parroquias(id,municipio,nombre) values (11,2, 'Juan Bautista Rodríguez');
insert into parroquias(id,municipio,nombre) values (12,2, 'Cuara');
insert into parroquias(id,municipio,nombre) values (13,2, 'Diego de Lozada');
insert into parroquias(id,municipio,nombre) values (14,2, 'Paraíso de San José');
insert into parroquias(id,municipio,nombre) values (15,2, 'San Miguel');
insert into parroquias(id,municipio,nombre) values (16,2, 'Tintorero');
insert into parroquias(id,municipio,nombre) values (17,2, 'José Bernardo Dorante');

insert into sector_consejo_comunal(id, parroquia_id, nombre) VALUES (1, 1, 'Eje 1');

insert into consejo_comunal(id, nombre, nombre_vocero, telefono, sector_id) VALUES (1, 'Consejo Comunal Pueblo Nuevo', 'Carlos Ramirez', 0426545456, 1);

insert into sector_consejo_comunal(id, parroquia_id, nombre) VALUES (2, 4, 'Eje 3');

insert into consejo_comunal(id, nombre, nombre_vocero, telefono, sector_id) VALUES (2, 'Consejo Comunal Concordia', 'Angela', 0426545456, 2);


-- TRAYECTO 4 PROYECTO GESTION DE PROYECTOS
insert into proyecto (
  id, 
  fase_id, 
  parroquia_id, 
  nombre, 
  comunidad, 
  motor_productivo, 
  resumen, 
  direccion, 
  consejo_comunal_id,
  tutor_in,
  tutor_ex,
  tlf_tin,
  tlf_tex,
  cerrado,
  estatus
)
values (
  1,
  'TR1_1', 
  1,
  'Gestion de proyectos sociotecnologicos', 
  'UPTAEB', 
  'Informática', 
  'Gestión de proyectos para el PNF en informática', 
  'Av. Los Horcones, Av. La Salle, Barquisimeto 3001, Lara', 
  1,
  'p-135482354',
  'Jose Sequera',  
  '041254875',  
  '041255478',   
  0,
  1);
insert into integrante_proyecto (proyecto_id, estudiante_id) values (1,'e-15408');
insert into integrante_proyecto (proyecto_id, estudiante_id) values (1,'e-63578');
insert into integrante_proyecto (proyecto_id, estudiante_id) values (1,'e-39263');

-- TRAYECTO 4 PROYECTO LA ROCA
-- insert into proyecto (id, fase_id, nombre, comunidad, area, motor_productivo, resumen, direccion, municipio, parroquia)
-- values (2,'TR3_1', 'La Roca', 'Iglesia', '','','','','','');
-- insert into integrante_proyecto (proyecto_id, estudiante_id) values (2,'e-60621');
-- insert into integrante_proyecto (proyecto_id, estudiante_id) values (2,'e-61587');

INSERT INTO `pregunta` (`id`, `pregunta` ) VALUES (NULL, 'Nombre de tu mascota?'), (NULL, 'Donde estudiaste?'), (NULL, 'Color favorito?');
INSERT INTO `respuestas` (`id`, `respuesta`, `pregunta_id`, `usuario_id`) VALUES (NULL, 'onix', '1', '1'), (NULL, 'juan jose landaeta', '2', '1'), (NULL, 'azul', '3', '1');
-- vistas
DROP VIEW IF EXISTS detalles_inscripciones;
CREATE VIEW detalles_inscripciones AS
SELECT 
  inscripcion.id as id_inscripcion, 
  inscripcion.seccion_id, 
  inscripcion.unidad_curricular_id, 
  estudiante.id as estudiante_id, 
  persona.cedula, 
  CONCAT(persona.nombre,' ',persona.apellido)  as nombre_estudiante, 
  materias.codigo as codigo_materia, 
  materias.nombre as nombre_materia, 
  fase.nombre as nombre_fase,
  round(sum(inscripcion.calificacion),2) as calificacion
FROM `estudiante`
INNER JOIN persona ON persona.cedula = estudiante.persona_id 
INNER JOIN inscripcion ON inscripcion.estudiante_id = estudiante.id 
INNER JOIN malla_curricular on malla_curricular.codigo = inscripcion.unidad_curricular_id
INNER JOIN materias ON materias.codigo = malla_curricular.materia_id
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id
GROUP BY persona.cedula, materias.codigo;

DROP VIEW IF EXISTS detalles_inscripciones_malla;
CREATE VIEW detalles_inscripciones_malla AS
SELECT 
  inscripcion.id as id_inscripcion, 
  inscripcion.seccion_id, 
  inscripcion.unidad_curricular_id, 
  estudiante.id as estudiante_id, 
  persona.cedula, 
  CONCAT(persona.nombre,' ',persona.apellido)  as nombre_estudiante, 
  materias.codigo as codigo_materia, 
  materias.nombre as nombre_materia, 
  fase.nombre as nombre_fase,
  round(sum(inscripcion.calificacion),2) as calificacion
FROM `estudiante`
INNER JOIN persona ON persona.cedula = estudiante.persona_id 
INNER JOIN inscripcion ON inscripcion.estudiante_id = estudiante.id 
INNER JOIN malla_curricular on malla_curricular.codigo = inscripcion.unidad_curricular_id
INNER JOIN materias ON materias.codigo = malla_curricular.materia_id
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id
GROUP BY persona.cedula, inscripcion.unidad_curricular_id ;

DROP VIEW IF EXISTS detalles_estudiantes;
CREATE VIEW detalles_estudiantes AS
SELECT 
  estudiante.id, 
  persona.*, 
  usuario.email, 
  count(detalles_inscripciones.id_inscripcion) as clases, 
  detalles_inscripciones.seccion_id, 
  integrante_proyecto.id as integrante_id,
  integrante_proyecto.proyecto_id,
  trayecto.codigo as trayecto_id
FROM persona
INNER JOIN estudiante ON estudiante.persona_id = persona.cedula
LEFT JOIN usuario ON usuario.id = persona.usuario_id
LEFT JOIN detalles_inscripciones ON detalles_inscripciones.id_inscripcion = estudiante.id
LEFT JOIN integrante_proyecto ON integrante_proyecto.estudiante_id = estudiante.id
LEFT JOIN seccion ON seccion.codigo = detalles_inscripciones.seccion_id
LEFT JOIN trayecto ON trayecto.codigo = seccion.trayecto_id
GROUP BY persona.cedula, detalles_inscripciones.seccion_id;


DROP VIEW IF EXISTS estudiantes_pendientes_a_proyecto;
CREATE VIEW estudiantes_pendientes_a_proyecto AS
select *  from detalles_estudiantes de  where de.id not in (select estudiante_id from integrante_proyecto ip);

DROP VIEW IF EXISTS detalles_profesores;
CREATE VIEW detalles_profesores AS
SELECT profesor.codigo, persona.*, usuario.email
FROM persona
INNER JOIN profesor ON profesor.persona_id = persona.cedula
LEFT JOIN usuario ON usuario.id = persona.usuario_id;

DROP VIEW IF EXISTS detalles_trayecto;
CREATE VIEW detalles_trayecto AS
SELECT trayecto.*, periodo.fecha_inicio, periodo.fecha_cierre
FROM trayecto
INNER JOIN periodo ON periodo.id = trayecto.periodo_id;

DROP VIEW IF EXISTS detalles_seccion;
CREATE VIEW detalles_seccion AS
SELECT seccion.*, trayecto.nombre as trayecto
FROM seccion
INNER JOIN trayecto ON trayecto.codigo = seccion.trayecto_id;

DROP VIEW IF EXISTS detalles_dimension;
CREATE VIEW detalles_dimension AS
SELECT dimension.*, materias.codigo as codigo_materia,materias.nombre as nombre_materia, fase.nombre as nombre_fase, fase.codigo as codigo_fase, trayecto.nombre as nombre_trayecto, trayecto.codigo as codigo_trayecto, round(SUM(indicadores.ponderacion),2) as ponderacion_items
FROM dimension
INNER JOIN malla_curricular ON malla_curricular.codigo = dimension.unidad_id
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id 
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
INNER JOIN materias ON  materias.codigo = malla_curricular.materia_id
LEFT JOIN indicadores ON indicadores.dimension_id = dimension.id
GROUP BY indicadores.dimension_id;

DROP VIEW IF EXISTS detalles_proyecto;
CREATE VIEW detalles_proyecto AS

SELECT 
  proyecto.id, 
  proyecto.fase_id, 
  proyecto.nombre, 
  proyecto.comunidad, 
  proyecto.motor_productivo, 
  proyecto.resumen, 
  proyecto.direccion, 
  cc.id as consejo_comunal_id,
  cc.nombre as nombre_consejo_comunal,
  cc.nombre_vocero as nombre_vocero_consejo_comunal,
  cc.telefono as telefono_consejo_comunal,
  scc.nombre as sector_consejo_comunal,
  municipios.nombre as municipio, 
  parroquias.nombre as parroquia, 
  parroquias.id as parroquia_id, 
  proyecto.tutor_ex,
  proyecto.tlf_tex,
  proyecto.tutor_in,
  proyecto.cerrado,
  proyecto.estatus,
  proyecto.observaciones,
  concat(tutor_info.nombre, ' ', tutor_info.apellido) as tutor_in_nombre,
  tutor_info.cedula as tutor_in_cedula,
  tutor_info.telefono as tutor_in_telefono,
  trayecto.nombre as nombre_trayecto,
  trayecto.codigo as codigo_trayecto, 
  trayecto.siguiente_trayecto as codigo_siguiente_trayecto, 
  fase.nombre as nombre_fase, 
  fase.codigo as codigo_fase, 
  count(integrante_proyecto.id) as integrantes,
  sum(CASE
    WHEN integrante_proyecto.estatus = 0 THEN 1
    ELSE 0
  END) AS reprobados,
  periodo.fecha_inicio,
  periodo.fecha_cierre
FROM proyecto
INNER JOIN fase ON fase.codigo = proyecto.fase_id 
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
INNER JOIN periodo ON periodo.id = trayecto.periodo_id
INNER JOIN profesor as tutor ON tutor.codigo = proyecto.tutor_in
INNER JOIN persona as tutor_info ON tutor_info.cedula = tutor.persona_id
INNER JOIN parroquias ON parroquias.id = proyecto.parroquia_id 
INNER JOIN municipios ON municipios.id = parroquias.municipio
LEFT join consejo_comunal cc on cc.id = proyecto.consejo_comunal_id 
LEFT join sector_consejo_comunal scc on scc.id = cc.sector_id 
LEFT OUTER JOIN integrante_proyecto ON integrante_proyecto.proyecto_id = proyecto.id
GROUP BY proyecto_id;

DROP VIEW IF EXISTS detalles_materias;
CREATE VIEW detalles_materias AS
SELECT 
  trayecto.nombre as nombre_trayecto,
  trayecto.codigo as codigo_trayecto,
  materias.codigo as codigo_materia,
  materias.nombre as nombre_materia,
  fase.nombre as nombre_fase,
  fase.codigo as codigo_fase,
  materias.eje,
  materias.htasist,
  materias.htind,
  materias.ucredito,
  materias.hrs_acad,
  materias.cursable,
  count(malla_curricular.codigo) as count_malla,
  count(dimension.id) as dimensiones,
  round(sum(indicadores.ponderacion)) as ponderado,
  count(inscripcion.id) as inscripciones
FROM materias
LEFT JOIN malla_curricular on malla_curricular.materia_id = materias.codigo
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
LEFT OUTER JOIN dimension ON dimension.unidad_id = malla_curricular.codigo
LEFT OUTER JOIN indicadores on indicadores.dimension_id = dimension.id
LEFT OUTER JOIN inscripcion ON inscripcion.unidad_curricular_id = malla_curricular.codigo

GROUP BY materias.codigo
ORDER BY codigo_trayecto;

DROP VIEW IF EXISTS detalles_integrantes;

CREATE VIEW detalles_integrantes AS
SELECT integrante_proyecto.id, proyecto.id as proyecto_id, estudiante.id as estudiante_id, proyecto.nombre as proyecto_nombre, persona.nombre, persona.apellido, persona.cedula, round(SUM(notas_integrante_proyecto.calificacion),2) as calificaciones, round(trayecto.calificacion_minima,2) as calificacion_minima_trayecto,
integrante_proyecto.estatus
FROM integrante_proyecto
INNER JOIN estudiante ON estudiante.id = integrante_proyecto.estudiante_id
INNER JOIN persona on persona.cedula = estudiante.persona_id
INNER JOIN proyecto on proyecto.id = integrante_proyecto.proyecto_id
INNER JOIN fase ON fase.codigo = proyecto.fase_id
INNER JOIN trayecto on trayecto.codigo = fase.trayecto_id
LEFT JOIN notas_integrante_proyecto ON notas_integrante_proyecto.integrante_id = integrante_proyecto.id
GROUP BY integrante_proyecto.id, notas_integrante_proyecto.integrante_id;

DROP VIEW IF EXISTS detalles_fase;

DROP VIEW IF EXISTS detalles_fase;
CREATE VIEW detalles_fase AS
SELECT 
  fase.codigo as codigo_fase, 
  fase.nombre as nombre_fase, 
  fase.siguiente_fase, 
  trayecto.codigo as codigo_trayecto, 
  trayecto.nombre as nombre_trayecto, 
  periodo.fecha_inicio, periodo.fecha_cierre,
  ROUND(SUM(indicadores.ponderacion),2) as ponderado_baremos
FROM `fase` 
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
INNER JOIN periodo ON periodo.id = trayecto.periodo_id
LEFT JOIN malla_curricular ON malla_curricular.fase_id = fase.codigo
LEFT OUTER JOIN dimension ON dimension.unidad_id = malla_curricular.codigo
LEFT OUTER JOIN indicadores ON indicadores.dimension_id = dimension.id
GROUP BY fase.codigo;

DROP VIEW IF EXISTS detalles_baremos;

CREATE VIEW detalles_baremos AS
SELECT 
    indicadores.id, 
    indicadores.nombre as nombre_indicador,
    indicadores.ponderacion as ponderacion,
    indicadores.dimension_id,
    dimension.nombre as nombre_dimension,
    dimension.grupal,
    materias.codigo as codigo_materia,
    materias.nombre as nombre_materia, 
    fase.nombre as nombre_fase, 
    fase.codigo as codigo_fase, 
    trayecto.nombre as nombre_trayecto, 
    trayecto.codigo as codigo_trayecto
FROM `indicadores` 
INNER JOIN dimension ON dimension.id = indicadores.dimension_id
INNER JOIN malla_curricular ON malla_curricular.codigo = dimension.unidad_id
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id 
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
INNER JOIN materias ON  materias.codigo = malla_curricular.materia_id
GROUP BY indicadores.id;

DROP VIEW IF EXISTS detalles_notas_baremos;

CREATE VIEW detalles_notas_baremos AS
SELECT 
  malla_curricular.fase_id,
  fase.nombre as nombre_fase,
  persona.cedula,
  persona.nombre,
  integrante_proyecto.proyecto_id,
  integrante_proyecto.id as integrante_id,
  ROUND(sum(indicadores.ponderacion),2) as ponderado,
  ROUND(sum(nip.calificacion), 2) as calificacion,
  trayecto.calificacion_minima as calificacion_minima_trayecto
FROM notas_integrante_proyecto as nip
INNER JOIN indicadores ON indicadores.id = nip.indicador_id
INNER JOIN integrante_proyecto ON integrante_proyecto.id = nip.integrante_id
INNER JOIN estudiante ON estudiante.id = integrante_proyecto.estudiante_id
INNER JOIN persona ON persona.cedula = estudiante.persona_id
INNER JOIN dimension ON dimension.id = indicadores.dimension_id
INNER JOIN malla_curricular ON dimension.unidad_id = malla_curricular.codigo
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id
GROUP BY persona.cedula, malla_curricular.fase_id;

DROP VIEW IF EXISTS detalles_malla;
CREATE VIEW detalles_malla AS
SELECT
trayecto.codigo as codigo_trayecto,
trayecto.nombre as nombre_trayecto,
materias.codigo as codigo_materia,
materias.nombre,
malla_curricular.codigo,
fase.codigo as codigo_fase,
fase.nombre as nombre_fase,
count(dimension.id) as dimensiones,
ROUND(SUM(indicadores.ponderacion),2) as ponderado_baremos
FROM malla_curricular
INNER JOIN materias ON materias.codigo =  malla_curricular.materia_id
INNER JOIN fase ON fase.codigo = malla_curricular.fase_id
INNER JOIN trayecto ON trayecto.codigo = fase.trayecto_id 
LEFT OUTER JOIN dimension ON dimension.unidad_id = malla_curricular.codigo
LEFT OUTER JOIN indicadores ON indicadores.dimension_id = dimension.id
GROUP BY malla_curricular.codigo;


DROP VIEW IF EXISTS detalles_historico_proyecto;
CREATE VIEW detalles_historico_proyecto AS
SELECT
proyecto_historico.*,
concat(persona.nombre, ' ', persona.apellido) as nombre_tutor_in,
persona.telefono as telefono_tutor_in,
round(proyecto_historico.nota_fase_1 + proyecto_historico.nota_fase_2, 2) as calificacion
FROM proyecto_historico
LEFT JOIN profesor ON profesor.codigo = proyecto_historico.tutor_in
LEFT JOIN persona on persona.cedula = profesor.persona_id
ORDER BY periodo_final DESC;

DROP VIEW IF EXISTS detalles_usuarios;
CREATE VIEW detalles_usuarios AS
SELECT u.id,u.rol_id, u.email, u.contrasena, p.nombre, p.apellido, p.cedula FROM `usuario`  as u INNER JOIN persona as p ON p.usuario_id = u.id;

DROP VIEW IF EXISTS detalles_parroquia;
CREATE VIEW detalles_parroquia AS
SELECT parroquias.id as parroquia_id, parroquias.nombre as parroquia_nombre, municipios.id as municipio_id, municipios.nombre as municipio_nombre FROM `parroquias` INNER JOIN municipios ON municipios.id = parroquias.municipio;

DROP VIEW IF EXISTS detalles_consejo_comunal;
CREATE VIEW detalles_consejo_comunal AS
select 
cc.id as consejo_comunal_id,
cc.nombre as consejo_comunal_nombre,
cc.telefono as consejo_comunal_telefono,
scc.id as sector_id,
scc.nombre  as sector_nombre,
p.id as parroquia_id,
p.nombre as parroquia_nombre,
m.nombre as municipio_nombre
from consejo_comunal cc inner join sector_consejo_comunal scc ON scc.id = cc.sector_id 
inner join parroquias p on p.id = scc.parroquia_id 
inner join municipios m on m.id = p.municipio;
