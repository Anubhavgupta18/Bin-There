const Agent = require('../models/agent-model');
const sender = require('../configs/nodemailerConfig');
const { EMAIL } = require('../configs/serverConfig');
const User = require('../models/user-model');


const createAgent = async (req, res) => {
    try {
        if (!req.body.email.includes('@')) {
            return res.status(400).json({
                message: 'Please enter a valid email'
            });
        }
        if (!req.body.email || !req.body.password || !req.body.name) {
            return res.status(400).json({
                message: 'Please fill all the fields'
            });
        }
        const agentExists = await Agent.findOne({ email:req.body.email });
        if (agentExists) {
           return res.status(400).json({ error: "Agent+ with this email already exists" });
        }
        const { email, name, password,flatNo,street,city,pincode,state,mobileNo, pickupPoints, timeslots } = req.body;
        const otp = Math.floor(100000 + Math.random() * 900000);

        const agent = new Agent({
            email,
            password,
            name,
            otp,
            mobileNo,
            address: {
                flatNo, street, city, state, pincode
            },
            pickupPoints,
            timeslots
        });

        await agent.save();

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
        const agent = await Agent.findOne({ email });
        if (!agent) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }

        const isPasswordValid = agent.comparePassword(password);
        if (!isPasswordValid) {
            return res.status(400).json({
                message: 'Invalid email or password'
            });
        }
        if (!agent.isVerified) {
            return res.status(401).json({ message: 'Email not verified' });
        }
        const token = await agent.generateToken();
        return res.status(200).json({
            message: 'Login successful',
            token,
            name: agent.name
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

        const agent = await Agent.findOne({ email });
        if (!agent) {
            return res.status(404).json({ message: 'User not found' });
        }

        if (otp == agent.otp) {
            agent.isVerified = true;
            agent.otp = null;
            await agent.save();
            const token = await agent.generateToken();
            return res.status(200).json({
                name: agent.name,
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

const getTimeSlots = async (req, res) => {
    try {
        const userId = req.user._id;
        const user = await User.findById(userId);
        console.log(user);
        const agent = await Agent.findOne({ pickupPoints: user.address.pincode });
        console.log(agent);
        if (!agent) {
            return res.status(404).json({ message: 'Currently No service is available in this area. Please stay tuned' });
        }
        // const timeSlots = agent.timeslots;
        // console.log(timeSlots)
        return res.status(200).json(agent);
    } catch (error) {
        return res.status(500).json({
            message: 'Error while getting time slots',
            error: error

        });
    }
};


module.exports = {
    createAgent,
    signin,
    verifyOtp,
    getTimeSlots
}