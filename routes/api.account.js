const db = require('../connect');

module.exports = function (server) {
    server.post('/api/register', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO account SET ?";
        db.query(Sql, [formData], function (err, data) {
            if (err) {
                res.send({
                    result: err.sqlMessage,
                    status: false
                })
            } else {
                formData.id = data.insertId;
                res.send({
                    result: formData,
                    status: true
                })
            }
        });
    })

    server.post('/api/login', function (req, res) {
        let Sql = "SELECT * FROM account WHERE email = ? AND password = ?";
        db.query(Sql, [req.body.email, req.body.password], function (err, data) {
            if (err) {
                return res.status(500).send(err);
            }
            if (data.length === 0) {
                return res.status(401).send({ error: 'Email hoặc mật khẩu không hợp lệ' });
            }
            let account = data[0];
            if (account.status === 'Bị khóa') {
                return res.status(403).send({ error: 'Tài khoản đã bị vô hiệu hóa' });
            } else if (account.status === 'Hoạt động') {
                return res.send({
                    result: account
                });
            }
            res.status(400).send({ error: 'Trạng thái tài khoản không hợp lệ' });
        });
    });
    
    server.post('/api/login', function (req, res) {
        let Sql = "SELECT * FROM account WHERE email = ? AND password = ? AND status = 'Hoạt động'";
        db.query(Sql, [req.body.email, req.body.password], function (err, data) {
            res.send({
                result: data.length ? data[0] : null
            })
        });
    })

    server.put('/api/account/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE account SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            res.send({
                result: data
            })
        });
    })

    server.get('/api/account/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM account WHERE id = ? ";
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
}