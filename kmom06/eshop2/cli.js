/**
 * The main module.
 * @author mo bn
 */

"use strict";

const readline = require("readline");
const terminal = require('./src/terminal.js');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main() {
    rl.setPrompt('Enter an input:  ');
    rl.prompt();

    rl.on('close', terminal.exitProgram);
    rl.on("line", async function (input) {
        input = input.trim();
        let parts = input.split(" ");

        switch (parts[0]) {
            case "quit":
            case "exit":
                await terminal.exitProgram();
                break;
            case "menu":
            case "help":
                await terminal.showMenu();
                break;
            case "about":
                console.log('Sahb23');
                console.log('Mobn23');
                break;
            case "log":
                await terminal.showLog(parts[1]);
                break;
            case "product":
                await terminal.showProduct();
                break;
            case "shelf":
                await terminal.showShelf();
                break;
            case "inv":
                if (parts.length === 2) {
                    await terminal.showInvArg(parts[1]);
                } else {
                    await terminal.showInv();
                }
                break;
            case "invadd":
                if (parts.length === 4) {
                    await terminal.addToInv(parts[1], parts[2], parts[3]);
                }
                break;
            case "invdel":
                if (parts.length === 4) {
                    await terminal.dropInv(parts[1], parts[2], parts[3]);
                }
                break;
            case "order":
                if (parts.length === 2) {
                    await terminal.showSpecificOrder(parts[1]);
                } else {
                    await terminal.showOrders();
                }
                break;
            case "picklist":
                if (parts.length === 2) {
                    await terminal.generatePlockList(parts[1]);
                }
                break;
            case "ship":
                if (parts.length === 2) {
                    await terminal.changeStatusToShiped(parts[1]);
                }
                break;
            default:
                terminal.showMenu();
                break;
        }
    });
}

main();
