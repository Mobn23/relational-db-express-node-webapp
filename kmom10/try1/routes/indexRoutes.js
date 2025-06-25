// The main router.
const express = require("express");
const router = express.Router();
const exam = require("../src/exam");

router.get("/", (req, res) => {
    let pageTitle= "Main";
    let welcome = `
    Welcome!
    `;

    res.render("exam/index.ejs", {
        pageTitle: pageTitle,
        welcome: welcome
    });
});

router.get("/index", (req, res) => {
    let pageTitle= "Main";
    let welcome = `
    Welcome!
    `;

    res.render("exam/index.ejs", {
        pageTitle: pageTitle,
        welcome: welcome
    });
});
router.get("/visa", async (req, res) => {
    let pageTitle= "Info";
    let info = await exam.info();

    console.log(info);
    res.render("exam/visa.ejs", {
        pageTitle: pageTitle,
        info: info
    });
});


module.exports = router;
