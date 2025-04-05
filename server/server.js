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
const rooms = new Set();
rooms.add("public");

io.on("connection", (socket) => {
    console.log("The user " + socket.id + " is connected!");
    connectedUsers.add(socket.id);
    io.emit("connected-users", Array.from(connectedUsers));
    socket.on("disconnect", () => {
        console.log("The user " + socket.id + " has disconnected");
        connectedUsers.delete(socket.id);
        // io.emit("connected-users", connectedUsers.size);
        io.emit("connected-users", Array.from(connectedUsers));
    });

    socket.on("create-room", (roomName) => {
        const roomExist = rooms.has(roomName);

        if (!roomExist) {
            rooms.add(roomName);
            console.log("The room: " + roomName + " has been created successfully by: " + socket.id);
        } else {
            console.log("The name of the room has already been taken :(");
        }
    });

    socket.on("join-socket", (roomName) => {
        const roomExist = rooms.has(roomName);

        if (roomExist) {
            console.log("A new user has joined the " + roomName + " room");
            socket.join(roomName);
        } else {
            console.log("The room doesn't exist hahahah");
        }
    });

    socket.on("cpm", (data) => {
        const { roomName, cpm, percentage } = data;
        io.to(roomName).emit("cpm-received", { "data": { cpm: cpm, percentage: percentage }, sentBy: socket.id });
    });

    // socket.on("message", (data) => {
    //     console.log(data);
    //     socket.broadcast.emit("message-received", data);
    // });

    // socket.on("cpm", (data) => {
    //     var idk = { cpm: data, sentBy: socket.id };
    //     console.log(idk);
    //     // socket.broadcast.emit("cpm-received", { data: data, sentBy: socket.id });
    //     io.emit("cpm-received", { data: data, sentBy: socket.id });
    // });
});