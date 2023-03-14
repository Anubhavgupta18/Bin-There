const express = require('express');
const { connect } = require('./configs/dbConfig');
const { PORT } = require('./configs/serverConfig');
const userRoutes = require('./routes/user-routes');
const pickupRoutes = require('./routes/pickup-routes');
const agentRoutes = require('./routes/agent-routes');
const bodyParser = require('body-parser');
const passport = require('passport');
const { passportAuth } = require('./configs/jwt-config');

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(passport.initialize());
passportAuth(passport);

app.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
    await connect();
    console.log('Mongodb server connected');
});

app.use('/api/users', userRoutes);
app.use('/api/agents', agentRoutes);
app.use('/api/pickups', pickupRoutes);