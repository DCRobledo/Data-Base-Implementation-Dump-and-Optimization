CREATE
OR REPLACE VIEW ClubsVigentes(nombre, fundador, fecha_creacion, slogan) AS
SELECT
    DISTINCT name,
    founder,
    cre_date,
    slogan
FROM
    CLUBS
WHERE
    open = ‘ O ’;

GRANT
INSERT
    ON ClubsVigentes TO PUBLIC;

CREATE
OR REPLACE TRIGGER del_ClubsVigentes INSTEAD OF DELETE ON ClubsVigentes FOR EACH ROW BEGIN
UPDATE
    Clubs
SET
    open = ‘ C ’;

END;

CREATE
OR REPLACE VIEW ClubsNoVigentes(
    nombre,
    fundador,
    fecha_creacion,
    slogan,
    fecha_cierre
) AS
SELECT
    DISTINCT name,
    founder,
    cre_date,
    slogan,
    end_date
FROM
    clubs
WHERE
    open = ‘ C ’ WITH READ ONLY;

GRANT DELETE on ClubsNoVigentes TO PUBLIC;

CREATE
OR REPLACE VIEW PertenecenciaClubsVigentes (usuario, club) AS
SELECT
    DISTINCT nick,
    club
FROM
    membership
WHERE
    club IN (
        SELECT
            club
        FROM
            ClubsVigentes
    ) WITH READ ONLY;

CREATE
OR REPLACE VIEW PertenecenciaClubsNoVigentes (usuario, club) AS
SELECT
    DISTINCT nick,
    club
FROM
    membership
WHERE
    club IN (
        SELECT
            club
        FROM
            ClubsNoVigentes
    ) WITH READ ONLY;