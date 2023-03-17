const express = require('express');
const router = express.Router();
const reportController = require('../controllers/report-controller');
const { authenticateUser } = require('../middlewares/userauth-middleware');
const upload=require('../multer');


router.post('/', upload.single("image"), authenticateUser, reportController.createReport);

router.get('/', reportController.getAllReports);

router.get('/user/:userId', reportController.findReportsByUserId);

router.get('/:id', reportController.getReportById);

router.patch('/:id', reportController.updateReport);

router.delete('/:id', reportController.deleteReport);

module.exports = router;
