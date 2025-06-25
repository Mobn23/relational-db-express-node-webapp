--
-- Show the books and how they are categorized.
--
SELECT 
    b.*,
    GROUP_CONCAT(c.name) AS 'Category' 
FROM book AS b
    LEFT OUTER JOIN book2category AS b2c
        ON b.id = b2c.book_id
    LEFT OUTER JOIN category AS c
        ON b2c.category_id = c.id
GROUP BY
    b.id
;

--
-- Show the books an author has written.
--
SELECT 
    a.*,
    GROUP_CONCAT(b.id) AS 'Books' 
FROM author AS a
    LEFT OUTER JOIN book2author AS b2a
        ON a.id = b2a.author_id
    LEFT OUTER JOIN book AS b
        ON b2a.book_id = b.id
GROUP BY
    a.id
;

--
-- Show the books a publisher has published.
--
SELECT 
    p.*,
    GROUP_CONCAT(b.id) AS 'Books' 
FROM publisher AS p
    LEFT OUTER JOIN book AS b
        ON p.id = b.publisher_id
GROUP BY
    p.id
;
