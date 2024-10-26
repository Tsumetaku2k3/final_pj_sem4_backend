const mysql = require('mysql');
// cấu hình kết nối
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password:'',
    database: 'sem4'
});

// mở kết nối vớ cấu ình đã cung cấp
db.connect(function(err) {
    if (err) {
        throw new Error('Không thể kết nối CSDL sem4');
    }
});

module.exports = db;