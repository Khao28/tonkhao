const db = require('../config/db');

const Asset  = {
    create: (asset, callback) => {
        if (!asset.name || !asset.status || !asset.description) {
            console.error("Missing fields:", asset);
            return callback({ error: 'Missing required fields' });
        }

        const sql = 'INSERT INTO assets (name, status, description) VALUES (?, ?, ?)';
        db.query(sql, [asset.name, asset.status, asset.description], (err, result) => {
            if (err) {
                console.error("Error during asset creation:", err);
                return callback({ error: 'Failed to create asset', details: err });
            }
            console.log("Asset created successfully:", result);
            callback(null, { message: 'Asset created' });
        });
    },

    findAll: (callback) => {
        const sql = 'SELECT * FROM assets';
        db.query(sql, (err, assets) => {
            if (err) {
                console.error("Error retrieving assets:", err);
                return callback({ error: 'Failed to retrieve assets' });
            }
            console.log("Assets retrieved:", assets);
            callback(null, assets);
        });
    },

    findById: (id, callback) => {
        const sql = 'SELECT * FROM assets WHERE id = ?';
        db.query(sql, [id], (err, asset) => {
            if (err) {
                console.error("Error retrieving asset by id:", err);
                return callback({ error: 'Failed to retrieve asset' });
            }
            if (!asset.length) {
                console.log("No asset found with id:", id);
                return callback({ error: 'Asset not found' });
            }
            console.log("Asset retrieved:", asset);
            callback(null, asset[0]);
        });
    },

    updateStatus: (id, status, callback) => {
        if (!id || !status) {
            return callback({ error: 'Missing asset id or status' });
        }

        // ตรวจสอบสถานะหากจะเป็น 'disabled' ให้ตรวจสอบการยืม
        if (status === 'disabled') {
            const sql = 'SELECT * FROM borrow_requests WHERE asset_id = ? AND status = "pending"';
            db.query(sql, [id], (err, borrowRequests) => {
                if (err) {
                    console.error("Error checking borrow requests:", err);
                    return callback({ error: 'Failed to check borrow requests' });
                }
                if (borrowRequests.length > 0) {
                    console.log("Cannot disable asset with active borrow requests:", borrowRequests);
                    return callback({ error: 'Asset cannot be disabled because it has active borrow requests' });
                }

                const updateSql = 'UPDATE assets SET status = ? WHERE id = ?';
                db.query(updateSql, [status, id], (err, result) => {
                    if (err) {
                        console.error("Error updating asset status:", err);
                        return callback({ error: 'Failed to update asset status' });
                    }
                    console.log("Asset status updated:", result);
                    callback(null, { message: 'Asset status updated to disabled' });
                });
            });
        } else {
            const updateSql = 'UPDATE assets SET status = ? WHERE id = ?';
            db.query(updateSql, [status, id], (err, result) => {
                if (err) {
                    console.error("Error updating asset status:", err);
                    return callback({ error: 'Failed to update asset status' });
                }
                console.log("Asset status updated:", result);
                callback(null, { message: 'Asset status updated' });
            });
        }
    }
};

module.exports = Asset;
