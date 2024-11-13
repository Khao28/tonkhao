// ในโมเดล User
const db = require('../config/db'); // สมมุติว่าเชื่อมต่อฐานข้อมูลไว้แล้ว

// ค้นหาผู้ใช้ตาม username
exports.findByUsername = (username) => {
    return new Promise((resolve, reject) => {
        const query = 'SELECT * FROM users WHERE username = ?';
        db.query(query, [username], (err, result) => {
            if (err) reject(err);
            resolve(result[0]);  // คืนค่าผู้ใช้แรกที่พบ
        });
    });
};

// ค้นหาผู้ใช้ตาม email
exports.findByEmail = (email) => {
    return new Promise((resolve, reject) => {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], (err, result) => {
            if (err) reject(err);
            resolve(result[0]);  // คืนค่าผู้ใช้แรกที่พบ
        });
    });
};

// ฟังก์ชันสร้างผู้ใช้ใหม่
exports.create = (userData) => {
    return new Promise((resolve, reject) => {
        const query = 'INSERT INTO users (username, password, email) VALUES (?, ?, ?)';
        db.query(query, [userData.username, userData.password, userData.email], (err, result) => {
            if (err) reject(err);
            resolve(result);
        });
    });
};



// ฟังก์ชันดึงข้อมูลผู้ใช้ทั้งหมด
exports.findAll = () => {
    return new Promise((resolve, reject) => {
        const query = 'SELECT * FROM users';
        db.query(query, (err, result) => {
            if (err) reject(err);
            resolve(result);  // คืนค่าผลลัพธ์ทั้งหมด
        });
    });
};
