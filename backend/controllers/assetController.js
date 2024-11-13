const Asset = require('../models/Asset');
const BorrowRequest  = require('../models/BorrowRequest');

exports.createAsset = (req, res) => {
    const { name, status, description } = req.body;

    console.log("Request Body:", req.body);

    // ตรวจสอบว่ามีข้อมูลครบหรือไม่
    if (!name || !status || !description) {
        console.log("Missing fields:", { name, status, description });
        return res.status(400).json({ error: 'Missing required fields' });
    }

    // สร้าง asset ในฐานข้อมูล
    Asset.create({ name, status, description }, (err, result) => {
        if (err) {
            console.error("Error during asset creation:", err);
            return res.status(500).json({ error: 'Failed to create asset', details: err });
        }

       
        if (result && result.message) {
            console.log("Asset created successfully:", result);
            return res.status(201).json({ message: 'Asset created' });
        } else {
            console.log("Unexpected result:", result);
            return res.status(500).json({ error: 'Unexpected error during asset creation' });
        }
    });
};



exports.getAllAssets = (req, res) => {
    // เรียกใช้ฟังก์ชันค้นหาทุก asset จากฐานข้อมูล
    Asset.findAll((err, assets) => {
        if (err) {
            // Log ข้อผิดพลาดหากไม่สามารถดึงข้อมูลได้
            console.error("Error retrieving assets:", err);
            return res.status(500).json({ error: 'Failed to retrieve assets' });
        }
        // ส่งข้อมูล asset ทั้งหมดหากสำเร็จ
        res.json(assets);
    });
};

exports.updateAssetStatus = (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    // ตรวจสอบว่ามีการยืมสินทรัพย์ที่ยังไม่เสร็จสิ้นหากสถานะจะเปลี่ยนเป็น 'disabled'
    if (status === 'disabled') {
        // ใช้ BorrowRequest.findActiveBorrowRequestsByAssetId เพื่อตรวจสอบการยืมสินทรัพย์ที่ยังไม่เสร็จสิ้น
        BorrowRequest.findActiveBorrowRequestsByAssetId(id, (err, Borrow) => {
            if (err) {
                console.error("Error checking borrow requests:", err);
                return res.status(500).json({ error: 'Failed to check borrow requests' });
            }
            if (Borrow.length > 0) {
                // ถ้ามีการยืมสินทรัพย์ที่ยังไม่เสร็จสิ้นให้คืนข้อความว่าไม่สามารถเปลี่ยนสถานะได้
                return res.status(400).json({ error: 'Asset cannot be disabled because it has active borrow requests' });
            }

            // เรียกใช้ฟังก์ชันอัปเดตสถานะ asset เมื่อไม่มีการยืมสินทรัพย์ active
            Asset.updateStatus(id, status, (err) => {
                if (err) {
                    console.error("Error updating asset status:", err);
                    return res.status(500).json({ error: 'Failed to update asset status' });
                }
                res.json({ message: 'Asset status updated to disabled' });
            });
        });
    } else {
        // อัปเดตสถานะปกติ
        Asset.updateStatus(id, status, (err) => {
            if (err) {
                console.error("Error updating asset status:", err);
                return res.status(500).json({ error: 'Failed to update asset status' });
            }
            res.json({ message: 'Asset status updated' });
        });
    }
};



exports.returnAsset = (req, res) => {
    const { assetId } = req.params;

    // ค้นหาทรัพย์สินจากฐานข้อมูล
    Asset.findById(assetId, (err, asset) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to retrieve asset' });
        }

        if (!asset) {
            return res.status(404).json({ error: 'Asset not found' });
        }

        // ตรวจสอบสถานะของทรัพย์สินก่อนการคืน
        if (asset.status !== 'borrowed') {
            return res.status(400).json({ error: 'Asset is not borrowed and cannot be returned' });
        }

        // อัปเดตสถานะของทรัพย์สินเป็น 'available'
        Asset.updateStatus(assetId, 'available', (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to update asset status' });
            }
            res.json({ message: 'Asset successfully returned and status updated to available' });
        });
    });
};


exports.getDashboard = (req, res) => {
    Asset.getStatusCounts((err, counts) => {
        if (err) {
            return res.status(500).json({ error: 'Failed to retrieve asset status counts' });
        }
        res.json(counts);
    });
};



Asset.getStatusCounts = (callback) => {
    const sql = `
        SELECT status, COUNT(*) AS count 
        FROM assets 
        GROUP BY status
    `;
    db.query(sql, (err, result) => {
        if (err) {
            console.error("Error retrieving asset status counts:", err);
            return callback({ error: 'Failed to retrieve asset status counts' });
        }

        // สร้างออบเจ็กต์ที่มีสถานะทั้งหมดที่คาดว่าจะมี
        const expectedStatuses = ['available', 'pending', 'borrowed', 'disabled'];

        // สร้างออบเจ็กต์ที่จะส่งกลับ
        const counts = result.reduce((acc, row) => {
            acc[row.status] = row.count;
            return acc;
        }, {});

        // ตั้งค่าเริ่มต้นให้กับสถานะที่ไม่มีการนับ
        expectedStatuses.forEach(status => {
            if (!counts[status]) {
                counts[status] = 0;
            }
        });

        callback(null, counts);
    });
};
