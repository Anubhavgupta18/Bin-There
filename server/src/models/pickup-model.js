const mongoose = require('mongoose');

const pickupSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    timeslot: {
        type: String,
        required: true
    },
    agent: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Agent',
    },
    statusByUser: {
        type: Boolean,
        default: false
    },
    statusByAgent: {
        type: Boolean,
        default: false
    },
    pickUpStatus:{
        type: String,
        enum: ['pending', 'approved', 'rejected'],
        default: 'pending'
    }
}, { timestamps: true });

const Pickup = mongoose.model('Pickup', pickupSchema);

module.exports = Pickup;