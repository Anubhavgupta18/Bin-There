const express = require('express');
const { createUser, signin } = require('../controllers/user-controller');
const { validateUser } = require('../middlewares/userauth-middleware');

const router = express.Router();

router.post('/signup', validateUser, createUser);
router.post('/signin', signin );

module.exports = router;