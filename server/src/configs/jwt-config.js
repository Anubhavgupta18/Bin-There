const JWT = require('passport-jwt');
const User= require('../models/user-model.js');
const { JWT_SECRETKEY } = require("./serverConfig.js");

const JwtStrategy = JWT.Strategy;
const ExtractJwt = JWT.ExtractJwt;

const opts = {
    jwtFromRequest : ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey : JWT_SECRETKEY
}
const passportAuth = (passport) =>{
    passport.use(new JwtStrategy(opts , async (jwt_payload , done)=>{
        try {
            const user = await User.findById(jwt_payload.id);
            if(!user){
                done(null , false);
            }else {
                done(null , user);
            }
        } catch (error) {
                console.log(error);
                throw error ;
        }
    }))
}

module.exports = { passportAuth };