/**
 * The functions module.
 * @author Mobn23
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");

async function categories() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_categories();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}

async function products() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_products();`;
    const res = await db.query(sql);

    console.log(res[0]);
    return res[0];
}

async function insertProduct(data) {
    const db = await mysql.createConnection(config);
    let sql = `CALL insert_product(?,?,?,?);`;
    const res = await db.query(sql, [data.p_id, data.p_name, data.p_price, data.p_description]);

    console.log(res[0]);
    return res[0];
}

async function updateProduct(data) {
    //console.log("Data received in updateProduct:", data)
    const db = await mysql.createConnection(config);
    let sql = `CALL update_product(?,?,?,?);`;
    const res = await db.query(sql, [data.p_id, data.p_name, data.p_price, data.p_description]);

    console.log(res);
    return res;
}

async function getOne(name) {
    const db = await mysql.createConnection(config);
    let sql = `CALL get_one(?);`;
    const res = await db.query(sql, [name]);

    console.log(res[0]);
    return res[0];
}

async function deleteProduct(pName) {
    //console.log("Deleting product with ID:", p_name);
    const db = await mysql.createConnection(config);
    let sql = `CALL delete_product(?);`;

    await db.query(sql, [pName]);
    //console.log("Product deleted successfully");
}

module.exports = {
    "categories": categories,
    "products": products,
    "insertProduct": insertProduct,
    "updateProduct": updateProduct,
    "getOne": getOne,
    "deleteProduct": deleteProduct
};
