--Application--
CREATE
OR REPLACE TRIGGER Application BEFORE
INSERT
    ON candidates FOR EACH ROW DECLARE esCerrado EXCEPTION;

op varchar (1);

BEGIN
SELECT
    open INTO op
FROM
    clubs
WHERE
    name = :NEW.club;

IF (op = ’ C ’) THEN raise esCerrado;

END IF;

EXCEPTION
WHEN esCerrado THEN raise_application_error(
    -20555,
    ‘ El club esta cerrado,
    por lo que no acepta solicitudes ’
);

END;

--Overwrite--
CREATE
OR REPLACE TRIGGER overWrite BEFORE
INSERT
    ON Comments FOR EACH ROW BEGIN
DELETE FROM
    Comments
WHERE
    nick = :NEW.nick
    AND title = :NEW.title
    AND director = :NEW.director;

END;

---The Kind is dead--
CREATE
OR REPLACE TRIGGER theKingIsDead BEFORE
UPDATE
    OF FOUNDER ON clubs FOR EACH ROW Declare fundadorN VARCHAR2(35);

BEGIN
SELECT
    nick INTO fundadorN
FROM
    (
        SELECT
            nick
        FROM
            membership
        WHERE
            club = :new.name
            AND nick != :OLD.founder
        ORDER BY
            inc_date ASC
    )
WHERE
    ROWNUM <= 1;

IF fundadorN IS NOT NULL THEN :NEW.founder := fundadorN;

ELSE :new.end_date := sysdate;

END IF;

END theKingIsDead;

--Reject on clousure--
CREATE
OR REPLACE TRIGGER rejectOnClausure BEFORE
UPDATE
    OF OPEN ON CLUBS FOR EACH ROW DECLARE newFounder VARCHAR(100);

WHEN :old.open = ’ o ’ BEGIN
SELECT
    USER INTO newFounder
FROM
    dual;

IF newFounder = :old.founder
AND :new.open = ’ c ’ THEN
UPDATE
    candidates
SET
    rej_date = sysdate,
    member = newFounder
WHERE
    type = ’ A ’
    AND club = :new.name;

ELSE
END IF;

END;

--No comment--
CREATE
OR REPLACE TRIGGER noCommentComments BEFORE
INSERT
    ON Comments FOR EACH ROW DECLARE num NUMBER(1);

BEGIN
SELECT
    COUNT(‘ X ’) INTO num
from
    comments
where
    msg_date = :NEW.msg_date;

IF num > 0 THEN :NEW.msg_date := :NEW.msg_date + 0.00001;

END IF;

END;

CREATE
OR REPLACE TRIGGER noCommentsProposals BEFORE
INSERT
    ON proposals FOR EACH ROW DECLARE num NUMBER(1);

BEGIN
SELECT
    COUNT(‘ X ’) INTO num
from
    proposals
WHERE
    prop_date = :new.prop_date;

IF num > 0 THEN :NEW.prop_date := :NEW.prop_date + 0.00001;

END IF;

END;

--Reachable clients--
CREATE
OR REPLACE TRIGGER reachableClients FOR
INSERT
    ON contracts COMPOUND TRIGGER movilCliente number(12);

no_insertes EXCEPTION;

AFTER
    EACH ROW IS BEGIN
SELECT
    DISTINCT mobile INTO movilCliente
FROM
    profiles
WHERE
    citizenID = :NEW.citizenID;

END
AFTER
    EACH ROW;

AFTER
    STATEMENT IS BEGIN IF movilCliente IS NULL THEN RAISE no_insertes;

END IF;

EXCEPTION
WHEN no_insertes THEN
DELETE FROM
    contracts
WHERE
    citizenID = :NEW.citizenID;

DBMS_OUTPUT.PUT_LINE(
    '[ERROR] Todo cliente
debe tener un numero de telefono'
);

END
AFTER
    STATEMENT;

END reachableClients;