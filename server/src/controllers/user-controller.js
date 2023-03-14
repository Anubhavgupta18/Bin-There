const User = require('../models/user-model');
const sender = require('../configs/nodemailerConfig');
const { EMAIL } = require('../configs/serverConfig');


const createUser = async (req, res) => {
    try {
        const { email, name, password } = req.body;
        const otp = Math.floor(100000 + Math.random() * 900000);

        const user = new User({
            email,
            password,
            name,
            otp
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
        return res.status(200).json({
            message: 'Login successful',
            token,
            name: user.name
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
            return res.status(200).json({
                name: user.name,
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


module.exports = {
    createUser,
    signin,
    verifyOtp
}