--
-- Play with Database world
--

--
-- Find details about Sweden - country
--

SELECT
    `Code`,
    `Name`,
    `LocalName`,
    `Continent`,
    `Region`,
    `HeadOfState`,
    `IndepYear`,
    `Population`,
    `LifeExpectancy`
FROM `country`
WHERE
    `Code`= 'SWE'
;

--
-- Find details about Sweden - countrylanguage
--
SELECT * FROM `countrylanguage` WHERE `CountryCode`= 'SWE';
SELECT * FROM `countrylanguage` WHERE `CountryCode`= 'SWE' ORDER BY `Percentage` DESC;

--
-- Find details about Sweden - city
--
SELECT * FROM `city` WHERE `CountryCode`= 'SWE';


SELECT
    `Code`,
    `Name`,
    `Capital`
FROM `country`
WHERE
    `Code`= 'SWE'
;

SELECT
    * 
FROM `city` 
WHERE
    `ID`= '3048'
;

SELECT
    co.`Code`,
    co.`Name`,
    ci.`Name` As `Capital`
FROM
    `country` As co,
    `city` As ci
WHERE
    ci.`ID` = co.`Capital`
    AND co.`Code` = 'SWE'
;

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