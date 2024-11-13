const jwt = require('jsonwebtoken');
const authConfig = require('../config/authConfig');  // นำเข้า authConfig

const tokenUtils = {
    generateToken: (user) => {
        return jwt.sign(
            { id: user.id, role: user.role },
            authConfig.secret,  // ใช้ secret key ที่ถูกตั้งค่าใน authConfig
            { expiresIn: authConfig.expiresIn }  // ใช้ค่าจาก authConfig
        );
    },

    verifyToken: (token) => {
        return new Promise((resolve, reject) => {
            jwt.verify(token, authConfig.secret, (err, decoded) => {
                if (err) return reject(err);  // ส่งข้อผิดพลาดหากตรวจสอบไม่ผ่าน
                resolve(decoded);  // ส่งข้อมูลของ decoded token
            });
        });
    }
};

module.exports = tokenUtils;
