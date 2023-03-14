const checkPickup = async (req, res, next) => {
    const { pickupStartTime, pickupEndTime, flatNo, street, city, state, pincode } = req.body;
    if (!pickupStartTime || !pickupEndTime || !flatNo || !street || !city || !state || !pincode) {
        return res.status(400).json({
            message: 'Please fill all the fields'
        });
    }
    next();
}

module.exports = {
    checkPickup
}