/**
 * The main module.
 * @author mo bn
 */

"use strict";

const readline= require("readline");
const bank = require('./src/bank');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main() {
    rl.setPrompt('Enter a choice: ');
    rl.prompt();

    rl.on('close', bank.exitProgram);
    rl.on("line", async function(input) {
        input = input.trim();
        let parts = input.split(" ");

        switch (parts[0]) {
            case "quit":
            case "exit":
                await bank.exitProgram();
                break;
            case "menu":
            case "help":
                await bank.showMenu();
                break;
            case "move":
                if (parts.length === 1) {
                    await bank.move( 1.5, 1111, 2222);
                } else if (parts.length === 4) {
                    await bank.move(parts[1], parts[2], parts[3]);
                } else {
                    console.log("Invalid number of arguments for move command.");
                }
                break;
            case "balance":
                await bank.balance();
                break;
            default:
                bank.showMenu();
                break;
        }
    });
}

main();
