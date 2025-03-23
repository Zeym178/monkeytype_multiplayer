const mongoose = require("mongoose");
const asyncHandler = require("express-async-handler");

const dbConnection = asyncHandler(async () => {
    const connection = await mongoose.connect(process.env.DB_STRING);

    console.log("The server is connected ",
        connection.connection.host,
        connection.connection.name
    );
});

module.exports = dbConnection;