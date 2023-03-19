const Pickup = require('../models/pickup-model');

const createPickup = async (req, res) => {
    try {
        const user = req.user._id;
        const { timeslot, agent } = req.body;
        const pickup = new Pickup({
            user,
            timeslot,
            agent
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
        const pickup = await Pickup.findByIdAndUpdate(id, req.body, { new: true });
        if (!pickup) {
            return res.status(404).json({
                message: 'Pickup not found'
            });
        }
        return res.status(200).json({ pickup });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while updating pickup',
            error: error
        });
    }
};

const findPickUpsByUserId = async (req, res) => {
    const userId = req.params.id;

    try {
        const pickups = await Pickup.find({ user: userId });
        if(!pickups){
            return res.status(404).json({
                message: 'No Pickups available'
            })
        }
        res.status(201).json(pickups);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

module.exports = {
    createPickup,
    updatePickup,
    findPickUpsByUserId
};
