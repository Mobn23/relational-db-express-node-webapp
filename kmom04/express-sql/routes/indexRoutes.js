const express = require("express");
const router = express.Router();
const bank = require("../src/bank");


router.get("/", (req, res) => {
    const pageTitle = "Home page";
    const welcomeMessage = "Hej till bankens hemsida.Hej till bankens hemsida.";

    res.render("pages/index.ejs", { pageTitle: pageTitle, welcomeMessage: welcomeMessage });
});

//the route that have "/" is the Root route.
router.get("/index", (req, res) => {
    const pageTitle = "Home page";
    const welcomeMessage = "Hej till bankens hemsida.Hej till bankens hemsida.";

    res.render("pages/index.ejs", { pageTitle: pageTitle, welcomeMessage: welcomeMessage });
});

router.get("/balance", async (req, res) => {
    const pageTitle = "balance page";
    const balance = await bank.balance();

    console.log(balance);
    res.render("pages/balance.ejs", { pageTitle: pageTitle, balance: balance});
});

router.get("/move-to-adam", async (req, res) => {
    try {
        const pageTitle = "Transfer page";
        const thankYouMessage = "Adam: Thanks for the money!";

        await bank.move(1.5, 2222, 1111);
        res.render("pages/move-to-adam.ejs", {
            pageTitle: pageTitle,
            thankYouMessage: thankYouMessage });
    } catch (error) {
        console.error("Error fetching balance:", error);
    }
});

module.exports = router;
