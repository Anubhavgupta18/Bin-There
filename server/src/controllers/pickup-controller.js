const Pickup = require('../models/pickup-model');
const sender = require('../configs/nodemailerConfig');
const { EMAIL } = require('../configs/serverConfig');
const User = require('../models/user-model');
const Agent = require('../models/agent-model');

const createPickup = async (req, res) => {
    try {
        const user = req.user._id;
        const { timeslot, agent } = req.body;
        const pickup = new Pickup({
            user,
            timeslot,
            agent
        });
        await pickup.save();
        return res.status(201).json({ pickup });
    } catch (error) {
        return res.status(500).json({
            message: 'Error while creating pickup',
            error: error
        });
    }
};

const updatePickup = async (req, res) => {
    try {
        const { pickUpId } = req.params;

        const pickupCheck = await Pickup.findById(pickUpId);

        if (!pickupCheck) {
            return res.status(404).json({
                message: 'Pickup not found'
            });
        }

        if (pickupCheck.pickUpStatus === 'approved' || pickupCheck.pickUpStatus === 'rejected') {
            return res.status(404).json({ message: `This pickup has been ${pickupCheck.pickUpStatus} and closed now so you can't edit it anymore` });
        }
        
        const pickup = await Pickup.findByIdAndUpdate(pickUpId, req.body, { new: true });
        
        const user = await User.findById(pickup.user);
        
        const agent = await Agent.findById(pickup.agent);
       
        var mailOptions = {
            from: EMAIL,
            to: user.email,
            subject: "Regarding Confirmation",
            text: `Your wastes has been collected from the agent side please confirm the wastes collection in the app`,
        };
       
        var mailOptions1 = {
            from: EMAIL,
            to: user.email,
            subject: "Regarding Pickup",
            text: `Your pickup is cancelled for the moment as we don't have any agent in that area working now please stay tuned`,
        };
       
        var mailOptions2 = {
            from: EMAIL,
            to: user.email,
            subject: "Regarding Pickup",
            text: `Thanks for choosing our services please rate us if you are happy`,
        };
      
        var mailOptions3 = {
            from: EMAIL,
            to: agent.email,
            subject: "Regarding Pickup",
            text: `Your pickup has not been approved by the user please contact him and complete the status`,
        };
     

        if (req.body.statusByAgent === 'false') {
          
            sender.sendMail(mailOptions1, function (error, info) {
                if (error) {
                    console.log(error);
                } else {
                    console.log('Email sent: ' + info.response);
                }
            });

            pickup.pickUpStatus = 'rejected';
            await pickup.save();
        }
        else if (req.body.statusByUser === 'false' && pickup.statusByAgent) {
        
            sender.sendMail(mailOptions3, function (error, info) {
                if (error) {
                    console.log(error);
                } else {
                    console.log('Email sent: ' + info.response);
                }
            });
        }
        else if (pickup.statusByAgent && !pickup.statusByUser) {
      
            sender.sendMail(mailOptions, function (error, info) {
                if (error) {
                    console.log(error);
                } else {
                    console.log('Email sent: ' + info.response);
                }
            });
        }
        else if (pickup.statusByAgent && pickup.statusByUser) {
        
            sender.sendMail(mailOptions2, function (error, info) {
                if (error) {
                    console.log(error);
                } else {
                    console.log('Email sent: ' + info.response);
                }
            });
            pickup.pickUpStatus = 'approved';
            await pickup.save();
        }

        return res.status(200).json({ pickup });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            message: 'Error while updating pickup',
            error: error
        });
    }
};

const findPickUpsByUserId = async (req, res) => {
    const userId = req.user!=null?req.user._id:null;
    const agentId = req.params.agentId

    
    
    try {
        if(agentId&&!userId){
        const pickups = await Pickup.find({ user: userId });
        if (!pickups) {
            return res.status(404).json({
                message: 'No Pickups available'
            })
        }
        res.status(201).json(pickups);}
        else{
            const pickups = await Pickup.find({ agent: agentId });
            if (!pickups) {
                return res.status(404).json({
                    message: 'No Pickups available'
                })
            }
            res.status(201).json(pickups);}
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

module.exports = {
    createPickup,
    updatePickup,
    findPickUpsByUserId
};
