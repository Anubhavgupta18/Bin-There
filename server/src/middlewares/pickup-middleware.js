const checkPickup = async (req, res, next) => {
    if (!req.body.pickupAddress|| !req.body.pickupStartTime || !req.body.pickupEndTime) {
        return res.status(400).json({
            message: 'Please fill all the fields'
        });
    }
    next();
}

module.exports = {
    checkPickup
}