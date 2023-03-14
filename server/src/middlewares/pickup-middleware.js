const checkPickup = async (req, res, next) => {
    const { startTime,endTime } = req.body;
    if (!startTime || !endTime) {
        return res.status(400).json({
            message: 'Please fill all the fields'
        });
    }
    next();
}

module.exports = {
    checkPickup
}