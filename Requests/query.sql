--Tragicomic--
SELECT
    DISTINCT actor
FROM
    casts
WHERE
(title, director) IN (
        (
            SELECT
                DISTINCT title,
                director
            FROM
                genres_movies
            WHERE
                genre = ’ Comedy ’
        )
        INTERSECT
        (
            SELECT
                DISTINCT title,
                director
            FROM
                genres_movies
            WHERE
                genre = ’ Drama ’
        )
    );

---Burden User-
SELECT
    DISTINCT nick
FROM
    profiles
WHERE
    nick IN (
        SELECT
            DISTINCT nick
        FROM
            users HERE reg_date <= sysdate -180
    )
    AND citizenId NOT IN (
        SELECT
            DISTINCT citizenID
        FROM
            contracts
    )
    AND nick NOT IN (
        SELECT
            DISTINCT nick
        FROM
            membership
    )
    AND nick NOT IN (
        SELECT
            DISTINCT nick
        FROM
            candidates
    );

--Film Master--
WITH peliculas AS(
    SELECT
        DISTINCT director,
        count(‘ x ’) AS a
    FROM
        movies
    GROUP BY
        director
    order by
        a desc
),
comentarios AS(
    SELECT
        DISTINCT director,
        count (‘ x ’) AS b
    FROM
        comments
    GROUP BY
        director
    Order by
        b desc
)
SELECT
    director,
    count(‘ x ‘)
FROM
    (
        SELECT
            director,
            count(‘ x ’),
            b / a AS media
        FROM
            peliculas
            JOIN comentarios Using(director)
        ORDER BY
            media desc
    )
WHERE
    rownum < 2;