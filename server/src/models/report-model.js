const mongoose = require('mongoose');
const User = require('./user-model');
const Agent = require('./agent-model');

const reportSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    description: {
      type: String,
    },
    image: {
      url: String,
      public_id: String,
    },
    lat: {
      type: String,
      required: true
    },
    lon: {
      type: String,
      required: true
    },
    agent: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Agent',
    },
    status:{
      type: String,
      enum: ['reported', 'cleaned']
    }
  },
  {
    timestamps: true,
  }
);

reportSchema.pre('save', function (next) {
  this.status = 'reported';
  next();
});

reportSchema.post('save', async function (doc, next) {
  const report = this;
  const user = await User.findById(report.user);
  const agent = await Agent.findOne({
    address: {
      pincode: user.address.pincode
    }
  });
  if (agent) {
    report.agent = agent._id;
    report.save();
  }
  next();
});

const Report = mongoose.model('Report', reportSchema);

module.exports = Report;
