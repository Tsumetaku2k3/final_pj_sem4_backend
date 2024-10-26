const db = require('../connect');

module.exports = function (server) {
    server.get('/api/orders-account/:id', function (req, res) {
        let id = req.params.id;
        db.query("SELECT * FROM orders WHERE account_id = ?", [id], function (err, data) {
            res.send({
                result: data
            })
        });
    });

    server.get('/api/orders', function (req, res) {
        let accountId = req.query.account_id;
        let sql;
        let params;
        if (accountId) {
            sql = "SELECT * FROM orders WHERE account_id = ?";
            params = [accountId];
        } else {
            sql = "SELECT * FROM orders";
            params = [];
        }
        db.query(sql, params, function (err, data) {
            if (err) {
                res.status(500).send({ error: err.message });
            } else {
                res.send({ result: data });
            }
        });
    });

    server.get('/api/orders/:id', function (req, res) {
        let id = req.params.id;
        db.query("SELECT * FROM orders WHERE id = ?", [id], function (err, data) {
            let order = null;
            if (data.length > 0) {
                order = data[0];
            }
            res.send({ result: order });
        });
    });

    server.post('/api/orders', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO orders SET ?";
        db.query(Sql, [formData], function (err, data) {
            formData.id = data.insertId;
            res.send({ result: formData });
        });
    });

    server.put('/api/orders/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE orders SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            formData.id = id;
            res.send({
                result: formData,
                message: 'Cập nhật dữ liệu thành công'
            })
        });
    });

    server.delete('/api/orders/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM orders WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({ result: data });
        });
    });
}