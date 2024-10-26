const db = require('../connect');
const upload = require('../moddleware/upload');

module.exports = function (server) {
    server.get('/account', function (req, res) {
        let name = req.query.name || '';
        let page = parseInt(req.query.page) || 1;
        let limit = 3;
        let offset = (page - 1) * limit;
        let countQuery = "SELECT COUNT(*) AS count FROM account WHERE name LIKE ?";
        let dataQuery = "SELECT * FROM account WHERE name LIKE ? LIMIT ? OFFSET ?";
        db.query(countQuery, [`%${name}%`], function (err, countResult) {
            if (err) return res.status(500).send(err);
            let totalCount = countResult[0].count;
            let totalPages = Math.ceil(totalCount / limit);
            db.query(dataQuery, [`%${name}%`, limit, offset], function (err, data) {
                if (err) return res.status(500).send(err);
                res.render('account', {
                    dbAcc: data,
                    currentPage: page,
                    totalPages: totalPages,
                    searchName: name
                });
            });
        });
    })

    server.get('/edit-account/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM account WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            let account = null;
            if (data.length > 0) {
                account = data[0];
            }
            res.render('edit-account', {
                dbAcc: account
            });
        });

    })
    server.post('/edit-account/:id', upload, function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        if (req.file) {
            formData.avatar = req.file.filename;
        }
        let Sql = "UPDATE account SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (!err) {
                res.redirect('/account');
            }
        });
    })
}