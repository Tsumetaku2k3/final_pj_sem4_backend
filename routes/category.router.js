const db = require('../connect');

module.exports = function (server) {
    server.get('/category', function (req, res) {
        let name = req.query.name || '';
        let page = parseInt(req.query.page) || 1;
        let limit = 4;
        let offset = (page - 1) * limit;
        let countQuery = "SELECT COUNT(*) AS count FROM category WHERE name LIKE ?";
        let dataQuery = "SELECT * FROM category WHERE name LIKE ? LIMIT ? OFFSET ?";
        db.query(countQuery, [`%${name}%`], function (err, countResult) {
            if (err) return res.status(500).send(err);
            let totalCount = countResult[0].count;
            let totalPages = Math.ceil(totalCount / limit);
            db.query(dataQuery, [`%${name}%`, limit, offset], function (err, data) {
                if (err) return res.status(500).send(err);
                res.render('category', {
                    dbCat: data,
                    currentPage: page,
                    totalPages: totalPages,
                    searchName: name
                });
            });
        });
    });

    server.get('/delete-category/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM category WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            if (!err) {
                res.redirect('/category');
            }
        });
    })

    server.get('/create-category', function (req, res) {
        res.render('create-category');
    })
    server.post('/create-category', function (req, res) {
        let formData = req.body;
        let Sql = "INSERT INTO category SET ?";
        db.query(Sql, [formData], function (err, data) {
            if (!err) {
                res.redirect('/category');
            }
        });
    })

    server.get('/edit-category/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "SELECT * FROM category WHERE id = ? Order By name ASC";
        db.query(Sql, [id], function (err, data) {
            let cat = null;
            if (data.length > 0) {
                cat = data[0];
            }
            res.render('edit-category', {
                cat: cat
            });
        });
    })
    server.post('/edit-category/:id', function (req, res) {
        let formData = req.body;
        let id = req.params.id;
        let Sql = "UPDATE category SET ? WHERE id = ?";
        db.query(Sql, [formData, id], function (err, data) {
            if (!err) {
                res.redirect('/category');
            }
        });
    })
}