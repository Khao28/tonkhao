const db = require('../config/db'); // เชื่อมต่อกับฐานข้อมูล MySQL

// ฟังก์ชันสำหรับเพิ่ม Asset ใหม่
const createAsset = async (assetData) => {
    try {
        const { name, status, description } = assetData;
        const query = 'INSERT INTO assets (name, status, description) VALUES (?, ?, ?)';
        const [result] = await db.execute(query, [name, status, description]);
        return result;
    } catch (error) {
        throw new Error('Error creating asset: ' + error.message);
    }
};

// ฟังก์ชันสำหรับดึงข้อมูล Asset ทั้งหมด
const getAllAssets = async () => {
    try {
        const query = 'SELECT * FROM assets';
        const [assets] = await db.execute(query);
        return assets;
    } catch (error) {
        throw new Error('Error fetching assets: ' + error.message);
    }
};

// ฟังก์ชันสำหรับอัปเดตสถานะของ Asset
const updateAssetStatus = async (assetId, newStatus) => {
    try {
        const query = 'UPDATE assets SET status = ? WHERE id = ?';
        const [result] = await db.execute(query, [newStatus, assetId]);
        return result;
    } catch (error) {
        throw new Error('Error updating asset status: ' + error.message);
    }
};

// ฟังก์ชันสำหรับดึงข้อมูล Asset โดยใช้ ID
const returnAsset = async (assetId) => {
    try {
        const query = 'SELECT * FROM assets WHERE id = ?';
        const [asset] = await db.execute(query, [assetId]);
        return asset[0]; // ส่งคืนแค่ 1 record
    } catch (error) {
        throw new Error('Error fetching asset by ID: ' + error.message);
    }
};

// ฟังก์ชันสำหรับเช็คสถานะของ Borrow Request
const checkBorrowRequestStatus = async (borrowRequestId) => {
    try {
        const query = 'SELECT * FROM borrow_requests WHERE id = ?';
        const [borrowRequest] = await db.execute(query, [borrowRequestId]);
        return borrowRequest[0]; // ส่งคืนแค่ 1 record
    } catch (error) {
        throw new Error('Error fetching borrow request status: ' + error.message);
    }
};

module.exports = {
    createAsset,
    getAllAssets,
    updateAssetStatus,
    returnAsset,
    checkBorrowRequestStatus
};
