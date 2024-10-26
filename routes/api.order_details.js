const db = require('../connect');

module.exports = function (server) {
    server.get('/api/order-details', function (req, res) {
        db.query("SELECT * FROM order_details", function (err, data) {
            res.send({ result: data });
        });
    });

    server.get('/api/order_details/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM order_details WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            let cat = null;
            if (data.length > 0) {
                cat = data[0];
            }
            res.send({
                result: cat
            })
        });
    })

    server.get('/api/order-details-by-order/:order_id', function (req, res) {
        let order_id = req.params.order_id;
        let Sql = "SELECT oi.*, p.name as product_name, p.image as product_image, p.sale_price as product_sale_price, p.price as product_price FROM order_details oi JOIN product p ON oi.product_id = p.id WHERE oi.order_id = ?";
        db.query(Sql, [order_id], function (err, data) {
            if (err) {
                res.status(500).send({ error: 'Failed to fetch order details' });
            } else {
                res.send({
                    result: data
                });
            }
        });
    });

    server.post('/api/order-details', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO order_details SET ?";
        db.query(Sql, [formData], function (err, data) {
            formData.id = data.insertId;
            res.send({ result: formData });
        });
    });

    server.put('/api/order-details/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE order_details SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            formData.id = id;
            res.send({ result: formData, message: 'Order item updated successfully' });
        });
    });

    server.delete('/api/order-details/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM order_details WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({ result: data });
        });
    });
}