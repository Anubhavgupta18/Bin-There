const User = require('../models/user-model');
const sender = require('../configs/nodemailerConfig');
const { EMAIL } = require('../configs/serverConfig');

var otp,email,password,name;

const createUser = async (req, res) => {
    try {
        email = req.body.email;
        password = req.body.password;
        name = req.body.name;
        otp = Math.floor(100000 + Math.random() * 900000);

        var mailOptions = {
            from: EMAIL,
            to: req.body.email,
            subject: "Verification",
            text: `Your ONE TIME PASSWORD(OTP) fro successfull signin is ${otp}`,
        };

        sender.sendMail(mailOptions, function (error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });

        return res.status(201).json({ message: 'OTP sent to your email'});
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

const verifyOtp = async (req, res) => {    
    try {
        if (!req.body.otp) {
            return res.status(400).json({
                message: 'Please fill all the fields'
            });
        }

        if (req.body.otp == otp) {
            const user = await User.create({
                email,
                password,
                name
            });
            return res.status(200).json({
                user,
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