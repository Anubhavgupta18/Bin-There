const express = require('express');
const { createUser, signin, verifyOtp} = require('../controllers/user-controller');
const { validateUser } = require('../middlewares/userauth-middleware');

const router = express.Router();

router.post('/signup', validateUser, createUser);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);

module.exports = router;