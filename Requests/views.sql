--Captain Aragna--
CREATE
OR REPLACE VIEW captainAragna AS WITH propuestasSinComentarios AS (
    SELECT
        DISTINCT member,
        count(‘ x ’) AS numComentarios
    FROM
        proposals
    WHERE
(title, director, club, member) NOT IN(
            SELECT
                DISTINCT title,
                director,
                club,
                member
            FROM
                comments
        )
    GROUP BY
        (member)
),
totalPropuestas AS (
    SELECT
        DISTINCT member,
        count(‘ x ’) as numPropuestas
    FROM
        proposals
    GROUP BY
        member
)
SELECT
    DISTINCT member as miembro,
    numComentarios / numPropuestas * 100 as ratio
FROM
    propuestasSinComentarios
    JOIN totalPropuestas USING(member)
ORDER BY
    ratio DESC;

--Leader--
CREATE
OR REPLACE VIEW leader AS WITH propuestas AS (
    SELECT
        member,
        club,
        title,
        director
    FROM
        proposals
),
comentariosPorClub AS (
    SELECT
        club,
        title,
        director,
        COUNT(*) AS numcom
    FROM
        comments
    GROUP BY
        (club, title, director)
    ORDER BY
        numcom
),
comentariosPorMiembros AS(
    SELECT
        member,
        club,
        numcom
    FROM
        (
            SELECT
                *
            FROM
                comentariosPorClub
                JOIN propuestas USING(club, title, director)
        )
    order by
        numcom
),
sumaComentariosPorMiembro AS(
    SELECT
        member,
        club,
        sum(numcom) AS suma
    FROM
        comentariosPorMiembros
    GROUP BY
        (member, club)
    order by
        suma
),
unionParaMedia AS (
    SELECT
        *
    FROM
        sumaComentariosPorMiembro
        JOIN (
            SELECT
                member,
                club,
                COUNT(member) AS numprop
            FROM
                proposals
            GROUP BY
                (member, club)
        ) USING (member, club)
    ORDER BY
        suma DESC
)
SELECT
    member,
    club,
    suma / numprop AS media
FROM
    unionParaMedia
WHERE
    rownum <= 10
ORDER BY
    media DESC;