const Pickup = require('../models/pickup-model');

const createPickup = async (req, res) => {
    try {
        const user = req.user._id;
        const { startTime,endTime } = req.body;
        const pickup = new Pickup({
            user,
            startTime,
            endTime
        });
        await pickup.save();
        return res.status(201).json({ pickup });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while creating pickup',
            error: error
        });
    }
};

module.exports = {
    createPickup
};
