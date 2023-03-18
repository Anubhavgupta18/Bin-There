const mongoose = require('mongoose');

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


const Report = mongoose.model('Report', reportSchema);

module.exports = Report;
