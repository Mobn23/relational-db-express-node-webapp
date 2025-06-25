--
-- Det är vi slutade sist.
--
SELECT
    co.`Code`,
    co.`Name`,
    ci.`Name` As 'Capital'
FROM `country` As co
    JOIN `city` As ci
        ON ci.`ID` = co.`Capital`
WHERE
    co.`Code` = 'SWE'
;

SELECT
    co.`Code`,
    co.`Name`,
    co.`capital`
FROM `country` As co
WHERE
    co.`Code` = 'SWE'
;

SELECT
    co.`Code`,
    co.`Name`,
    ci.`name` as `capital`
FROM `country` As co
    JOIN `city` AS ci
        ON ci.`id` = co.`capital`
WHERE
    co.`Code` = 'SWE'
;

SELECT * FROM `countrylanguage` limit 5;
SELECT * FROM `countrylanguage` WHERE `countryCode` = 'SWE';

SELECT
    co.`Code`,
    co.`Name`,
    ci.`name` as `capital`,
    la.`language`
FROM `country` As co
    JOIN `city` AS ci
        ON ci.`id` = co.`capital`
    JOIN `countrylanguage` AS la
        ON la.`countryCode` = co.`code`
WHERE
    co.`Code` = 'SWE'
    AND la.`IsOfficial` = 'T'
;

--
-- SELECT DISTINCT
--

SELECT `continent` FROM `SWE` LIMIT 5;
SELECT `continent` FROM `country`;
SELECT DISTINCT `continent` FROM `country`;

SELECT `region` FROM `country`;
SELECT DISTINCT `region` FROM `country`;

SELECT
    co.`Code`,
    co.`Name` AS `country`,
    ci.`name` As `capital`,
    GROUP_CONCAT(la.`language`),
    co.`region`,
    co.`Continent`,
    co.`LifeExpectancy`,
    co.`continent`
FROM `country` As co
    JOIN `city` AS ci
        ON ci.`ID` = co.`capital`
    JOIN `countrylanguage` AS la
        ON la.`countryCode` = co.`code`
WHERE
    -- co.`Code` = 'SWE'
    -- co.`region` LIKE 'Nordic%'
    -- AND la.`IsOfficial` = 'T'
    co.`continent` = 'Europe'
GROUP BY
    co.`Code`
ORDER BY
    co.`LifeExpectancy` DESC
;
