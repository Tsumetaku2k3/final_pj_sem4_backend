const db = require('../connect');
const upload = require('../moddleware/upload');

module.exports = function (server) {
    server.get('/product', function (req, res) {
        let name = req.query.name || '';
        let page = parseInt(req.query.page) || 1;
        let limit = 4;
        let offset = (page - 1) * limit;
        let countQuery = "SELECT COUNT(*) AS count FROM product WHERE name LIKE ?";
        let dataQuery = "SELECT p.*, c.name AS nameC FROM product p JOIN category c ON c.id=p.category_id WHERE p.name LIKE ? LIMIT ? OFFSET ?";
        db.query(countQuery, [`%${name}%`], function (err, countResult) {
            if (err) return res.status(500).send(err);
            let totalCount = countResult[0].count;
            let totalPages = Math.ceil(totalCount / limit);
            db.query(dataQuery, [`%${name}%`, limit, offset], function (err, data) {
                if (err) return res.status(500).send(err);
                res.render('product', {
                    dbPro: data,
                    currentPage: page,
                    totalPages: totalPages,
                    searchName: name
                });
            });
        });
    });

    server.get('/delete-product/:id', function (req, res) {
        let id = req.params.id;
        let Sql = "DELETE FROM product WHERE id = ?";
        db.query(Sql, [id], function (err, data) {
            if (!err) {
                res.redirect('/product');
            }
        });
    })

    server.get('/create-product', function (req, res) {
        let Sql = "SELECT * FROM category Order By name ASC";
        db.query(Sql, function (err, data) {
            res.render('create-product', {
                dbCat: data,
            })
        });
    })
    server.post('/create-product', upload, function (req, res) {
        let formData = req.body;
        if (req.file) {
            formData.image = req.file.filename;
        }
        let Sql = "INSERT INTO product SET ?";
        db.query(Sql, [formData], function (err, data) {
            if (err) {
                console.log(err);
            }
            else {
                res.redirect('/product');
            }
        });
    })

    server.get('/edit-product/:id', function (req, res) {
        let productId = req.params.id;
        let Sql = "SELECT * FROM product WHERE id = ? Order By name ASC";
        db.query(Sql, [productId], function (err, productData) {
            if (err) {
                console.log(err);
                res.redirect('/product');
            } else {
                let catSql = "SELECT * FROM category Order By name ASC";
                db.query(catSql, function (err, catData) {
                    if (err) {
                        console.log(err);
                        res.redirect('/product');
                    } else {
                        res.render('edit-product', {
                            dbPro: productData[0],
                            dbCat: catData,
                        });
                    }
                });
            }
        });
    });
    server.post('/edit-product/:id', upload, function (req, res) {
        let productId = req.params.id;
        let formData = req.body;
        if (req.file) {
            formData.image = req.file.filename;
        }
        let Sql = "UPDATE product SET ? WHERE id = ?";
        db.query(Sql, [formData, productId], function (err, data) {
            if (err) {
                console.log(err);
            } else {
                res.redirect('/product');
            }
        });
    });
}