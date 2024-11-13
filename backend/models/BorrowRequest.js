// models/BorrowRequest.js

const db = require('../config/db');

const BorrowRequest = {
    create: (request, callback) => {
        const sql = 'INSERT INTO borrow_requests (asset_id, user_id, request_date, borrow_date, return_date, status) VALUES (?, ?, ?, ?, ?, "pending")';
        db.query(sql, [request.asset_id, request.user_id, request.request_date, request.borrow_date, request.return_date], callback);
    },

    findAll: (callback) => {
        const sql = 'SELECT * FROM borrow_requests';
        db.query(sql, callback);
    },

    updateStatus: (id, status, callback) => {
        const sql = 'UPDATE borrow_requests SET status = ? WHERE id = ?';
        db.query(sql, [status, id], callback);
    },

    // ฟังก์ชันในการค้นหาการยืมที่ยังไม่เสร็จสิ้นตาม Asset ID
    findActiveBorrowRequestsByAssetId: (assetId, callback) => {
        const sql = 'SELECT * FROM borrow_requests WHERE asset_id = ? AND status IN ("pending", "approved")';
        db.query(sql, [assetId], callback);
    }
};

module.exports = BorrowRequest;
