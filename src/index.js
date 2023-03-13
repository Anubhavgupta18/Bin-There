const express = require('express');
const { connect } = require('./configs/dbConfig');
const { PORT } = require('./configs/serverConfig');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
    await connect();
    console.log('Mongodb server connected');
});

