const jwt = require('jsonwebtoken');
require('dotenv').config();

const API_KEY = process.env.API_KEY || "my-secret-key";

// Middleware to verify token
exports.verifyToken = async (req, res, next) => {
    const token = req.headers['authorization'];

    // ตรวจสอบว่า token มีหรือไม่
    if (!token) {
        return res.status(401).send('A token is required for authentication');
    }

    try {
        const tokenValue = token.split(" ")[1]; // ดึง token หลังจาก 'Bearer'

        // ตรวจสอบ token ด้วย secret key
        const decoded = jwt.verify(tokenValue, API_KEY); 
        req.user = decoded; // บันทึกข้อมูลผู้ใช้ลงใน request

        next(); // ให้โปรแกรมดำเนินการต่อไปยัง route handler
    } catch (err) {
        console.error('Token verification error:', err); 
        return res.status(401).send('Invalid Token');
    }
};

