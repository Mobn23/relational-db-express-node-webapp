/**
 * The main module.
 * @author mo bn
 */

"use strict";

const mysql = require('promise-mysql');
const config = require('../config/db/eshop.json');

async function show_menu() {
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

async function show_categories() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_categories();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}


async function show_products() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_products();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}

async function insert_product(data) {
    const db = await mysql.createConnection(config);
    let sql = `CALL insert_product(?, ?, ?);`;

    await db.query(sql, [data.f_id, data.f_name, data.f_price]);
}


async function update_product(data) {
    const db = await mysql.createConnection(config);
    let sql = `UPDATE produkter SET namn = ?, pris = ? WHERE produkt_id = ?;`;

    await db.query(sql, [data.f_name, data.f_price, data.f_id]);
}

async function get_one(produkt_id) {
    const db = await mysql.createConnection(config);
    let sql = `SELECT 
        produkt_id,
        namn,
        pris
    FROM produkter WHERE produkt_id = ?;`;
    const result = await db.query(sql, [produkt_id]);

    console.log(result);
    return result;
}

// cli.js

async function show_log(num) {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_log(?);`;
    const res = await db.query(sql, [num]);

    console.table(res[0]);
}

async function show_product() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_product();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function show_shelf() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_shelf();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function show_inv() {
    const db = await mysql.createConnection(config);
    const sql = `CALL show_inv();`;
    const res = await db.query(sql);

    console.table(res[0]);
}

async function show_inv_arg(arg) {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_inv_arg(?);`;
    const res = await db.query(sql, [arg]);

    console.table(res[0]);
}

async function add_to_inv(productid, shelf, antal) {
    const db = await mysql.createConnection(config);
    const sql = `CALL insert_to_inv(?, ?, ?);`;
    const res = await db.query(sql, [productid, shelf, antal]);

    console.log('product has been added!');
}

async function drop_inv(productid, shelf, antal) {
    const db = await mysql.createConnection(config);
    const sql = `CALL drop_inv(?, ?, ?);`;
    const res = await db.query(sql, [productid, shelf, antal]);

    console.log('antalet has been dropped!');
}

async function exit_program(exitcode=0) {
    console.log('Exiting program');
    process.exit(exitcode);
}

// i must reset the database and fill it up with all SP es i created.

module.exports = {
    show_menu,
    show_categories,
    show_products,
    insert_product,
    update_product,
    get_one, show_log,
    exit_program,
    show_product,
    show_shelf,
    show_inv, show_inv_arg,
    add_to_inv,
    drop_inv
};
