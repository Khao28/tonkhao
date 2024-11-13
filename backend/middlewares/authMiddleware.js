// Import config
const db = require('../config/db');

const jwt = require('jsonwebtoken'); // ใช้ jwt สำหรับตรวจสอบ token

exports.updateRequestStatus = (req, res) => {
    const { id, status } = req.params;
    
    // ดึง token จาก headers
    const token = req.headers['authorization']?.split(' ')[1]; // ตรวจสอบ token จาก header authorization

    if (!token) {
        return res.status(403).json({ error: 'No token provided' });
    }

    // ตรวจสอบและดึงข้อมูล user จาก token
    jwt.verify(token, 'secretKey', (err, decoded) => {
        if (err) {
            return res.status(401).json({ error: 'Invalid token' });
        }

        const approverId = decoded.id; // ดึง id ของผู้อนุมัติจาก token

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
    });
};
