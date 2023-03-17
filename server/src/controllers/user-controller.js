const User = require('../models/user-model');
const sender = require('../configs/nodemailerConfig');
const { EMAIL } = require('../configs/serverConfig');
const Agent = require('../models/agent-model');


const createUser = async (req, res) => {
    try {
        const { email, name, password, flatNo, street, city, state, pincode } = req.body;
        const otp = Math.floor(100000 + Math.random() * 900000);

        const user = new User({
            email,
            password,
            name,
            otp,
            address: {
                flatNo, street, city, state, pincode
            }
        });

        await user.save();

        var mailOptions = {
            from: EMAIL,
            to: req.body.email,
            subject: "Verification",
            text: `Your ONE TIME PASSWORD(OTP) for successfull signin is ${otp}`,
        };

        sender.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });

        return res.status(201).json({ message: 'OTP sent to your email' });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while creating user',
            error: error
        });
    }
};

const signin = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({
                message: 'Please fill all the fields'
            });
        }
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }

        const isPasswordValid = user.comparePassword(password);
        if (!isPasswordValid) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }
        if (!user.isVerified) {
            return res.status(401).json({ message: 'Email not verified' });
        }
        const token = await user.generateToken();
        user.password = undefined;
        return res.status(200).json({
            message: 'Login successful',
            token,
            user: user
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while signing in',
            error: error
        });
    }
};

const verifyOtp = async (req, res) => {
    try {
        const { email, otp } = req.body;
        if (!otp) {
            return res.status(400).json({
                message: 'Please fill all the fields'
            });
        }

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        if (otp == user.otp) {
            user.isVerified = true;
            user.otp = null;
            await user.save();
            const token = await user.generateToken();
            user.password = undefined;
            return res.status(200).json({
                user: user,
                token,
                message: 'OTP verified and successfully signed up'
            });
        }
        else {
            return res.status(400).json({
                message: 'Invalid OTP'
            });
        }
    } catch (error) {
        return res.status(500).json({
            message: 'Error while verifying OTP',
            error: error
        });
    }
};

const updateDetails = async (req, res) => {
    const userId = req.user._id;

    try {
        const updatedUser = await User.findByIdAndUpdate(userId, req.body , { new: true });

        if (!updatedUser) {
            return res.status(404).json({ error: 'User not found' });
        }

        return res.json(updatedUser);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error' });
    }
}

const getTimeSlots = async (req, res) => {
    try {
        console.log('in get time slots')
        const userId = req.user._id;
        console.log(userId);
        const user = await User.findById(userId);
        console.log(user);
        const agent = await Agent.findOne({ pickupPoints: user.address.pincode });
        console.log(agent);
        if (!agent) {
            return res.status(404).json({ message: 'Currently No service is available in this area. Please stay tuned' });
        }
        agent.password = undefined;
        return res.status(200).json(agent);
    } catch (error) {
        return res.status(500).json({
            message: 'Error while getting time slots',
            error: error

        });
    }
};

const getUser = async (req, res) => {
    try {
        const userId = req.user._id;
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: 'no user is available' });
        }
        user.password = undefined;
        return res.status(200).json(user);
    } catch (error) {
        return res.status(500).json({
            message: 'Error while getting time slots',
            error: error

        });
    }
};


module.exports = {
    createUser,
    signin,
    verifyOtp,
    updateDetails,
    getTimeSlots,
    getUser
}