const jwt = require("jsonwebtoken");
const asyncHandler = require("express-async-handler");

const authHandler = asyncHandler(async (req, res, next) => {
    const header = req.headers.authorization || req.headers.Authorization;

    if (header && header.startsWith("Bearer")) {
        const token = header.split(" ")[1];
        await jwt.verify(token, process.env.JWT_STRING, (err, decoded) => {
            if (err) {
                res.status(401);
                throw new Error("The user is not authorized");
            }

            req.user = decoded.user;
            next();
        });

        if(!token) {
                res.status(401);
                throw new Error("There's no token");
        }
    } else {
        res.status(401);
        throw new Error("The user is not authorized");
    }
});

module.exports = authHandler;