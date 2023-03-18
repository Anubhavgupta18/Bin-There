const { checkPickup } = require('../middlewares/pickup-middleware');
const { createPickup, updatePickup, findPickUpsByUserId } = require('../controllers/pickup-controller');
const { authenticateUser } = require('../middlewares/userauth-middleware');

const express = require('express');
const router = express.Router();

router.post('/', authenticateUser, createPickup);
router.patch('/update/:pickUpId', authenticateUser, updatePickup);
router.get('/user', authenticateUser, findPickUpsByUserId )


module.exports = router;