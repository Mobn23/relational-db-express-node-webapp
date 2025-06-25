const express = require('express');
const app = express();
const indexRoutes = require("./routes/indexRoutes");
const port = 1337;
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });

// Set up body-parser middleware first.
app.use(urlencodedParser);

app.set("view engine", "ejs");



app.use(indexRoutes);
app.use("/eshop", indexRoutes);

app.use(express.static("public"));
app.listen(port, () => {
    console.log(`Server is listening on port: ${port}`);
});
