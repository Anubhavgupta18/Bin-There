const multer = require('multer');

module.exports = multer({
    storage: multer.diskStorage({}),
    fileFilter: (req, file, cb) => {
        if (!file.mimetype.match('image/jpeg|image/png|image/gif|image/webp')) {  //image/jpeg contains both jpeg and jpg
            console.log('wrong');
            console.log(file.mimetype);
            cb(new Error('File is not supported'), false)
            return
        }
        cb(null, true)
    }
})
