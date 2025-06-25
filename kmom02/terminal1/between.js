/**
 * Create a connection to the database and execute
 * a query without actually using the database.
 * query()(Brings data from database)
 * @author mo bn
 */


"use strict";


const readline = require('readline');
const functions = require('./functions');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question("Minimum value: ", async function (minValue) {
    rl.question("Maximum value: ", async function (maxValue) {
        await functions.performQueryWithMinMaxValues(minValue, maxValue);
        rl.close();
    });
});
