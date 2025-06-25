const express = require('express');
const app = express();
const indexRoutes = require("./routes/indexRoutes");
const port = 1337;

// bodyParser parses automatically in the routes so i use the datadirect
//in the routes without parsing it maniually.
const bodyParser = require('body-parser');
const urlencodedParser = bodyParser.urlencoded({ extended: false });
// extended: false: Uses the querystring library to parse URL-encoded data.
//This supports only simple key-value pairs.
// extended: true: Uses the qs library, allowing for rich objects and arrays to
//be encoded into the URL-encoded format.

// Set up body-parser middleware first.
app.use(urlencodedParser);

app.set("view engine", "ejs");


app.use(indexRoutes);
app.use("/eshop", indexRoutes);

app.use(express.static("public"));
app.listen(port, () => {
    console.log(`Server is listening on port: ${port}`);
});

// Summary:
// URL Encoding/Decoding: Used when transmitting form data or query parameters in URLs.
// JSON Stringify/Parse: Used for handling JSON data in request bodies or responses.
// Other Encodings: Depending on the content type, other encoding/decoding methods might be used
//(e.g., XML, multipart form data).

// So the encoding is built-in html quit similar to the restful API when we send request
//so there we stringify and encoding.so now we parse and decoding
