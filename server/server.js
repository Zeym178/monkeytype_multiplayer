const express = require("express");
const errorHandler = require("./middlewares/errorHandler");
const dbConnection = require("./config/dbConnection.js");
const dotenv = require("dotenv").config();

dbConnection();
const app = express();
const port = process.env.PORT || 4000; 

app.use(express.json());
app.use("/api/users/", require("./routes/userRoutes.js"));
app.use(errorHandler);

const server = app.listen(port, () => {
    console.log("The server is running in the port: " + port);
});

// const io = require("socket.io")(server);

// io.on("connection", (socket) => {
//     console.log("The user " + socket + " is conncted!");
// });