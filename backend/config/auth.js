module.exports = {
    secret: process.env.JWT_SECRET || 'your_secret_key',  // ใช้คีย์จาก .env ถ้ามี หรือใช้ค่า default
    expiresIn: '1d'  // ระยะเวลาหมดอายุของ token, เช่น 1 วัน
};