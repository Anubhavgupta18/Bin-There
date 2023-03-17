const { checkPickup } = require('../middlewares/pickup-middleware');
const { createPickup, updatePickup } = require('../controllers/pickup-controller');
const { authenticateUser } = require('../middlewares/userauth-middleware');

const express = require('express');
const router = express.Router();

router.post('/', authenticateUser, createPickup);
router.patch('/update/:id', authenticateUser, updatePickup);


module.exports = router;