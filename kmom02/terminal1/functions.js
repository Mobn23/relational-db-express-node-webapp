/**
 * This module will contain the functions and database connections for between.js and search.js.
 * @author mo bn
 */

"use strict";

const mysql= require('promise-mysql');
const config = require('./config.json');

async function performQueryWithMinMaxValues(minValue, maxValue) {
    const db = await mysql.createConnection(config);

    try {
        let sql = `
            SELECT
                akronym,
                fornamn,
                efternamn,
                avdelning,
                lon,
                kompetens,
                DATE_FORMAT(fodd, '%Y-%m-%d') AS fodd
            FROM larare
            WHERE lon BETWEEN ? AND ? OR
                  kompetens BETWEEN ? AND ?
            ORDER BY akronym;
        `;
        let res = await db.query(sql, [minValue, maxValue, minValue, maxValue]);

        console.table(res);
    } catch (error) {
        console.error('Error executing query:', error);
    } finally {
        db.end();
    }
}

async function search(searchString) {
    const db = await mysql.createConnection(config);

    try {
        let sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens
        FROM larare
        WHERE akronym LIKE ? OR
                fornamn LIKE ? OR
                efternamn LIKE ? OR
                avdelning LIKE ? OR
                kompetens LIKE ?
        ORDER BY akronym;
        `;
        let res = await db.query(sql, Array(5).fill(`%${searchString}%`));

        console.table(res);
    } catch (error) {
        console.error('Error executing query:', error);
    } finally {
        db.end();
    }
}

module.exports = { performQueryWithMinMaxValues, search };
