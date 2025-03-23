const {constants} = require("../constants.js");

const errorHandler = (err, req, res, next) => {
    const status = res.statusCode ?? constants.SERVER_ERROR;

    switch (status) {
        case constants.BAD_REQUEST:
            res.json({
                title: "BAD REQUEST",
                message: err.message,
                stackTrace: err.stack
            });
            break;

        case constants.UNAUTHORIZED:
            res.json({
                title: "Unauthorized",
                message: err.message,
                stackTrace: err.stack
            });
            break;

        case constants.FORBIDDEN:
            res.json({
                title: "Forbidden",
                message: err.message,
                stackTrace: err.stack
            });
            break;
        case constants.BAD_REQUEST:
            res.json({
                title: "Not found",
                message: err.message,
                stackTrace: err.stack
            });
            break;
            
        case constants.SERVER_ERROR:
            res.json({
                title: "Server Error",
                message: err.message,
                stackTrace: err.stack
            });
            break;
        default:
            break;
    }
}

module.exports = errorHandler;