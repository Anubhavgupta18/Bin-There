const { checkPickup } = require('../middlewares/pickup-middleware');
const { createPickup } = require('../controllers/pickup-controller');
const { authenticateUser } = require('../middlewares/userauth-middleware');

const express = require('express');
const router = express.Router();

router.post('/', authenticateUser, checkPickup, createPickup);


module.exports = router;