--
-- tips from coatchen.
--

UPDATE `user`
SET
    `name` = 'Mega Mos'
WHERE
    `acronym` = 'mos'
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated
FROM user
;

UPDATE `user`
SET
    `activated` = CURRENT_TIMESTAMP
WHERE
    `acronym` = 'mos'
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    `updated`,
    `activated`,
    `deleted`
FROM user
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated,
    IF(`activated` IS NOT NULL, 'Activated', '') AS Activated
FROM `user`
;

UPDATE `user`
SET
    `deleted` = CURRENT_TIMESTAMP
WHERE
    `acronym` = 'doe'
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    `updated`,
    `activated`,
    `deleted`
FROM `user`
;

SELECT
    CONCAT(`name`, ' (', `acronym`, ')') AS User,
    IF(`created` IS NOT NULL, 'Created', '') AS Created,
    IF(`updated` IS NOT NULL, 'Updated', '') AS Updated,
    IF(`activated` IS NOT NULL, 'Activated', '') AS Activated,
    IF(`deleted` IS NOT NULL, 'Deleted', '') AS Deleted
FROM `user`
;
