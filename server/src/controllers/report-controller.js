const cloudinary = require('cloudinary').v2;
const Report = require('../models/report-model');

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
});

exports.createReport = async (req, res) => {
    const { description, lon, lat } = req.body;
    const user = req.user._id;
    const image = req.file;

    try {
        const uploadedImage = await cloudinary.uploader.upload(image.path);

        const report = new Report({
            user,
            description,
            image: {
                url: uploadedImage.secure_url,
                public_id: uploadedImage.public_id,
            },
            lat,
            lon
        });

        await report.save();
        res.status(201).json(report);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: error });
    }
};


exports.getAllReports = async (req, res) => {
    try {
        const reports = await Report.find();
        res.status(201).json(reports);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

exports.findReportsByUserId = async (req, res) => {
    const { userId } = req.params;

    try {
        const reports = await Report.find({ user: userId });
        res.json(reports);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};


exports.getReportById = async (req, res) => {
    const { id } = req.params;

    try {
        const report = await Report.findById(id).populate('user');
        if (!report) {
            return res.status(404).json({ error: 'Report not found' });
        }
        res.status(201).json(report);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};


exports.updateReport = async (req, res) => {
    const { id } = req.params;
    const { description, lat, lon } = req.body;

    try {
        const report = await Report.findById(id);
        if (!report) {
            return res.status(404).json({ error: 'Report not found' });
        }

        report.description = description || report.description;
        report.lat = lat || report.lat;
        report.lon = lon || report.lon;

        await report.save();
        res.json(report);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};


exports.deleteReport = async (req, res) => {
    const { id } = req.params;

    try {
        const report = await Report.findByIdAndDelete(id);
        if (!report) {
            return res.status(404).json({ error: 'Report not found' });
        }
        await cloudinary.uploader.destroy(report.image.public_id);

        res.json({ message: 'Report deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
