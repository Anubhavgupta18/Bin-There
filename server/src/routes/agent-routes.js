const express = require('express');
const { createAgent, signin, verifyOtp, updateDetails } = require('../controllers/agent-controller');
const { updatePrice } = require('../controllers/recycle-controller');
const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.patch('/:id/update', updateDetails );
router.patch('/:id/update', updateDetails );
router.patch('/recycle/:id', updatePrice);

module.exports = router;