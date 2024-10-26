const db = require('../connect');
 
module.exports = function (server) {
    server.get('/api/product', function (req, res) {
        let key = req.query.key;
        let SQL = "SELECT p.*, c.name AS nameC FROM product p JOIN category c ON c.id=p.category_id WHERE status = 'Còn hàng'";
        let params = [];
        if (key) {
            SQL += " AND p.name LIKE ?";
            params.push(`%${key}%`);
        }
        db.query(SQL, params, function (err, data) {
            if (err) {
                res.status(500).send(err);
                return;
            }
            res.send({
                result: data
            });
        });
    });

    server.get('/api/product/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT p.*, c.name AS nameC FROM product p JOIN category c ON c.id=p.category_id WHERE p.id = ? Order By p.name ASC";
        db.query(Sql, [id], function (err, data) {
            res.send({
                result: data.length ? data[0] : null
            })
        });
    })

    server.post('/api/product', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO product SET ?";
        db.query(Sql, [formData], function (err, data) {
            res.send({
                result: data
            })
        });
    })

    server.put('/api/product/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE product SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            res.send({
                result: data
            })
        });
    })

    server.delete('/api/product/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM product WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            res.send({
                result: data
            })
        });
    })
}