const express = require('express');
const router = express.Router();
const borrowController = require('../controllers/borrowController');
const { verifyToken } = require('../middlewares/authMiddleware'); 


// ดึงข้อมูลผู้ใช้ทั้งหมดที่มีคำขอ 'pending' สำหรับ approver
router.get('/pending-users', verifyToken, borrowController.getAllRequests);

// อัพเดตสถานะจาก URL (approved/rejected) และ ID
router.put('/:status/:id', verifyToken, borrowController.updateRequestStatus); 

// เส้นทางสำหรับการดึงประวัติของผู้อนุมัติ
router.get('/history',verifyToken,  borrowController.getAllApproverHistory);

module.exports = router;
