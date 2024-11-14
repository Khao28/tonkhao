const BorrowRequest = require('../models/BorrowRequest');
const moment = require('moment');
const db = require('../config/db');

// ฟังก์ชันสร้างคำขอยืม
exports.createRequest = (req, res) => {
    const { asset_id, user_id, return_date } = req.body;
    const request_date = moment().format('YYYY-MM-DD');
    const borrow_date = request_date;

    if (!asset_id || !user_id || !return_date) {
        return res.status(400).json({ error: 'กรุณากรอกข้อมูลให้ครบถ้วน' });
    }

    db.query('SELECT * FROM assets WHERE id = ?', [asset_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถดึงข้อมูลทรัพยากรได้', details: err });
        }

        const asset = results[0];
        if (!asset) {
            return res.status(404).json({ error: 'ไม่พบทรัพยากรที่ต้องการ' });
        }

        if (asset.status === 'disabled' || asset.status === 'borrowed') {
            return res.status(400).json({ error: 'ไม่สามารถสร้างคำขอยืมสำหรับทรัพยากรที่ถูกปิดใช้งานหรือกำลังถูกยืม' });
        }

        const query = 'INSERT INTO borrow_requests (asset_id, user_id, request_date, borrow_date, return_date, status) VALUES (?, ?, ?, ?, ?, ?)';
        db.query(query, [asset_id, user_id, request_date, borrow_date, return_date, 'pending'], (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'ไม่สามารถสร้างคำขอยืมได้', details: err });
            }

            res.status(201).json({ message: 'สร้างคำขอยืมสำเร็จ' });
        });
    });
};

// ฟังก์ชันอัปเดตสถานะคำขอยืม
exports.updateRequestStatus = (req, res) => {
    const { id, status } = req.params;
    const approverId = req.user.id;

    const validStatuses = ['pending', 'approved', 'rejected'];
    const normalizedStatus = status.toLowerCase();

    if (!validStatuses.includes(normalizedStatus)) {
        return res.status(400).json({ error: 'สถานะไม่ถูกต้อง' });
    }

    const query = 'UPDATE borrow_requests SET status = ?, approve_by = ? WHERE id = ?';
    db.query(query, [normalizedStatus, approverId, id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถอัปเดตสถานะได้', details: err });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'ไม่พบคำขอยืมเพื่ออัปเดต' });
        }

        const getRequestQuery = 'SELECT * FROM borrow_requests WHERE id = ?';
        db.query(getRequestQuery, [id], (err, requestResult) => {
            if (err) {
                return res.status(500).json({ error: 'ไม่สามารถดึงข้อมูลคำขอยืมได้', details: err });
            }

            if (requestResult.length === 0) {
                return res.status(404).json({ error: 'ไม่พบคำขอยืม' });
            }

            const borrowRequest = requestResult[0];
            
            if (normalizedStatus === 'approved' || normalizedStatus === 'rejected') {
                const newAssetStatus = normalizedStatus === 'approved' ? 'borrowed' : 'available';

                const updateAssetQuery = 'UPDATE assets SET status = ? WHERE id = ?';
                db.query(updateAssetQuery, [newAssetStatus, borrowRequest.asset_id], (err) => {
                    if (err) {
                        return res.status(500).json({ error: 'ไม่สามารถอัปเดตสถานะทรัพยากรได้' });
                    }
                    res.json({ message: 'อัปเดตสถานะคำขอยืมและสถานะทรัพยากรสำเร็จ' });
                });
            } else {
                res.json({ message: 'อัปเดตสถานะคำขอยืมสำเร็จ' });
            }
        });
    });
};

// ฟังก์ชันดึงข้อมูลคำขอยืมทั้งหมดที่มีสถานะรอการอนุมัติ
exports.getAllRequests = (req, res) => {
    const query = `
        SELECT br.id, br.status, a.name as asset_name, u.username as user_name
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        JOIN users u ON br.user_id = u.id
        WHERE br.status = 'pending'
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถดึงข้อมูลคำขอยืมทั้งหมดได้', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'ไม่พบคำขอยืมที่รอการอนุมัติ' });
        }

        res.json({ pendingRequests: results });
    });
};

// ฟังก์ชันดึงประวัติการยืมของผู้ใช้
exports.getBorrowHistory = (req, res) => {
    const userId = req.params.id || req.user.id;

    const query = `
        SELECT br.id, br.status, a.name AS asset_name, u.username AS approver_name
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        LEFT JOIN users u ON br.approve_by = u.id
        WHERE br.user_id = ?
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถดึงประวัติการยืมได้', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'ไม่พบประวัติการยืมสำหรับผู้ใช้นี้' });
        }

        res.json({ borrowHistory: results });
    });
};

// ฟังก์ชันสำหรับเจ้าหน้าที่ในการดึงประวัติการยืมทั้งหมด
exports.getAllBorrowHistory = (req, res) => {
    const query = `
        SELECT br.id, br.status, a.name AS asset_name, u.username AS user_name, approver.username AS approver_name
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        JOIN users u ON br.user_id = u.id
        LEFT JOIN users approver ON br.approve_by = approver.id
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถดึงประวัติการยืมสำหรับเจ้าหน้าที่ได้', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'ไม่พบประวัติการยืม' });
        }

        res.json({ borrowHistory: results });
    });
};

// ฟังก์ชันดึงประวัติการอนุมัติและปฏิเสธจากผู้อนุมัติทั้งหมด
exports.getAllApproverHistory = (req, res) => {
    const query = `
        SELECT br.id, br.status, a.name AS asset_name, u.username AS user_name, approver.username AS approver_name, approver.id AS approver_id
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        JOIN users u ON br.user_id = u.id
        LEFT JOIN users approver ON br.approve_by = approver.id
        WHERE br.status IN ('approved', 'rejected')
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'ไม่สามารถดึงประวัติการอนุมัติได้', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'ไม่พบประวัติการอนุมัติ' });
        }

        res.json({ approverHistory: results });
    });
};
