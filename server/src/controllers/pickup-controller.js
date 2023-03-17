const Pickup = require('../models/pickup-model');

const createPickup = async (req, res) => {
    try {
        const user = req.user._id;
        const { timeslot, agentId } = req.body;
        const pickup = new Pickup({
            user,
            timeslot,
            agent: agentId
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

const updatePickup = async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;
        const pickup = await Pickup.findById(id);
        if (!pickup) {
            return res.status(404).json({
                message: 'Pickup not found'
            });
        }
        pickup.status = status;
        await pickup.save();
        return res.status(200).json({ pickup });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while updating pickup',
            error: error
        });
    }
};

module.exports = {
    createPickup,
    updatePickup
};
