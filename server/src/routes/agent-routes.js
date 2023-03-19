const express = require('express');

const { createAgent, signin, verifyOtp, updateDetails } = require('../controllers/agent-controller');
const { updatePrice } = require('../controllers/recycle-controller');

const { authenticateAgent } = require('../middlewares/userauth-middleware');

const router = express.Router();

router.post('/signup',createAgent);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.patch('/update/:id', updateDetails );

router.patch('/recycle/:id', updatePrice);

router.get('/:agentId', getAgent);


module.exports = router;