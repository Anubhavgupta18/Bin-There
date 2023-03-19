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
    },
    address: {
        flatNo: String,
        city: String,
        state: String,
        pincode: String,
        street: String,
        lat: String,
        lon: String
    },
}, { timestamps: true });

const Pickup = mongoose.model('Pickup', pickupSchema);

module.exports = Pickup;