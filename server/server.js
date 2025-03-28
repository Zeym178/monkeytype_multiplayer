const express = require("express");
const errorHandler = require("./middlewares/errorHandler");
const dbConnection = require("./config/dbConnection.js");
const cors = require('cors');
const dotenv = require("dotenv").config();

dbConnection();

const app = express();

const port = process.env.PORT || 4000;

app.use(cors({
    origin: "*",
}));

app.use(express.json());
app.use("/api/users/", require("./routes/userRoutes.js"));
app.use(errorHandler);

const server = app.listen(port, () => {
    console.log("The server is running in the port: " + port);
});

const io = require("socket.io")(server);

const connectedUsers = new Set();

io.on("connection", (socket) => {
    console.log("The user " + socket.id + " is connected!");
    connectedUsers.add(socket.id);
    io.emit("connected-users", connectedUsers.size);
    socket.on("disconnect", () => {
        console.log("The user " + socket.id + " has disconnected");
        connectedUsers.delete(socket.id);
        io.emit("connected-users", connectedUsers.size);
    });

    socket.on("message", (data) => {
        console.log(data);
        socket.broadcast.emit("message-received", data);
    });

    socket.on("cpm", (data) => {
        var idk = { cpm: data, sentBy: socket.id };
        console.log(idk);
        socket.broadcast.emit("cpm-received", { cpm: data, sentBy: socket.id });
    });
});