require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

require('dotenv').config();

API_KEY = process.env.API_KEY || "my-secret-key";
//-------------------------------------------------------------------//
// Register
exports.register = async (req, res) => {
    const { username, password, email } = req.body;

    // ตรวจสอบว่ามีค่าในข้อมูลที่ส่งมาหรือไม่
    if (!username || !password || !email ) {
        return res.status(400).json({ message: 'Missing required fields' });
    }

    // แฮชรหัสผ่านก่อนบันทึก
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = {
        username,
        password: hashedPassword,
        email
    };

    try {
        // ตรวจสอบว่าชื่อผู้ใช้นั้นมีอยู่แล้วหรือไม่
        const isDuplicate = await User.findByUsername(username);
        if (isDuplicate) {
            return res.status(409).json({ message: 'Username already exists' });
        }

        // บันทึกผู้ใช้ใหม่
        await User.create(newUser);
        return res.status(201).json({ message: 'Register successfully' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Register failed' });
    }
};


//-------------------------------------------------------------------//

exports.login = async (req, res) => {
    const { username, password } = req.body;
    // ตรวจสอบผู้ใช้ในฐานข้อมูล
    const user = await User.findByUsername(username); 
    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }
    // ตรวจสอบรหัสผ่าน
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(401).json({ message: 'Invalid password' });
    }

    // สร้าง token พร้อมข้อมูลบทบาทและ Object ID
    const token = jwt.sign({ userId: user.id, username: user.username }, API_KEY, { expiresIn: '14d' });//กำหนดเวลาหมดอายุโทเคน

    // ส่ง token และ userId กลับไปใน response
    return res.status(200).json({ token });
};



// Get all users
exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.getAllUsers();
        res.status(200).json(users);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Failed to fetch users' });
    }
};

//-------------------------------------------------------------------//

// อัปเดตผู้ใช้
exports.updateUser = async (req, res) => {
    const userId = req.params.id;
    const userUpdates = req.body;

    try {
        // ค้นหาผู้ใช้จาก ID
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // ทำการอัปเดตผู้ใช้
        const result = await User.update(userUpdates, userId);
        res.status(200).json({ message: 'User updated successfully', result });
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ error: 'Failed to update user' });
    }
};

//-------------------------------------------------------------------//

