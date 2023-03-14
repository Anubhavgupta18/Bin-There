const validateUser = async (req, res, next) => {
    if (!req.body.email.includes('@')) {
        return res.status(400).json({
            message: 'Please enter a valid email'
        });
    }
    if (!req.body.email || !req.body.password || !req.body.name) {
        return res.status(400).json({
            message: 'Please fill all the fields'
        });
    }
    next();
}

const authenticateUser = async (req, res, next) => {
    passport.authenticate('jwt', (err, user) => {
        if(err) next(err);
        if (!user) {
            return res.status(401).json({
                message: 'Unauthorised access no token'
            })
        }
        req.user = user;
        next();
    })(req, res, next);
}

module.exports = {
    validateUser,
    authenticateUser
}