/**
 * The functions module.
 * @author mo bn
 */

"use strict";

const mysql = require('promise-mysql');
const config = require('../config/db/bank.json');


async function exitProgram(exitcode=0) {
    console.log('Exiting program');
    process.exit(exitcode);
}

async function showMenu() {
    console.table(`
        Choose from the menu..

        exit, quit   |   Exits the program..
        menu, help   |   Shows this menu..
        move         |   transfer 1.5 from Adam to Eva..
        move <amount> <from> <to> | transfer money..
        balance | to see the accounts balance & info..
        `);
}

async function move(amount, from, to) {
    const sql = `
    START TRANSACTION;

    UPDATE account
    SET
        balance = balance + ?
    WHERE
        id = ?;

    UPDATE account
    SET
        balance = balance - ?
    WHERE
        id = ?;

    COMMIT;
    `;
    const db = await mysql.createConnection(config);

    await db.query(sql, [amount, to, amount, from]);
    await db.end();
}

async function balance() {
    const sql = `
    SELECT * FROM account;
    `;
    const db = await mysql.createConnection(config);
    const res = await db.query(sql);

    console.table(res);
    await db.end();
    return res;
}

module.exports = { exitProgram, showMenu, move, balance};
