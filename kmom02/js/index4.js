/**
 * A test program to show off async and await.
 *
 * @author Mobn23
 */
"use strict";

const fs = require("fs");
//const { config } = require("process");
const util = require("util");
const readFile = util.promisify(fs.readFile);

/**
 * The main function, needed to wrap async await that can not be used
 * on module level.
 *
 * @async
 * @returns void
 */
async function main() {
    const path = "file.txt";
    let data;

    console.info("1) Program is starting up!");

    data = await getFileContentPromise(path);
    console.info(data);

    console.info("3) End of the program!");
}
main();

/**
 * Return the content of the file, using a promosiified variant.
 *
 * @param {string}   The path to the file to read.
 *
 * @returns {string} The content of the file.
 */
async function getFileContentPromise(filename) {
    let data;

    data = await readFile(filename, "utf-8");
    return data;
}
