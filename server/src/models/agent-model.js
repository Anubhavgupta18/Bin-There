const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { JWT_SECRETKEY } = require('../configs/serverConfig');

const agentSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    otp: {
        type: String,
        default: null
    },
    mobileNo: {
        type: String,
        required: true
    },
    address: {
        flatNo: String,
        city: String,
        state: String,
        pincode: String,
        street: String
    },
    isVerified: {
        type: Boolean,
        default: false
    },
    pickupPoints: {
        type: [String],
        default: [],
    }

}, { timestamps: true });

agentSchema.pre('save', async function (next) {
    const agent = this;
    const SALT = bcrypt.genSaltSync(10);
    const encryptedPassword = bcrypt.hashSync(agent.password, SALT);
    agent.password = encryptedPassword;
    next();
});

agentSchema.methods.comparePassword = function (plainPassword) {
    const agent = this;
    return bcrypt.compare(plainPassword, agent.password);
};

agentSchema.methods.generateToken = function () {
    const agent = this;
    const token = jwt.sign({ id: agent._id, email: agent.email }, JWT_SECRETKEY);
    return token;
}

const Agent = mongoose.model('Agent', agentSchema);
module.exports = Agent;