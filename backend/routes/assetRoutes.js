const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/authMiddleware'); // นำเข้า middleware สำหรับตรวจสอบ token
const assetController = require('../controllers/assetController'); // ตรวจสอบการนำเข้าอย่างถูกต้อง

// Route สำหรับสร้าง asset
router.post('/', verifyToken, assetController.createAsset); 

// Route สำหรับดึงข้อมูล asset ทั้งหมด
router.get('/', verifyToken, assetController.getAllAssets); 

// Route สำหรับอัปเดตสถานะ asset
router.put('/:id/status', verifyToken, assetController.updateAssetStatus); 

// Route สำหรับคืน asset
router.put('/return/:assetId', verifyToken, assetController.returnAsset); 

module.exports = router;
