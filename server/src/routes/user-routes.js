const express = require('express');
const { createUser, signin, verifyOtp, updateDetails, getTimeSlots, getUser } = require('../controllers/user-controller');
const { validateUser, authenticateUser } = require('../middlewares/userauth-middleware');
const { createRecycleReq } = require('../controllers/recycle-controller');

const router = express.Router();

router.post('/signup', validateUser, createUser);
router.post('/signin', signin);
router.post('/verifyotp', verifyOtp);
router.patch('/update', authenticateUser, updateDetails);
router.get('/timeslots', authenticateUser, getTimeSlots);
router.get('/user', authenticateUser, getUser);
router.post('/recycle', authenticateUser, createRecycleReq);

module.exports = router;