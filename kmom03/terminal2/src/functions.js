/**
 * The functions module.
 * @author Mobn23
 */

"use strict";

const mysql = require('promise-mysql');
const config = require('../config.json');

async function exitProgram(exitcode=0) {
    console.log('Exiting program');
    process.exit(exitcode);
}

async function showMenu() {
    console.log(`
        Choose from the menu..

        exit, quit      Exits the program..
        menu, help      Shows this menu..
        larare          Shows all about teacher(larare)..
        kompetens       Shows competence changes under the last salary audit..
        lon             Shows salary changes under the last salary audit..
        sok <string>    Searches through all teacher's information & displays all match the search..
        nylon <akronym> <lon>   Updates the teacher's salary (Takes 2 args)..
        `);
}

async function teacherInfo() {
    const db = await mysql.createConnection(config);

    try {
        const sql = `
        SELECT
            akronym, fornamn, efternamn,
            avdelning, lon, kompetens, kon, alder,
            DATE_FORMAT(fodd, '%Y-%m-%d') AS fodd
        FROM v_larare;
        `;

        let res = await db.query(sql);

        console.table(res);
    } catch (error) {
        console.error('Error executing query:', error);
    } finally {
        db.end();
    }
}

async function competence() {
    const db = await mysql.createConnection(config);
    const sql =`
    SELECT
        p.akronym,
        p.fornamn,
        p.efternamn,
        p.kompetens AS kompetens_fore,
        l.kompetens AS kompetens_efter,
        (l.kompetens - p.kompetens) AS kompetens_forandring
    FROM
        larare_pre p
    JOIN
        larare l ON p.akronym = l.akronym
    ORDER BY
        p.akronym;
    `;

    let res =  await db.query(sql);

    console.table(res);
}

async function salaryChanges() {
    const db = await mysql.createConnection(config);
    const sql =`
    SELECT
        l.akronym,
        l.fornamn,
        l.efternamn,
        (l.lon - p.lon) AS lon_forandring
    FROM
        larare l
    JOIN
        larare_pre p
            ON p.akronym = l.akronym
    ORDER BY
        p.akronym;
    `;

    let res = await db.query(sql);

    console.table(res);
}

async function searchTeacherInfo(searchInput) {
    const db = await mysql.createConnection(config);
    const sql =`
    SELECT *
    FROM
        larare l
    WHERE
        akronym LIKE ? OR
        fornamn LIKE ? OR
        efternamn LIKE ? OR
        avdelning LIKE ? OR
        lon LIKE ? OR
        kompetens LIKE ? OR
        kon LIKE ? OR
        fodd LIKE ?
    `;

    const searchValues = Array(8).fill(`%${searchInput}%`);
    let res = await db.query(sql, searchValues);

    console.table(res);
}

async function UpdateTeacherSalary(acronym, newSalary) {
    const db = await mysql.createConnection(config);
    const sql =`
    UPDATE
        larare
    SET lon = ?
    WHERE
        akronym = ?
    ;
    `;

    try {
        await db.query(sql, [newSalary, acronym]);
        console.log(` ${acronym}'s new salary is ${newSalary}`);
    } catch (error) {
        console.error('Error updating teacher salary:', error);
    }
}

module.exports = {
    "exitProgram": exitProgram,
    "showMenu": showMenu,
    "teacherInfo": teacherInfo,
    "competence": competence,
    "salaryChanges": salaryChanges,
    "searchTeacherInfo": searchTeacherInfo,
    "UpdateTeacherSalary": UpdateTeacherSalary
};
