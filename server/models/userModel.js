const mongoose = require("mongoose");

const User = mongoose.Schema({
    username: {
        type: String,
        require: [true, "This field is required"]
    },
    email: {
        type: String,
        require: [true, "This field is required"]
    },
    password: {
        type: String,
        require: [true, "this field is required"]
    }
}, {
    timestamps: true,
});

module.exports = new mongoose.model("User", User);
