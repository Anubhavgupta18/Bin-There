const Pickup = require('../models/pickup-model');

const createPickup = async (req, res) => {
    try {
        const user = req.user;
        req.body.user = user._id;
        const pickup = await Pickup.create(req.body);
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
