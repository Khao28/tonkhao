const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
//-------------------------------------------------------------------//

router.post('/register', authController.register);
//-------------------------------------------------------------------//
router.post('/login', authController.login);
//-------------------------------------------------------------------//
// for dev
router.put('/users/', authController.updateUser); 
//-------------------------------------------------------------------//
router.get('/users', authController.getAllUsers);  
//-------------------------------------------------------------------//
module.exports = router;
//-------------------------------------------------------------------//