const mongoose = require('mongoose');

const pickupSchema = new mongoose.Schema({
    username: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    pickupAddress: {
        type: String,
        required: true
    },
    pickupDate: {
        type: Date,
        required: true
    },
    pickupTime: {
        type: String,
        required: true
    },
    agentName: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
        //required: true
    }
});

const Pickup = mongoose.model('Pickup', pickupSchema);

module.exports = Pickup;