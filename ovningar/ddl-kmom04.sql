--
-- Library ddl
--

--
-- Step 1, tables with columns
--
book
(
    id,
    isbn,
    title,
    publish_year,
    publisher_id
)

publisher
(
    id,
    name,
    country
)

category
(
    id,
    name,
    description
)

book2category
(
    bood_id,
    category_id,
)

author
(
    id,
    name,
    birth_date,
    birth_country
)

book2author
(
    book_id,
    author_id
)



--
-- Step 2, add datatypes
--
CREATE TABLE book
(
    id INTEGER,
    isbn VARCHAR(17),
    title VARCHAR(120),
    publish_year INTEGER,
    publisher_id INTEGER
);

CREATE TABLE publisher
(
    id INTEGER,
    name VARCHAR(120),
    country VARCHAR(120)
);

CREATE TABLE category
(
    id INTEGER,
    name VARCHAR(40),
    description VARCHAR(120)
);

CREATE TABLE book2category
(
    bood_id INTEGER,
    category_id INTEGER,
);

CREATE TABLE author
(
    id INTEGER,
    name VARCHAR(80),
    birth_date DATE,
    birth_country VARCHAR(120)
);

CREATE TABLE book2author
(
    book_id INTEGER,
    author_id INTEGER
);



--
-- Step 3, add not null constraints and default values
--
DROP TABLE book;
CREATE TABLE book
(
    id INTEGER NOT NULL,
    isbn VARCHAR(17),
    title VARCHAR(120),
    publish_year INTEGER DEFAULT YEAR(NOW()),
    publisher_id INTEGER
);

CREATE TABLE publisher
(
    id INTEGER NOT NULL,
    name VARCHAR(120) NOT NULL,
    country VARCHAR(120)
);

CREATE TABLE category
(
    id INTEGER NOT NULL,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(120)
);

CREATE TABLE book2category
(
    bood_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
);

CREATE TABLE author
(
    id INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,
    birth_date DATE,
    birth_country VARCHAR(120)
);

CREATE TABLE book2author
(
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL
);



--
-- Step 4, add primary, foreign keys and any unique constraints
--
DROP TABLE book;
CREATE TABLE book
(
    id INTEGER NOT NULL,
    isbn VARCHAR(17),
    title VARCHAR(120),
    publish_year INTEGER DEFAULT YEAR(NOW()),
    publisher_id INTEGER,

    PRIMARY KEY (id),
    FOREIGN KEY (publisher_id) REFERENCES publisher (id)
);

CREATE TABLE publisher
(
    id INTEGER NOT NULL,
    name VARCHAR(120) NOT NULL,
    country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE category
(
    id INTEGER NOT NULL,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(120),

    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE book2category
(
    book_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY book_id REFERENCES book (id),
    FOREIGN KEY category_id REFERENCES category (id)
);

CREATE TABLE author
(
    id INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,
    birth_date DATE,
    birth_country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE book2author
(
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY book_id REFERENCES book (id),
    FOREIGN KEY author_id REFERENCES author (id)
);



--
-- Step 5, put everything in order and add DROP
--
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS book2author;
DROP TABLE IF EXISTS book2category;

CREATE TABLE author
(
    id INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,
    birth_date DATE,
    birth_country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE publisher
(
    id INTEGER NOT NULL,
    name VARCHAR(120) NOT NULL,
    country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE category
(
    id INTEGER NOT NULL,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(120),

    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE book
(
    id INTEGER AUTO_INCREMENT NOT NULL,
    isbn VARCHAR(17),
    title VARCHAR(120),
    publish_year INTEGER DEFAULT YEAR(NOW()),
    publisher_id INTEGER,

    PRIMARY KEY (id),
    FOREIGN KEY (publisher_id) REFERENCES publisher (id)
);

CREATE TABLE book2category
(
    book_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES book (id),
    FOREIGN KEY (category_id) REFERENCES category (id)
);

CREATE TABLE book2author
(
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book (id),
    FOREIGN KEY (author_id) REFERENCES author (id)
);

--
-- Now recreating all tables again with the arragement and we set the correct ordering (to avoid Errors).
--
--
-- Library ddl
--

--
-- Create database.
--
DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;



--
-- DROP all tables
--
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS book2author;
DROP TABLE IF EXISTS book2category;



--
-- CREATE all tables
--
CREATE TABLE author
(
    id INTEGER NOT NULL,
    name VARCHAR(80) NOT NULL,
    birth_date DATE,
    birth_country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE publisher
(
    id INTEGER NOT NULL,
    name VARCHAR(120) NOT NULL,
    country VARCHAR(120),

    PRIMARY KEY (id)
);

CREATE TABLE category
(
    id INTEGER NOT NULL,
    name VARCHAR(40) NOT NULL,
    description VARCHAR(120),

    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE book
(
    id INTEGER AUTO_INCREMENT NOT NULL,
    isbn VARCHAR(17),
    title VARCHAR(120),
    publish_year INTEGER DEFAULT YEAR(NOW()),
    publisher_id INTEGER,

    PRIMARY KEY (id),
    FOREIGN KEY (publisher_id) REFERENCES publisher (id)
);

CREATE TABLE book2category
(
    book_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES book (id),
    FOREIGN KEY (category_id) REFERENCES category (id)
);

CREATE TABLE book2author
(
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,

    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book (id),
    FOREIGN KEY (author_id) REFERENCES author (id)
);
