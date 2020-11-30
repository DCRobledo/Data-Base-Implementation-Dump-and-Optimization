--Registered User--
CREATE ROLE usuarioRegistradoFSDB154;

GRANT
SELECT
    ON openPub to usuarioRegistradoFSDB154;

GRANT
SELECT
    ON anyoneGoes to usuarioRegistradoFSDB154;

GRANT
SELECT
    ON report to usuarioRegistradoFSDB154;

CREATE
OR REPLACE VIEW numMiembros(club, numMiembros) AS
SELECT
    DISTINCT club,
    count (‘ x ’)
FROM
    membership
WHERE
    club IN(
        SELECT
            DISTINCT name
        FROM
            clubs
        WHERE
            open = ‘ O ’
    )
GROUP BY
    club;

CREATE
OR REPLACE VIEW mesesActuacion(club, mesesActuacion) AS
SELECT
    DISTINCT name,
    round(months_between(sysdate, cre_date))
FROM
    clubs
WHERE
    open LIKE ‘ O ’;

CREATE
OR REPLACE VIEW numPropuestasPorMes(club, numPropuestasPorMes) AS
SELECT
    DISTINCT club,
    round(count(‘ x ’) / 12)
FROM
    proposals
WHERE
    club IN(
        SELECT
            DISTINCT name
        FROM
            clubs
        WHERE
            open LIKE ’ O ’
    )
GROUP BY
    club;

CREATE
OR REPLACE VIEW numComentariosPorPropuesta(club, numComentariosPorPropuesta) AS
SELECT
    DISTINCT club,
    count(‘ x ’)
FROM
    comments
GROUP BY
    (club);

CREATE
OR REPLACE VIEW openPub (
    club,
    numeroMiembros,
    mesesActuacion,
    numPropuestasPorMes,
    numComentariosPorPropuesta
) AS
SELECT
    DISTINCT club,
    numMiembros,
    mesesActuacion,
    numPropuestasPorMes,
    numComentariosPorPropuesta
FROM
    (
        (
            numMiembros
            JOIN mesesActuacion USING (club)
        )
        JOIN (
            numPropuestasPorMes
            JOIN numComentariosPorPropuesta USING (club)
        ) USING (club)
    );

CREATE
OR REPLACE VIEW anyoneGoes(topClub) as
SELECT
    DISTINCT club
FROM
    (
        SELECT
            club
        FROM
            membership
        GROUP BY
            club
        ORDER BY
            (count(‘ x ’)) DESC
    )
WHERE
    rownum < 6;

CREATE
OR REPLACE VIEW report (nombre, candidatura, fecha_registro, fecha_fin) AS WITH usuarioRegistrado AS (
    SELECT
        user as usuarioRegistrado
    FROM
        dual
)
SELECT
    DISTINCT club,
    type,
    req_date,
    end_date
FROM
    membership
WHERE
    club IN (
        SELECT
            DISTINCT club
        FROM
            membership
        WHERE
            nick LIKE (
                SELECT
                    usuarioRegistrado
                FROM
                    usuarioRegistrado
            )
        UNION
        SELECT
            DISTINCT club
        FROM
            candidates
        WHERE
            nick LIKE (
                SELECT
                    usuarioRegistrado
                FROM
                    usuarioRegistrado
            )
            AND type LIKE ‘ I ’
    )
    AND nick LIKE (
        SELECT
            usuarioRegistrado
        FROM
            dual
    );

--Founder User--
CREATE ROLE usuarioFundadorFSDB154;

GRANT
SELECT
    ON administraPub to usuarioFundadorFSDB154;

GRANT
SELECT
    ON favouriteGenres to usuarioFundadorFSDB154;

GRANT
SELECT
    ON pending to usuarioFundadorFSDB154;

CREATE
OR REPLACE VIEW administraPub AS WITH usuarioFundador AS (
    SELECT
        user AS usuarioFundador
    FROM
        dual
),
clubesFundador AS (
    SELECT
        DISTINCT club
    FROM
        membership
    WHERE
        type = ‘ F ’
        AND nick = (
            SELECT
                usuarioFundador
            FROM
                usuarioFundador
        )
),
propuestasTotales AS (
    SELECT
        DISTINCT member AS miembro,
        count(‘ x ’) AS propuestasTotales
    FROM
        proposals
    WHERE
        club IN (
            SELECT
                DISTINCT club
            FROM
                clubesFundador
        )
    GROUP BY
        (member)
),
propuestasComentadas AS (
    SELECT
        DISTINCT member AS miembro,
        count(‘ x ’) AS propuestasComentadas
    FROM
        proposals
    WHERE
        (title, director, member) IN (
            SELECT
                DISTINCT title,
                director,
                member
            FROM
                proposals
        )
        AND club IN (
            SELECT
                DISTINCT club
            FROM
                clubesFundador
        )
    GROUP BY
        (member)
),
comentariosMiembros AS (
    SELECT
        DISTINCT nick AS miembro,
        msg_date AS ultimoComentario,
        club
    FROM
        comments
    ORDER BY
        msg_date ASC
)
SELECT
    DISTINCT miembro AS miembro,
    club,
    propuestasComentadas / propuestasTotales * 100 AS porcentajePropuestasComentadas,
    sysdate - (
        SELECT
            ultimoComentario
        FROM
            comentariosMiembros
        WHERE
            rownum = 1
    ) AS tiempoDesdeUltimoComentario
FROM
    (
        propuestasTotales
        JOIN propuestasComentadas USING(miembro)
    )
    JOIN comentariosMiembros USING (miembro);

CREATE
OR REPLACE VIEW favouriteGenres AS WITH totalComentarios AS (
    SELECT
        title,
        director,
        count('x') AS totalComentarios
    FROM
        comments
    GROUP BY
        (title, director)
),
valoracionTotal AS (
    SELECT
        title,
        director,
        sum(valoration) AS valoracionTotal
    FROM
        comments
    GROUP BY
        (title, director)
)
SELECT
    title AS titulo,
    director AS director,
    genre AS genero,
    valoracionTotal / totalComentarios AS valoracionMedia
FROM
    (
        totalComentarios
        JOIN valoracionTotal USING(title, director)
    )
    JOIN genres_movies USING (title, director)
ORDER BY
    valoracionMedia DESC;

CREATE
OR REPLACE VIEW pending AS WITH usuarioFundador AS (
    SELECT
        user AS usuarioFundador
    FROM
        dual
),
misClubes AS (
    SELECT
        DISTINCT club
    FROM
        membership
    WHERE
        type = ‘ F ’
        AND nick = (
            SELECT
                usuarioFundador
            FROM
                usuarioFundador
        )
)
SELECT
    DISTINCT nick AS usuario,
    club,
    req_date AS fecha,
    req_msg AS mensaje
FROM
    candidates
WHERE
    club IN (
        SELECT
            DISTINCT club
        FROM
            misClubes
    )
    AND nick NOT IN (
        SELECT
            DISTINCT nick
        FROM
            membership
        WHERE
            club IN (
                SELECT
                    DISTINCT club
                FROM
                    misClubes
            )
    );