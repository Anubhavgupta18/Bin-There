const express = require('express');
const { createAgent, signin, verifyOtp } = require('../controllers/agent-controller');
const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);

module.exports = router;