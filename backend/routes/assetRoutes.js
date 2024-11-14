
const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middlewares/authMiddleware');
const assetController = require('../controllers/assetController');


router.post('/create', verifyToken, assetController.createAsset);  
router.get('/', verifyToken, assetController.getAllAssets);
router.put('/:id/status', verifyToken, assetController.updateAssetStatus);
router.get('/:id', verifyToken, assetController.returnAsset);
router.post('/return/:id',verifyToken, assetController.returnAsset);
module.exports = router;
