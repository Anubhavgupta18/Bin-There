const Recycle = require('../models/recycle-model');

const updatePrice = async (req, res) => {
    try {
        const recycleReq = await Recycle.findByIdAndUpdate(req.params.id, req.body, { new: true });
        return res.status(200).json({
            message: 'price updated successfully',
            recycleReq
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error
        });
    }
}

const createRecycleReq = async (req, res) => {
    try {
        const payload = { ...req.body };
        payload.user = req.user._id;
        payload.agent = '6414c9fc500eb9c9a72a5358';
        const recycleReq = await Recycle.create(payload);
        return res.status(201).json({
            message: 'recycle request created successfully',
            recycleReq
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            error
        });
    }
}

module.exports = {
    updatePrice,
    createRecycleReq
}