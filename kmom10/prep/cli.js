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

    rl.on('close', terminal.exit_program);
    rl.on("line", async function (input) {
        input = input.trim();
        let parts = input.split(" ");

        switch (parts[0]) {
            case "quit":
            case "exit":
                await terminal.exit_program();
                break;
            case "menu":
            case "help":
                await terminal.show_menu();
                break;
            case "about":
                console.log('Sahb23');
                console.log('Mobn23');
                break;
            case "log":
                await terminal.show_log(parts[1]);
                break;
            case "product":
                await terminal.show_product();
                break;
            case "shelf":
                await terminal.show_shelf();
                break;
            case "inv":
                if (parts.length === 2) {
                    await terminal.show_inv_arg(parts[1]);
                } else {
                    await terminal.show_inv();
                }
                break;
            case "invadd":
                if (parts.length === 4) {
                    await terminal.add_to_inv(parts[1], parts[2], parts[3]);
                }
                break;
            case "invdel":
                if (parts.length === 4) {
                    await terminal.drop_inv(parts[1], parts[2], parts[3]);
                }
                break;
            default:
                terminal.show_menu();
                break;
        }
    });
}

main();
