/**
 * To verify that mysql is installed and is working.
 * Create a connection to the database and execute
 * a query without actually using the database.
 */
"use strict";

const mysql = require("promise-mysql");

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    let sql;
    let res;
    const db = await mysql.createConnection({
        "host":     "localhost",
        "user":     "dbadm",
        "password": "P@ssw0rd",
        "database": "skolan"
    });

    sql = "SELECT 1+1 AS Sum";
    res = await db.query(sql);

    console.info(res);

    db.end();
})();
/*here we are trying to detect the fail in order to see how the fails look like*/
