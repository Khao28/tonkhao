const express = require('express');
const router = express.Router();
const borrowController = require('../controllers/borrowController');
const { verifyToken } = require('../middlewares/authMiddleware');

router.post('/', verifyToken, borrowController.createRequest); 
router.get('/', verifyToken, borrowController.getAllRequests); 
router.get('/history/:id', verifyToken, borrowController.getBorrowHistory);


module.exports = router;