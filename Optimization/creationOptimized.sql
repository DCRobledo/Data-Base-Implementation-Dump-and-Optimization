--DISEÑO FINAL--
--Modificacion de parametros--
/*Para todas las tablas*/
CREATE TABLE table (...) PCTFREE 0;

/*Para tablas con inserciones*/
CREATE TABLE table (...) PCTUSED 40;

--Espacio de cubo--
/*Para todas las tablas*/
CREATE TABLE table (...) TABLESPACE Tab_16k;

--Organizaciones auxiliares--
/*Indices sobre comments y proposals*/
CREATE INDEX index_comments ON comments (nick, title, director, club);

CREATE INDEX index_proposals ON proposals (member, title, director, club);

/*Vista materializada para la primera query*/
CREATE MATERIALIZED VIEW tragicomic_mv AS(
    SELECT
        title,
        director
    FROM
        GENRES_MOVIES
    WHERE
        UPPER(genre) = 'COMEDY'
    INTERSECT
    SELECT
        title,
        director
    FROM
        GENRES_MOVIES
    WHERE
        UPPER(genre) = 'DRAMA'
);

--Nueva QUERY 1 del workload--
FOR fila in (
    SELECT
        *
    FROM
        tragicomic_mv
) LOOP null;

END LOOP;