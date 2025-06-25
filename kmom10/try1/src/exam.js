/**
 * The functions module.
 * @author mo bn
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");

async function info() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_products();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}

module.exports = {
    "info": info
};
