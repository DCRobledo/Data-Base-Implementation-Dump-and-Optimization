DROP TABLE ld_servicios_usuarios;

DROP TABLE ld_peliculas_actores;

DROP TABLE ld_peliculas_generos;

DROP TABLE palabrasClave;

DROP TABLE servicios;

DROP TABLE contratos;

DROP TABLE visualizaciones;

DROP TABLE clausuras;

DROP TABLE actores;

DROP TABLE rechazos;

DROP TABLE aceptaciones;

DROP TABLE propuestas;

DROP TABLE opiniones;

DROP TABLE invitaciones;

DROP TABLE miembros;

DROP TABLE registrosUsuarios;

DROP TABLE registrosClubes;

DROP TABLE fundaciones;

DROP TABLE clubes;

DROP TABLE peliculas;

DROP TABLE generos;

DROP TABLE usuarios;

DROP TABLE perfiles;

CREATE TABLE perfiles(
	dni varchar2(9) NOT NULL,
	nombre varchar2(100),
	apellido1 varchar2(100),
	apellido2 varchar2 (100),
	edad number(3),
	numero_tlf varchar2(100),
	fecha_nacimiento varchar2(100),
	CONSTRAINT pk_perfiles PRIMARY KEY (dni)
);

CREATE TABLE usuarios(
	nombre varchar2(100) NOT NULL,
	contrasenia varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	correo varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	perfil varchar2(100),
	CONSTRAINT pk_usuarios PRIMARY KEY (nombre),
	CONSTRAINT uc_usuarios UNIQUE (correo),
	CONSTRAINT fk_ususarios_perfiles FOREIGN KEY (perfil) REFERENCES perfiles(dni) ON DELETE CASCADE
);

CREATE TABLE generos(
	nombre varchar2(100) not null,
	CONSTRAINT pk_generos PRIMARY KEY (nombre)
);

CREATE TABLE peliculas(
	titulo varchar2(100) NOT NULL,
	director varchar2(100) NOT NULL,
	link varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	duracion varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	isBN varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	ratio varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	anio varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	rostros varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	likes_pelicula varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	likes_dir varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	likes_reparto varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	calificacion_edad varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	puntuacion varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	pais varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	idioma varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	presupuesto varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	ingresos varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	num_votos_usuarios varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	CONSTRAINT pk_peliculas PRIMARY KEY (titulo, director),
	CONSTRAINT uc_peliculas UNIQUE (link)
);

CREATE TABLE clubes(
	nombre varchar2(100) NOT NULL,
	fecha_fundacion varchar2(100),
	CONSTRAINT pk_clubes PRIMARY KEY(nombre)
);

CREATE TABLE fundaciones(
	usuario varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_fundaciones PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_fundaciones_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(nombre),
	CONSTRAINT fk_fundaciones_clubes FOREIGN KEY (club) REFERENCES clubes(nombre)
);

CREATE TABLE clausuras(
	club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_clausuras PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_clausuras_clubes FOREIGN KEY (club) REFERENCES clubes(nombre)
);

CREATE TABLE registrosClubes(
	club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_registrosClubes PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_registrosClubes_clubes FOREIGN KEY (club) REFERENCES clubes(nombre)
);

CREATE TABLE registrosUsuarios(
	solicitante varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	solicitado varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_registrosUsuarios PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_registrosUsuarios_solicitante FOREIGN KEY (solicitante) REFERENCES usuarios(nombre),
	CONSTRAINT fk_registrosUsuarios_solicitado FOREIGN KEY (solicitado) REFERENCES usuarios(nombre),
	CONSTRAINT fk_registrosUsuarios_clubes FOREIGN KEY (club) REFERENCES clubes(nombre)
);

CREATE TABLE miembros(
	usuario varchar2(100) NOT NULL,
	club varchar2(100) NOT NULL,
	CONSTRAINT pk_miembros PRIMARY KEY(usuario, club),
	CONSTRAINT fk_miembros_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(nombre) ON DELETE CASCADE,
	CONSTRAINT fk_miembros_clubes FOREIGN KEY (club) REFERENCES clubes(nombre) ON DELETE CASCADE
);

CREATE TABLE invitaciones(
	solicitante varchar2(100) NOT NULL,
	enviado varchar2(100) NOT NULL,
	club varchar2(100) NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_invitaciones PRIMARY KEY(fecha, hora),
	CONSTRAINT fk_invitaciones_usuarios_solicitante FOREIGN KEY (solicitante) REFERENCES usuarios(nombre) ON DELETE CASCADE,
	CONSTRAINT fk_invitaciones_usuarios_enviado FOREIGN KEY (enviado) REFERENCES usuarios(nombre) ON DELETE CASCADE,
	CONSTRAINT fk_invitaciones_clubes FOREIGN KEY (club) REFERENCES clubes(nombre) ON DELETE CASCADE
);

CREATE TABLE opiniones(
	miembro_usuario varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	miembro_club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_titulo varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_director varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	valoracion varchar2(100),
	mensaje varchar2(2000) DEFAULT 'Desconocido',
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	CONSTRAINT pk_opiniones PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_opiniones_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director),
	CONSTRAINT fk_opiniones_miembros FOREIGN KEY (miembro_usuario, miembro_club) REFERENCES miembros(usuario, club)
);

CREATE TABLE propuestas(
	miembro_usuario varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	miembro_club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_titulo varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_director varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(2000) DEFAULT 'Desconocido',
	CONSTRAINT pk_propuestas PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_propuestas_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director),
	CONSTRAINT fk_propuestas_miembros FOREIGN KEY (miembro_usuario, miembro_club) REFERENCES miembros(usuario, club)
);

CREATE TABLE aceptaciones(
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_aceptaciones PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_aceptaciones_invitaciones FOREIGN KEY (fecha, hora) REFERENCES invitaciones(fecha, hora)
);

CREATE TABLE rechazos(
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_rechazos PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_rechazos_invitaciones FOREIGN KEY (fecha, hora) REFERENCES invitaciones(fecha, hora)
);

CREATE TABLE visualizaciones(
	usuario varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_titulo varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	pelicula_director varchar2 (100) DEFAULT 'Desconocido' NOT NULL,
	club varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha varchar2(100) NOT NULL,
	hora varchar2(100) NOT NULL,
	mensaje varchar2(100) DEFAULT 'Desconocido',
	CONSTRAINT pk_visualizaciones PRIMARY KEY (fecha, hora),
	CONSTRAINT fk_visualizaciones_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(nombre),
	CONSTRAINT fk_visualizaciones_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director)
);

CREATE TABLE actores(
	nombre varchar2(100) NOT NULL,
	CONSTRAINT pk_actores PRIMARY KEY(nombre)
);

CREATE TABLE contratos(
	contrato varchar2(100) NOT NULL,
	CONSTRAINT pk_contratos PRIMARY KEY(contrato)
);

CREATE TABLE servicios(
	id varchar2(100) NOT NULL,
	fecha_inicio varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	fecha_fin varchar2(100),
	contrato varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	direccion varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	codigo_postal varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	pais varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	nombre varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	ciudad varchar2(100) DEFAULT 'Desconocido' NOT NULL,
	CONSTRAINT pk_servicios PRIMARY KEY(id),
	CONSTRAINT fk_servicios_contratos FOREIGN KEY (contrato) REFERENCES contratos(contrato)
);

CREATE TABLE palabrasClave(
	pelicula_titulo varchar2(100) NOT NULL,
	pelicula_director varchar2(100) NOT NULL,
	palabra varchar2(100) NOT NULL,
	CONSTRAINT pk_palabrasClave PRIMARY KEY(pelicula_titulo, pelicula_director, palabra),
	CONSTRAINT fk_palabrasClave_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director)
);

CREATE TABLE ld_peliculas_actores(
	pelicula_titulo varchar2(100) NOT NULL,
	pelicula_director varchar2(100) NOT NULL,
	actor varchar2(100) NOT NULL,
	likes varchar2(100) NOT NULL,
	CONSTRAINT pk_ld_peliculas_actores PRIMARY KEY(pelicula_titulo, pelicula_director, actor),
	CONSTRAINT fk_ld_peliculas_actores_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director),
	CONSTRAINT fk_ld_peliculas_actores_actores FOREIGN KEY (actor) REFERENCES actores(nombre)
);

CREATE TABLE ld_peliculas_generos(
	pelicula_titulo varchar2(100) NOT NULL,
	pelicula_director varchar2(100) NOT NULL,
	genero varchar2(100) NOT NULL,
	CONSTRAINT pk_ld_peliculas_generos PRIMARY KEY(pelicula_titulo, pelicula_director, genero),
	CONSTRAINT fk_ld_peliculas_generos_peliculas FOREIGN KEY (pelicula_titulo, pelicula_director) REFERENCES peliculas(titulo, director),
	CONSTRAINT fk_ld_peliculas_generos_actores FOREIGN KEY (genero) REFERENCES generos(nombre)
);

CREATE TABLE ld_servicios_usuarios(
	servicio varchar2(100) NOT NULL,
	usuario varchar2(100) NOT NULL,
	CONSTRAINT pk_ld_servicios_usuarios PRIMARY KEY(servicio, usuario),
	CONSTRAINT fk_ld_servicios_usuarios_servicios FOREIGN KEY (servicio) REFERENCES servicios(id) ON DELETE CASCADE,
	CONSTRAINT fk_ld_servicios_usuarios_usuarios FOREIGN KEY (usuario) REFERENCES usuarios(nombre) ON DELETE CASCADE
);