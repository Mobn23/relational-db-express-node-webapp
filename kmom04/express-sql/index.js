const express= require("express");
const app = express();
const indexRoutes = require("./routes/indexRoutes");

const port = 1337;

app.set("view engine", "ejs");
app.use(express.static ("public"));
/** note 4 me: app.use(express.static ("public")) guides the framework express.js to public dir.
 *  So if i want to accsess data in (public) like styles or imgs
 *  so it doesnt need to iclude public in the URL in ejs templates.
 */
app.use(indexRoutes);
app.use("/bank", indexRoutes);

app.listen(port, () => {
    console.log(`Server is listening on port: ${port}`);
});
