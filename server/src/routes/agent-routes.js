const express = require('express');
const { createAgent, signin, verifyOtp, getTimeSlots } = require('../controllers/agent-controller');
const { authenticateUser } = require('../middlewares/userauth-middleware');
const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.get('/timeslots', authenticateUser, getTimeSlots);

module.exports = router;