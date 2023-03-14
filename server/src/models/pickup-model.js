const mongoose = require('mongoose');

const pickupSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    pickupAddress: {
        type: String,
        required: true
    },
    pickupStartTime: {
        type: Date,
        required: true,
    },
    pickupEndTime: {
        type: Date,
        required: true,
    },
    agent: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        //required: true
    },
    isCompleted: {
        type: Boolean,
        default: false
    }
}, { timestamps: true });

// pickupSchema.post('save', async function (doc, next) {
//     try {
//         const agents = await User.find({ role: 'agent' });
//         agents.forEach(async (agent) => {


const Pickup = mongoose.model('Pickup', pickupSchema);

module.exports = Pickup;