/**
 * A collection of useful functions.
 *
 * @author Mobn23
 */
"use strict";

/**
 * Return the range between a and b as a string, separated by commas.
 *
 * @param {integer} a   Start value.
 * @param {integer} b   Last included value.
 * @param {string}  sep Separator, defaults to ", ".
 *
 * @returns {string} A comma separated list of values.
 */
function stringRange(a, b, sep = ", ") {
    let res = "";
    let i = a;

    while (i < b) {
        res += i + sep;
        i++;
    }

    res = res.substring(0, res.length - sep.length);
    return res;
}

console.log(stringRange(1, 10));
console.log(stringRange(1, 10, "-"));
