/**
 * Create a connection to the database and execute
 * a query without actually using the database.
 * query()(Brings data from database)
 * @author mo bn
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

/**
 * Show teachers and their departments.
 */
(async function() {
    try {
        const db = await mysql.createConnection(config);
        let sql;

        sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                avdelning,
                lon,
                kompetens,
                DATE_FORMAT(fodd, '%Y-%m-%d') AS fodd
            FROM larare
            ORDER BY akronym;
        `;

        let res = await db.query(sql);

        console.table(res);

        db.end();
    } catch (error) {
        console.error('Error executing query:', error);
    }
}) ();
