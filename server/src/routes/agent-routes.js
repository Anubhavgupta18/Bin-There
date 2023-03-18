const express = require('express');
const { createAgent, signin, verifyOtp, updateDetails, getAgent } = require('../controllers/agent-controller');
const { authenticateAgent } = require('../middlewares/userauth-middleware');
const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.patch('/:id/update', updateDetails );
router.get('/:agentId', getAgent);

module.exports = router;