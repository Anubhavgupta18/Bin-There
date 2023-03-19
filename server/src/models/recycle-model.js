const mongoose = require('mongoose');

const recycleSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    price: {
        type: String,
        //required: true
    },
    agent: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Agent',
    },
}, { timestamps: true });

const Recycle = mongoose.model('Recycle', recycleSchema);

module.exports = Recycle;