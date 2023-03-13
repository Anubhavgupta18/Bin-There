const mongoose = require('mongoose');
const { MONGODB_URL } = require('../configs/serverConfig');

// Connect to the Mongo DB
const connect = async () => {
    await mongoose.connect(MONGODB_URL);
}

module.exports = { connect };