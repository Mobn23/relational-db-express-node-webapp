mysql --table ovkmom06 < example/sql/index.sql
SELECT * FROM course;
EXPLAIN course;
EXPLAIN SELECT * FROM course;
SELECT * FROM course WHERE code = 'PA1444';
ALTER TABLE course ADD PRIMARY KEY(code);

EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';
ALTER TABLE course ADD CONSTRAINT nick_unique UNIQUE (nick);
EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';

SHOW INDEX FROM course;
DROP INDEX nick_unique ON course;
CREATE UNIQUE INDEX nick_unique ON course (nick);
SELECT * FROM course WHERE name LIKE 'Webb%';
EXPLAIN SELECT * FROM course WHERE name LIKE 'Webb%';
-- WE USE EXPLAIN IN ORDER TO DISPLAY THE SEARCH(OPTIMISATION) INFO like in how many rows the engine searched.
CREATE INDEX index_name ON course(name);
EXPLAIN SELECT * FROM course WHERE name LIKE '%prog%';
CREATE FULLTEXT INDEX full_name ON course(name);
SELECT 
    name,
    MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score 
FROM 
    course 
ORDER BY 
    score DESC
;
SELECT * FROM course WHERE points > 7.5;

EXPLAIN SELECT * FROM course WHERE points > 7.5;
CREATE INDEX index_points ON course(points);
-- The database doesn’t need to scan each row sequentially. The index acts like a map, guiding it directly to the relevant rows based on the indexed points values.
SHOW INDEX FROM course;
EXPLAIN course;
SHOW CREATE TABLE course\G

--the final result of both files
Create Table: CREATE TABLE `course` (
  `code` char(6) NOT NULL DEFAULT '',
  `nick` char(12) DEFAULT NULL,
  `points` decimal(3,1) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `nick_unique` (`nick`),
  KEY `index_points` (`points`),
  KEY `index_name` (`name`),
  FULLTEXT KEY `full_name` (`name`)
)

SET profiling = 1;
SELECT * FROM course WHERE nick = 'dbjs';
SELECT * FROM course WHERE name LIKE 'Webb%';
SELECT name, MATCH(name) AGAINST ('Program* web*' IN BOOLEAN MODE) AS score FROM course ORDER BY score DESC;
SHOW PROFILES;
SHOW PROFILE FOR QUERY 3;
