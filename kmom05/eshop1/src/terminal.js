/**
 * The main module.
 * @author mo bn
 */

"use strict";

const mysql = require('promise-mysql');
const config = require('../config/db/eshop.json');

async function showMenu() {
    console.table(`
        Choose from the menu..

        exit, quit     Exit the program
        menu, help     Show  menu
        about          Show group medlems name
        log            Show log
        product        Show products
        shelf          Show shelves
        inv            Show products in inventory
        invadd         Add antal of a product
        invdel         Drop antal of a product
        `);
}

async function showProducts() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_products();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}

async function insertProduct(data) {
    const db = await mysql.createConnection(config);
    let sql = `CALL insert_product(?, ?, ?);`;

    await db.query(sql, [data.fId, data.fName, data.fPrice]);
}


async function updateProduct(data) {
    const db = await mysql.createConnection(config);
    let sql = `UPDATE produkter SET namn = ?, pris = ? WHERE produkt_id = ?;`;

    await db.query(sql, [data.fName, data.fPrice, data.fId]);
}

async function getOne(produktId) {
    const db = await mysql.createConnection(config);
    let sql = `SELECT 
        produkt_id,
        namn,
        pris
    FROM produkter WHERE produkt_id = ?;`;
    const result = await db.query(sql, [produktId]);

    console.log(result);
    return result;
}

// cli.js

async function showLog(num) {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_log(?);`;
    const res = await db.query(sql, [num]);

    console.table(res[0]);
}

async function showProduct() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_product();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function showShelf() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_shelf();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function showInv() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_inv();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function showInvArg(arg) {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_inv_arg(?);`;
    const res = await db.query(sql, [arg]);

    console.table(res[0]);
}

async function addToInv(productid, shelf, antal) {
    const db = await mysql.createConnection(config);
    const sql = `CALL insert_to_inv(?, ?, ?);`;

    await db.query(sql, [productid, shelf, antal]);
    console.log('product has been added!');
}

async function dropInv(productid, shelf, antal) {
    const db = await mysql.createConnection(config);
    const sql = `CALL drop_inv(?, ?, ?);`;

    await db.query(sql, [productid, shelf, antal]);
    console.log('antalet has been dropped!');
}

async function exitProgram(exitcode=0) {
    console.log('Exiting program');
    process.exit(exitcode);
}

// i must reset the database and fill it up with all SP es i created.

module.exports = {
    showMenu,
    showProducts,
    insertProduct,
    updateProduct,
    getOne, showLog,
    exitProgram,
    showProduct,
    showShelf,
    showInv, showInvArg,
    addToInv,
    dropInv
};
