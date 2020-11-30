INSERT INTO
    peliculas(
        isBN,
        director,
        duracion,
        likes_dir,
        ingresos,
        likes_reparto,
        titulo,
        rostros,
        link,
        idioma,
        pais,
        calificacion_edad,
        presupuesto,
        anio,
        ratio,
        likes_pelicula,
        num_votos_usuarios
    )
SELECT
    DISTINCT color,
    director_name,
    duration,
    director_facebook_likes,
    gross,
    cast_total_facebook_likes,
    movie_title,
    facenumber_in_poster,
    movie_imdb_link,
    language,
    country,
    content_rating,
    budget,
    title_year,
    aspect_ratio,
    movie_facebook_likes,
    num_voted_users
FROM
    old_movies
WHERE
    movie_title != 'The Sting'
    AND budget IS NOT NULL
    AND content_rating IS NOT NULL
    AND color IS NOT NULL
    AND aspect_ratio IS NOT NULL
    AND facenumber_in_poster IS NOT NULL
    AND language IS NOT NULL
    AND gross IS NOT NULL;

INSERT INTO
    generos(nombre)
SELECT
    DISTINCT genre1
FROM
    old_movies
WHERE
    genre1 IS NOT NULL;

INSERT INTO
    palabrasClave(pelicula_titulo, pelicula_director, palabra)
SELECT
    DISTINCT movie_title,
    director_name,
    keyword1
FROM
    old_movies
WHERE
    keyword1 IS NOT NULL
    AND movie_title != 'The Sting'
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    palabrasClave(pelicula_titulo, pelicula_director, palabra)
SELECT
    DISTINCT movie_title,
    director_name,
    keyword2
FROM
    old_movies
WHERE
    keyword2 IS NOT NULL
    AND movie_title != 'The Sting'
    AND keyword2 NOT IN(
        SELECT
            palabra
        FROM
            palabrasClave
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    palabrasClave(pelicula_titulo, pelicula_director, palabra)
SELECT
    DISTINCT movie_title,
    director_name,
    keyword3
FROM
    old_movies
WHERE
    keyword3 IS NOT NULL
    AND movie_title != 'The Sting'
    AND keyword3 NOT IN(
        SELECT
            palabra
        FROM
            palabrasClave
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    palabrasClave(pelicula_titulo, pelicula_director, palabra)
SELECT
    DISTINCT movie_title,
    director_name,
    keyword4
FROM
    old_movies
WHERE
    keyword4 IS NOT NULL
    AND movie_title != 'The Sting'
    AND keyword4 NOT IN(
        SELECT
            palabra
        FROM
            palabrasClave
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    palabrasClave(pelicula_titulo, pelicula_director, palabra)
SELECT
    DISTINCT movie_title,
    director_name,
    keyword5
FROM
    old_movies
WHERE
    keyword5 IS NOT NULL
    AND movie_title != 'The Sting'
    AND keyword5 NOT IN(
        SELECT
            palabra
        FROM
            palabrasClave
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    actores(nombre)
SELECT
    DISTINCT actor_1_name
FROM
    old_movies
WHERE
    actor_1_name IS NOT NULL;

INSERT INTO
    actores(nombre)
SELECT
    DISTINCT actor_2_name
FROM
    old_movies
WHERE
    actor_2_name IS NOT NULL
    AND actor_2_name NOT IN(
        SELECT
            nombre
        FROM
            actores
    );

INSERT INTO
    actores(nombre)
SELECT
    DISTINCT actor_3_name
FROM
    old_movies
WHERE
    actor_3_name IS NOT NULL
    AND actor_3_name NOT IN(
        SELECT
            nombre
        FROM
            actores
    );

INSERT INTO
    ld_peliculas_actores(pelicula_titulo, pelicula_director, actor, likes)
SELECT
    DISTINCT movie_title,
    director_name,
    actor_1_name,
    actor_1_facebook_likes
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND actor_1_name IS NOT NULL
    AND actor_1_name IN(
        SELECT
            nombre
        FROM
            actores
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_actores(pelicula_titulo, pelicula_director, actor, likes)
SELECT
    DISTINCT movie_title,
    director_name,
    actor_2_name,
    actor_2_facebook_likes
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND actor_2_name IS NOT NULL
    AND actor_2_name IN(
        SELECT
            nombre
        FROM
            actores
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_actores(pelicula_titulo, pelicula_director, actor, likes)
SELECT
    DISTINCT movie_title,
    director_name,
    actor_3_name,
    actor_3_facebook_likes
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND actor_3_name IS NOT NULL
    AND actor_3_name IN(
        SELECT
            nombre
        FROM
            actores
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_generos(pelicula_titulo, pelicula_director, genero)
SELECT
    DISTINCT movie_title,
    director_name,
    genre1
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND genre1 IN(
        SELECT
            nombre
        FROM
            generos
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_generos(pelicula_titulo, pelicula_director, genero)
SELECT
    DISTINCT movie_title,
    director_name,
    genre2
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND genre2 IN(
        SELECT
            nombre
        FROM
            generos
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_generos(pelicula_titulo, pelicula_director, genero)
SELECT
    DISTINCT movie_title,
    director_name,
    genre3
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND genre3 IN(
        SELECT
            nombre
        FROM
            generos
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_generos(pelicula_titulo, pelicula_director, genero)
SELECT
    DISTINCT movie_title,
    director_name,
    genre4
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND genre4 IN(
        SELECT
            nombre
        FROM
            generos
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    ld_peliculas_generos(pelicula_titulo, pelicula_director, genero)
SELECT
    DISTINCT movie_title,
    director_name,
    genre5
FROM
    old_movies
WHERE
    movie_title IS NOT NULL
    AND movie_title != 'The Sting'
    AND director_name IS NOT NULL
    AND genre5 IN(
        SELECT
            nombre
        FROM
            generos
    )
    AND movie_title IN(
        SELECT
            titulo
        FROM
            peliculas
    );

INSERT INTO
    perfiles(
        numero_tlf,
        dni,
        fecha_nacimiento,
        edad,
        apellido1,
        apellido2
    )
SELECT
    DISTINCT phonen,
    citizenid,
    birthdate,
    age,
    surname,
    sec_surname
FROM
    old_users
WHERE
    citizenid IS NOT NULL
    AND citizenid != '82768894J';

INSERT INTO
    usuarios(contrasenia, nombre, correo, perfil)
SELECT
    DISTINCT passw,
    nickname,
    email,
    citizenid
FROM
    old_users
WHERE
    name IS NOT NULL
    AND citizenid != '82768894J'
    AND nickname IN(
        SELECT
            nickname
        FROM
            old_users
        GROUP BY
            nickname
        HAVING
            COUNT(nickname) = 1
    );

INSERT INTO
    contratos(contrato)
SELECT
    DISTINCT contract_type
FROM
    old_users
WHERE
    contract_type IS NOT NULL;

INSERT INTO
    servicios(
        id,
        fecha_inicio,
        fecha_fin,
        contrato,
        direccion,
        codigo_postal,
        pais,
        ciudad
    )
SELECT
    DISTINCT contractId,
    startdate,
    enddate,
    contract_type,
    address,
    zipcode,
    country,
    town
FROM
    old_users
WHERE
    contractId IS NOT NULL
    AND contract_type IN(
        SELECT
            contrato
        FROM
            contratos
    );

INSERT INTO
    ld_servicios_usuarios(servicio, usuario)
SELECT
    DISTINCT contractid,
    nickname
FROM
    old_users
WHERE
    contractid IS NOT NULL
    AND name IS NOT NULL
    AND citizenid IS NOT NULL
    AND citizenid != '82768894J'
    AND nickname IN(
        SELECT
            nickname
        FROM
            old_users
        GROUP BY
            nickname
        HAVING
            COUNT(nickname) = 1
    );

INSERT INTO
    clubes(nombre, fecha_fundacion)
SELECT
    DISTINCT club,
    ev_date
FROM
    old_events
WHERE
    Etype = 'foundation'
    AND ev_date IS NOT NULL;

INSERT INTO
    miembros(usuario, club)
SELECT
    DISTINCT client,
    club
FROM
    old_events
WHERE
    client IS NOT NULL
    AND (
        Etype = 'foundation'
        OR Etype = 'acceptance'
    )
    AND club IS NOT NULL
    AND client IN(
        SELECT
            nombre
        FROM
            usuarios
    )
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    )
    AND (client, club) IN (
        SELECT
            client,
            club
        FROM
            old_events
        GROUP BY
            client,
            club
        HAVING
            COUNT(*) = 1
    );

INSERT INTO
    invitaciones(fecha, hora, mensaje, club, solicitante, enviado)
SELECT
    DISTINCT ev_date,
    ev_hour,
    message,
    club,
    client,
    subject
FROM
    old_events
WHERE
    Etype = 'invitation'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND client IN(
        SELECT
            nombre
        FROM
            usuarios
    )
    AND subject IN(
        SELECT
            nombre
        FROM
            usuarios
    )
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    )
    AND (ev_date, ev_hour) IN(
        SELECT
            ev_date,
            ev_hour
        FROM
            old_events
        WHERE
            Etype = 'invitation'
        GROUP BY
            ev_date,
            ev_hour
        HAVING
            COUNT(*) = 1
    );

INSERT INTO
    fundaciones(fecha, hora, club, usuario)
SELECT
    DISTINCT ev_date,
    ev_hour,
    club,
    client
FROM
    old_events
WHERE
    Etype = 'foundation'
    AND client IN(
        SELECT
            nombre
        FROM
            usuarios
    )
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND (ev_date, ev_hour) IN(
        SELECT
            ev_date,
            ev_hour
        FROM
            old_events
        WHERE
            Etype = 'foundation'
        GROUP BY
            ev_date,
            ev_hour
        HAVING
            COUNT(*) = 1
    );

INSERT INTO
    aceptaciones(fecha, hora, mensaje)
SELECT
    DISTINCT ev_date,
    ev_hour,
    message
FROM
    old_events
WHERE
    Etype = 'acceptance'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    )
    AND (ev_date, ev_hour) IN(
        SELECT
            fecha,
            hora
        FROM
            Invitaciones
    );

INSERT INTO
    rechazos(fecha, hora, mensaje)
SELECT
    DISTINCT ev_date,
    ev_hour,
    message
FROM
    old_events
WHERE
    Etype = 'rechazos'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    )
    AND (ev_date, ev_hour) IN(
        SELECT
            fecha,
            hora
        FROM
            Invitaciones
    );

INSERT INTO
    registrosUsuarios(
        fecha,
        hora,
        mensaje,
        club,
        solicitante,
        solicitado
    )
SELECT
    DISTINCT ev_date,
    ev_hour,
    message,
    club,
    client,
    subject
FROM
    old_events
WHERE
    Etype = 'registration'
    AND subject IS NOT NULL
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL;

INSERT INTO
    registrosClubes(fecha, hora, club, mensaje)
SELECT
    DISTINCT ev_date,
    ev_hour,
    club,
    message
FROM
    old_events
WHERE
    Etype = 'application'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    );

INSERT INTO
    clausuras(fecha, hora, club)
SELECT
    DISTINCT ev_date,
    ev_hour,
    club
FROM
    old_events
WHERE
    Etype = 'ceasing'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND club IN(
        SELECT
            nombre
        FROM
            clubes
    );

INSERT INTO
    visualizaciones(
        fecha,
        hora,
        mensaje,
        club,
        usuario,
        pelicula_titulo
    )
SELECT
    DISTINCT ev_date,
    ev_hour,
    message,
    club,
    client,
    subject
FROM
    old_events
WHERE
    Etype = 'viewing'
    AND subject IS NOT NULL
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL;

INSERT INTO
    propuestas(
        fecha,
        hora,
        mensaje,
        miembro_club,
        miembro_usuario,
        pelicula_titulo,
        pelicula_director
    )
SELECT
    DISTINCT ev_date,
    ev_hour,
    message,
    club,
    client,
    details1,
    details2
FROM
    old_events
WHERE
    Etype = 'proposal'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND client IN(
        SELECT
            usuario
        FROM
            miembros
    );

INSERT INTO
    opiniones(
        fecha,
        hora,
        mensaje,
        pelicula_titulo,
        pelicula_director,
        miembro_club,
        miembro_usuario
    )
SELECT
    DISTINCT ev_date,
    ev_hour,
    message,
    details1,
    details2,
    club,
    client
FROM
    old_events
WHERE
    Etype = 'opinion'
    AND ev_date IS NOT NULL
    AND ev_hour IS NOT NULL
    AND client IN(
        SELECT
            usuario
        FROM
            miembros
    );