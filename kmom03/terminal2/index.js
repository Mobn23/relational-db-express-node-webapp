/**
 * The main module.
 * @author mo bn
 */

"use strict";

const readline= require("readline");
const functions = require('./src/functions');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main() {
    rl.setPrompt('Enter a choice: ');
    rl.prompt();

    rl.on('close', functions.exitProgram);
    rl.on("line", async function(input) {
        input = input.trim();
        let parts = input.split(" ");

        switch (parts[0]) {
            case "quit":
            case "exit":
                await functions.exitProgram();
                break;
            case "menu":
            case "help":
                await functions.showMenu();
                break;
            case "larare":
                await functions.teacherInfo();
                break;
            case "kompetens":
                await functions.competence();
                break;
            case "lon":
                await functions.salaryChanges();
                break;
            case "sok":
                await functions.searchTeacherInfo(parts[1]);
                break;
            case "nylon":
                await functions.UpdateTeacherSalary(parts[1], parts[2]);
                break;
            default:
                functions.showMenu();
                break;
        }
    });
}

main();
