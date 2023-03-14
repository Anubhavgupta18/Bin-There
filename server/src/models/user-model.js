const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { JWT_SECRETKEY } = require('../configs/serverConfig');

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    name: {
        type: String,
        required: true,
        maxlength: 20
    },
    role: {
        type: String,
        required: true,
        enum: ['admin', 'user'],
        default: 'user'
    }
});

userSchema.pre('save', function (next) {
    const user = this;
    const SALT=bcrypt.genSaltSync(10);
    const encryptedPassword = bcrypt.hashSync(user.password, SALT);
    user.password = encryptedPassword;
    next();
});

userSchema.methods.comparePassword = function (plainPassword) {
    const user = this;
    return bcrypt.compareSync(plainPassword, user.password);
};

userSchema.methods.generateToken = function () {
    const user = this;
    const token = jwt.sign({ id: user._id, email: user.email }, JWT_SECRETKEY, { expiresIn: '1d' });
    return token;
}
const User = mongoose.model('User', userSchema);

module.exports = User;