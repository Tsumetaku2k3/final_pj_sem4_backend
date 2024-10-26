const db = require('../connect');

module.exports = function (server) {
    server.get('/order', function (req, res) {
        let name = req.query.id || '';
        let page = parseInt(req.query.page) || 1;
        let limit = 4;
        let offset = (page - 1) * limit;
        let countQuery = "SELECT COUNT(*) AS count FROM orders WHERE id LIKE ?";
        let dataQuery = "SELECT * FROM orders WHERE id LIKE ? LIMIT ? OFFSET ?";
        db.query(countQuery, [`%${name}%`], function (err, countResult) {
            if (err) return res.status(500).send(err);
            let totalCount = countResult[0].count;
            let totalPages = Math.ceil(totalCount / limit);
            db.query(dataQuery, [`%${name}%`, limit, offset], function (err, data) {
                if (err) return res.status(500).send(err);
                res.render('order', {
                    dbOrd: data,
                    currentPage: page,
                    totalPages: totalPages,
                    searchId: name
                });
            });
        });
    });

    server.get('/edit-order/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM orders WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            if (err) {
                return res.status(500).send(err);
            }
            let order = null;
            if (data.length > 0) {
                order = data[0];
            }
            res.render('edit-order', {
                dbOrd: order
            });
        });
    });
    server.post('/edit-order/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE orders SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (!err) {
                res.redirect('/order');
            }
        });
    });

    server.get('/order-details/:id', function (req, res) {
        let id = req.params.id;
        let sql = "SELECT d.*, p.name AS nameP, p.image, p.sale_price, o.* FROM order_details d JOIN product p ON p.id = d.product_id JOIN orders o ON o.id = d.order_id WHERE d.order_id = ?";
        db.query(sql, [id], function (err, data) {
            if (err) {
                return res.status(500).send(err);
            }
            res.render('order_details', {
                dbDetail: data
            });
        });
    });
};
