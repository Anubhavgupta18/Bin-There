const User = require('../models/user-model');


const createUser = async (req, res) => {
    try {
        const user = await User.create(req.body);
        return res.status(201).json({ user });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while creating user',
            error: error
        });
    }
};
const signin = async (req, res) => {
    try {
        if (!req.body.email || !req.body.password) {
            return res.status(400).json({
                message: 'Please fill all the fields'
            });
        }
        const user = await User.findOne({ email: req.body.email });
        if (!user) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }

        const isPasswordValid = user.comparePassword(req.body.password);
        if (!isPasswordValid) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }

        const token = await user.generateToken();
        return res.status(200).json({
            message: 'Login successful',
            token
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while signing in',
            error: error
        });
    }
};

module.exports = {
    createUser,
    signin
}