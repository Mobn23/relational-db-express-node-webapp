/**
 * The functions module.
 * @author mo bn
 */

"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");

async function categories() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_categories_web_sp();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function products() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_products_web_sp();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function insertProduct(data) {
    const db = await mysql.createConnection(config);
    let sql = `CALL insert_product_web_sp(?,?,?,?);`;
    const res = await db.query(sql, [data.p_id, data.p_name, data.p_price, data.p_description]);

    // console.log(res[0]);
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

    // console.log(res[0]);
    return res[0];
}

async function deleteProduct(pName) {
    //console.log("Deleting product with ID:", p_name);
    const db = await mysql.createConnection(config);
    let sql = `CALL delete_product(?);`;

    await db.query(sql, [pName]);
    //console.log("Product deleted successfully");
}

async function customer() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_customers();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function insertOrder(costumerId, productId, quantity, costumerName) {
    const db = await mysql.createConnection(config);
    let sql = `CALL insert_order(?,?,?,?);`;
    const res = await db.query(sql, [costumerId, productId, quantity, costumerName]);

    // console.log(res[0]);
    return res[0];
}

async function productsToSelect() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_products_modify_order_status();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function manageOrder(customerId, productId, quantity, customerName) {
    const db = await mysql.createConnection(config);
    let sql = `CALL manage_order(?,?,?,?);`;
    const res = await db.query(sql, [ customerId, productId, quantity, customerName ]);

    console.log("manageOrder", res[0]);
    return res[0];
}

async function displayOrders() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_orders();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function finalizeOrder(orderId) {
    const db = await mysql.createConnection(config);
    let sql = `CALL update_order_status_to_ordered(?);`;
    const res = await db.query(sql, [ orderId ]);

    return res;
}

async function displayOrdersWithoutRows() {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_orders_web();`;
    const res = await db.query(sql);

    // console.log(res[0]);
    return res[0];
}

async function displayOrderRowsByOrderId(orderId) {
    const db = await mysql.createConnection(config);
    let sql = `CALL show_order_web_by_arg(?);`;
    const res = await db.query(sql, [ orderId ]);

    // console.log(res[0]);
    return res[0];
}

module.exports = {
    "categories": categories,
    "products": products,
    "insertProduct": insertProduct,
    "updateProduct": updateProduct,
    "getOne": getOne,
    "deleteProduct": deleteProduct,
    "customer": customer,
    "insertOrder": insertOrder,
    "productsToSelect": productsToSelect,
    "manageOrder": manageOrder,
    "displayOrders": displayOrders,
    "finalizeOrder": finalizeOrder,
    "displayOrdersWithoutRows": displayOrdersWithoutRows,
    "displayOrderRowsByOrderId": displayOrderRowsByOrderId
};
