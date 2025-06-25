/**
 * The main module.
 * @author mo bn
 */

"use strict";

const mysql = require('promise-mysql');
const config = require('../config/db/exam.json');

async function show_menu() {
    console.table(`
        Choose from the menu..

        exit, quit     Exit the program
        menu, help     Show  menu
        visa        Show products
        `);
}

async function show_products() {
    const db = await mysql.createConnection(config);
    const sql = `
    CALL show_products();`;
    const res = await db.query(sql);

    console.table(res[0]);
    return res[0];
}

async function exit_program(exitcode=0) {
    console.log('Exiting program');
    process.exit(exitcode);
}

module.exports = {
    show_menu,
    exit_program,
    show_products
};
