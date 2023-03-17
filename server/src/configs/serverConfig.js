const dotenv = require('dotenv');

dotenv.config();

module.exports = {
    PORT: process.env.PORT,
    MONGODB_URL: process.env.MONGODB_URL,
    JWT_SECRETKEY: process.env.JWT_SECRETKEY,
    EMAIL_ID:process.env.EMAIL_ID,
    EMAIL_PASS: process.env.EMAIL_PASS,
    AWS_REGION: process.env.AWS_REGION,
    AWS_SECRET_ACCESS_KEY: process.env.AWS_SECRET_ACCESS_KEY,
    AWS_ACCESS_KEY_ID: process.env.AWS_ACCESS_KEY_ID,
    BUCKET_NAME: process.env.BUCKET_NAME
}