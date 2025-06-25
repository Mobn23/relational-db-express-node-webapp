// The main router.
const express = require("express");
const router = express.Router();
const eshop = require("../src/eshop");

router.get("/index", (req, res) => {
    let pageTitle= "Main";
    let welcome = `
    Welcome to Our Coffee & Tea E-Shop!
    Thank you for visiting our e-shop. We specialize in providing high-quality coffee and tea
    products sourced from around the world. Whether you're a coffee enthusiast or a tea lover,
    we have a wide selection of premium blends and single-origin varieties to choose from.
    Explore our collection of freshly roasted coffee beans, aromatic loose-leaf teas,
    and convenient tea bags. Start your day with the perfect cup of coffee or tea!
    Feel free to browse our catalog and contact us if you have any questions or special requests.
    We're here to help you discover the perfect brew for every occasion.
    `;

    res.render("eshop/index.ejs", {
        pageTitle: pageTitle,
        welcome: welcome
    });
});

router.get("/", (req, res) => {
    let pageTitle= "Main";
    let welcome = `
    Welcome to Our Coffee & Tea E-Shop!
    Thank you for visiting our e-shop. We specialize in providing high-quality coffee and tea
    products sourced from around the world. Whether you're a coffee enthusiast or a tea lover,
    we have a wide selection of premium blends and single-origin varieties to choose from.
    Explore our collection of freshly roasted coffee beans, aromatic loose-leaf teas,
    and convenient tea bags. Start your day with the perfect cup of coffee or tea!
    Feel free to browse our catalog and contact us if you have any questions or special requests.
    We're here to help you discover the perfect brew for every occasion.
    `;

    res.render("eshop/index.ejs", {
        pageTitle: pageTitle,
        welcome: welcome
    });
});

router.get("/about", (req, res) => {
    let pageTitle= "About";
    let ourGroup = `mobn23, sahb23`;

    res.render("eshop/about.ejs", {
        pageTitle: pageTitle,
        ourGroup: ourGroup
    });
});

router.get("/category", async (req, res) => {
    let pageTitle= "Category";
    let categories = await eshop.categories();

    // console.log(categories);
    res.render("eshop/category.ejs", {
        pageTitle: pageTitle,
        categories: categories
    });
});

router.get("/product", async (req, res) => {
    let pageTitle= "Product";
    let products = await eshop.products();

    res.render("eshop/product.ejs", {
        pageTitle: pageTitle,
        products: products
    });
});

router.get("/create", async (req, res) => {
    let pageTitle= "Create";

    res.render("eshop/create.ejs", {
        pageTitle: pageTitle
    });
});

router.post("/create", async (req, res) => {
    let pageTitle= "Create";
    let insertProduct = await eshop.insertProduct(req.body);
    let products = await eshop.products();

    res.render("eshop/product.ejs", {
        pageTitle: pageTitle,
        insertProduct: insertProduct,
        products: products
    });
});

router.get("/update/:name", async (req, res) => {
    let pageTitle= "Update";
    let product = await eshop.getOne(req.params.name);

    // console.log("product:", product);
    res.render("eshop/update.ejs", {
        pageTitle: pageTitle,
        product: product
    });
});

// res.locals is an object that contains response local variables scoped to the request.

router.post("/product", async (req, res) => {
    try {
        //console.log("Data received in update route:", req.body)
        let pageTitle= "Update";

        await eshop.updateProduct(req.body);
        let product = await eshop.getOne(req.body.p_name);
        let products = await eshop.products();
        //console.log(res[0])

        res.render("eshop/product.ejs", {
            pageTitle: pageTitle,
            product: product,
            products: products
        });
    } catch (error) {
        console.error("Error updating product:", error);
        res.status(500).json({ message: "Failed to update product" });
    }
});

router.get("/delete/:p_name", async (req, res) => {
    let pageTitle= "Delete";
    let product = await eshop.getOne(req.params.p_name);

    // console.log("product:", req.params.p_id);
    res.render("eshop/delete.ejs", {
        pageTitle: pageTitle,
        product: product
    });
});

router.post("/delete", async (req, res) => {
    await eshop.deleteProduct(req.body.p_name);
    res.redirect("/product");
});

router.get("/customer", async (req, res) => {
    // console.log("route accessed");
    let pageTitle= "customer";
    let customers = await eshop.customer();

    // console.log("customers", customers);
    res.render("eshop/customer.ejs", {
        pageTitle: pageTitle,
        customers: customers
    });
});

router.get("/initiate-creating-order/:kund_id/:namn", async (req, res) => {
    let pageTitle= "Create order";
    const costumerId = req.params.kund_id;
    const costumerName = req.params.namn;

    let allProductsData = await eshop.productsToSelect();

    // console.log("allProductsData:", allProductsData);
    res.render("eshop/pick-products.ejs", {
        pageTitle: pageTitle,
        allProductsData: allProductsData,
        costumerId: costumerId,
        costumerName: costumerName
    });
});

router.post("/add-product-to-order/:kund_id/:produkt_id", async (req, res) => {
    try {
        const customerId = req.params.kund_id;
        const productId = req.params.produkt_id;
        const quantity = req.body.select_quantity;
        const customerName = req.body.customer_name;

        await eshop.manageOrder(customerId, productId, quantity, customerName);

        const orderData = await eshop.displayOrders();

        const pageTitle = "Create Order";
        const allProductsData = await eshop.products();

        // console.log("customerId, productId, quantity, customerName: ",
        //     customerId, productId, quantity, customerName);
        console.log("orderData: ", orderData);
        res.render("eshop/orders-before-finalizing.ejs", {
            pageTitle: pageTitle,
            allProductsData: allProductsData,
            customerId: customerId,
            customerName: customerName,
            orderData: orderData
        });
    } catch (error) {
        console.error("Error processing order:", error);
        res.status(500).json({
            message: "Failed to process order",
            error: error.message
        });
    }
});


router.get("/finalize-creating-order/:order_id", async (req, res) => {
    let pageTitle = "Order Finalized";
    const orderId = req.params.order_id;

    try {
        await eshop.finalizeOrder(orderId);
        const orderData = await eshop.displayOrders();

        res.render("eshop/orders-finalized.ejs", {
            pageTitle: pageTitle,
            orderData: orderData,
            message: "Order has been finalized successfully!"
        });
    } catch (error) {
        console.error("Error finalizing order:", error);
        res.status(500).json({ message: "Failed to finalize order" });
    }
});

router.get("/order", async (req, res) => {
    let pageTitle= "Orders";

    const orderData = await eshop.displayOrdersWithoutRows();

    console.log("orders", orderData);
    res.render("eshop/display-orders-general-overview.ejs", {
        pageTitle: pageTitle,
        orderData: orderData,
        message: "Already created orders!"
    });
});

router.get("/order-rows/:order_id", async (req, res) => {
    let pageTitle= "Orders";
    const orderId = req.params.order_id;
    const orderRows = await eshop.displayOrderRowsByOrderId(orderId);

    console.log("orders", orderRows);
    res.render("eshop/orders-finalized.ejs", {
        pageTitle: pageTitle,
        orderData: orderRows,
        message: "Already created orders!"
    });
});

module.exports = router;
