require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const db = require('../config/db'); 

// Register
exports.register = (req, res) => {
    const { username, password, email } = req.body;

    // เช็คว่า username หรือ email ซ้ำหรือไม่
    db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {  
        if (err) return res.status(500).json({ message: 'Database error' });

        if (results.length > 0) {
            return res.status(409).json({ message: 'Username already exists' });
        }
    });

    db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {  
        if (err) return res.status(500).json({ message: 'Database error' });

        if (results.length > 0) {
            return res.status(409).json({ message: 'Email already exists' });
        }
    });

    const hashedPassword = bcrypt.hashSync(password, 10);

    const newUser = {
        username,
        password: hashedPassword,
        email,
    };

    // สร้าง user ใหม่และบันทึกลงฐานข้อมูล
    db.query('INSERT INTO users SET ?', newUser, (err, results) => {  
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Register failed' });
        }
        return res.status(201).json({ message: 'Register successfully' });
    });
};




// ฟังก์ชันสำหรับ login
exports.login = async (req, res) => {
    const { username, password } = req.body;

    try {
        // ตรวจสอบผู้ใช้ในฐานข้อมูล
        const user = await User.findByUsername(username);  // หาผู้ใช้จากฐานข้อมูล (หรือใช้ db.query ในกรณีของ MySQL)
        if (!user) {
            return res.status(404).json({ message: 'User not found' });  // ถ้าผู้ใช้ไม่พบ
        }

        // ตรวจสอบรหัสผ่าน
        const isPasswordValid = await bcrypt.compare(password, user.password);  // ตรวจสอบรหัสผ่านที่เข้ารหัส
        if (!isPasswordValid) {
            return res.status(401).json({ message: 'Invalid password' });  // ถ้ารหัสผ่านไม่ถูกต้อง
        }

        // สร้าง token พร้อมข้อมูลบทบาทและ Object ID
        const token = jwt.sign(
            { userId: user.id, username: user.username, role: user.role },  // ข้อมูลที่จะบรรจุใน token
            process.env.JWT_SECRET || 'your_secret_key',  // คีย์ลับจาก .env หรือกำหนดในตัวแปร
            { expiresIn: '1d' }  // ระยะเวลาหมดอายุของ token
        );

        // ส่ง token กลับไปใน response
        return res.status(200).json({ token, userId: user.id, role: user.role });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal server error' });  // ถ้ามีข้อผิดพลาดในการเชื่อมต่อฐานข้อมูลหรืออื่นๆ
    }
};




// Get One User
exports.getOne = (req, res) => {
    const { id } = req.params;
    User.findById(id, (err, user) => {
        if (err || !user) return res.status(404).json({ error: 'User not found' });
        res.status(200).json(user);
    });
};

// Get All Users
exports.getAll = async (req, res) => {
    try {
        // ใช้ db.query ที่ได้เชื่อมต่อไว้ในโมเดล User
        const users = await User.findAll();  // สั่งให้โมเดลดึงข้อมูลทั้งหมด
        if (users.length === 0) {
            return res.status(404).json({ message: 'No users found' });
        }
        res.status(200).json(users);
    } catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Failed to retrieve users' });
    }
};


