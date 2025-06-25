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
            case "visa":
                await terminal.show_products();
                break;
            default:
                terminal.show_menu();
                break;
        }
    });
}

main();
