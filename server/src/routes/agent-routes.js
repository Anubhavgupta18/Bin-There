const express = require('express');
const { createAgent, signin, verifyOtp, updateDetails } = require('../controllers/agent-controller');
const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.patch('/:id/update', updateDetails );

module.exports = router;