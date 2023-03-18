const aws = require('aws-sdk');
const multer = require("multer");
const multerS3 = require("multer-s3");
const { AWS_REGION,AWS_SECRET_ACCESS_KEY,AWS_ACCESS_KEY_ID,BUCKET_NAME } = require("./serverConfig");

aws.config.update({
    region: AWS_REGION,
    secretAccessKey: AWS_SECRET_ACCESS_KEY,
    accessKeyId: AWS_ACCESS_KEY_ID
});

const s3 = new aws.S3();

const upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: BUCKET_NAME,
        acl: 'public-read',
        metadata: function (req, file, cb) {
            cb(null, {fieldName: file.fieldname});
        },
          key: function (req, file, cb) {
            cb(null, Date.now().toString())
        }
    })
})

module.exports = {
    upload
}