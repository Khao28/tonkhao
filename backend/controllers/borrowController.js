const BorrowRequest = require('../models/BorrowRequest');;
const moment = require('moment');
const db = require('../config/db');

// Create borrow request
exports.createRequest = (req, res) => {
    
    const { asset_id, user_id, return_date } = req.body;
    const request_date = moment().format('YYYY-MM-DD');
    const borrow_date = request_date;

    // Check if all required fields are provided
    if (!asset_id || !user_id || !return_date) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    // Query to check if the asset exists
    db.query('SELECT * FROM assets WHERE id = ?', [asset_id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to retrieve asset information', details: err });
        }

        const asset = results[0];
        if (!asset) {
            return res.status(404).json({ error: 'Asset not found' });
        }

        // Check the asset's status
        if (asset.status === 'disabled' || asset.status === 'borrowed') {
            return res.status(400).json({ error: 'Cannot create borrow request for a disabled or borrowed asset' });
        }

        // Create the borrow request
        const query = 'INSERT INTO borrow_requests (asset_id, user_id, request_date, borrow_date, return_date, status) VALUES (?, ?, ?, ?, ?, ?)';
        db.query(query, [asset_id, user_id, request_date, borrow_date, return_date, 'pending'], (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to create borrow request', details: err });
            }

            res.status(201).json({ message: 'Borrow request created successfully' });
        });
    });
};



exports.updateRequestStatus = (req, res) => {
    const { id, status } = req.params;
    const approverId = req.user.id; // ใช้ ID ของผู้ที่อนุมัติหรือปฏิเสธจาก token หรือ session

    const validStatuses = ['pending', 'approved', 'rejected'];
    const normalizedStatus = status.toLowerCase();

    if (!validStatuses.includes(normalizedStatus)) {
        return res.status(400).json({ error: 'Invalid status' });
    }

    // อัปเดตสถานะใน borrow_requests พร้อมกับบันทึก approver_id
    const query = 'UPDATE borrow_requests SET status = ?, approve_by = ? WHERE id = ?';
    db.query(query, [normalizedStatus, approverId, id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to update borrow request status', details: err });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'No borrow request found to update' });
        }

        // ค้นหาคำขอยืมที่อัปเดตแล้ว
        const getRequestQuery = 'SELECT * FROM borrow_requests WHERE id = ?';
        db.query(getRequestQuery, [id], (err, requestResult) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to retrieve borrow request', details: err });
            }

            if (requestResult.length === 0) {
                return res.status(404).json({ error: 'No borrow request found' });
            }

            const borrowRequest = requestResult[0];
            
            // ถ้าสถานะคือ approved หรือ rejected อัปเดตสถานะใน asset
            if (normalizedStatus === 'approved' || normalizedStatus === 'rejected') {
                const newAssetStatus = normalizedStatus === 'approved' ? 'borrowed' : 'available';

                // อัปเดตสถานะใน asset
                const updateAssetQuery = 'UPDATE assets SET status = ? WHERE id = ?';
                db.query(updateAssetQuery, [newAssetStatus, borrowRequest.asset_id], (err) => {
                    if (err) {
                        return res.status(500).json({ error: 'Failed to update asset status' });
                    }
                    res.json({ message: 'Borrow request status updated and asset status changed accordingly' });
                });
            } else {
                res.json({ message: 'Borrow request status updated successfully' });
            }
        });
    });
};





// Get all borrow requests with "pending" status
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
            return res.status(500).json({ error: 'Error fetching all borrow requests', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'No pending borrow requests found' });
        }

        res.json({ pendingRequests: results });
    });
};




// Get borrow history for a user
exports.getBorrowHistory = (req, res) => {
    const userId = req.params.id || req.user.id;

    const query = `
        SELECT br.id, br.status, a.name AS asset_name, u.username AS approver_name
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        LEFT JOIN users u ON br.approver_id = u.id
        WHERE br.user_id = ?
    `;

    db.query(query, [userId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Error fetching borrow history', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'No borrow history found for this user' });
        }

        res.json({ borrowHistory: results });
    });
};


// for staff
exports.getAllBorrowHistory = (req, res) => {
    const query = `
        SELECT br.id, br.status, a.name AS asset_name, u.username AS user_name, approver.username AS approver_name
        FROM borrow_requests br
        JOIN assets a ON br.asset_id = a.id
        JOIN users u ON br.user_id = u.id
        LEFT JOIN users approver ON br.approver_id = approver.id
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Error fetching borrow history for all staff', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'No borrow history found' });
        }

        res.json({ borrowHistory: results });
    });
};



// Get the history of approvals and rejections for all approvers
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
            return res.status(500).json({ error: 'Error fetching approver history', details: err });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'No approver history found' });
        }

        res.json({ approverHistory: results });
    });
};

