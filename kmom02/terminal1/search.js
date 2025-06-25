/**
 * Create a connection to the database and execute
 * a query without actually using the database.
 * query()(Brings data from database)
 * @author Mobn23
 */
"use strict";

const readline = require('readline');
const functions = require('./functions');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

(async function () {
    try {
        rl.question("Search: ", async function (searchString) {
            await functions.search(searchString);
            rl.close();
        });
    } catch (error) {
        console.error('Error connecting to the database:', error);
    }
})();
