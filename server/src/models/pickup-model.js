const mongoose = require('mongoose');

const pickupSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    // startTime: {
    //     type: Date,
    //     required: true,
    // },
    // endTime: {
    //     type: Date,
    //     required: true,
    // },
    timeslot: {
        type: String,
        required: true
    },
    agent: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Agent',
    },
    status: {
        type: String,
        enum: ['pending', 'approved', 'rejected'],
        default: 'pending'
    }
}, { timestamps: true });

// pickupSchema.post('save', async function (doc, next) {
//     try {
//         const agents = await User.find({ role: 'agent' });
//         agents.forEach(async (agent) => {


const Pickup = mongoose.model('Pickup', pickupSchema);

module.exports = Pickup;