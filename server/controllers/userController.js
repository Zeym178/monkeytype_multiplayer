const asyncHandler = require("express-async-handler");
const User = require("../models/userModel.js");
const bcrypt = require("bcrypt");

//@desc register new user
//@route /api/users/register
//@access public
const registerUser = asyncHandler(async (req, res) => {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
        res.status(400);
        throw new Error("All field are mandatory!");
    }

    const check = await User.findOne({ email: email });

    if (check) {
        res.status(400);
        throw new Error("The email is already registered");
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = await User.create({
        username,
        email,
        password: hashedPassword,
    });

    if (newUser) {
        console.log("New user has been created!");
        res.status(201).json({ _id: newUser._id, username: newUser.username, email: newUser.email });
    } else {
        res.status(400);
        throw new Error("The data is not valid");
    }
});

module.exports = {
    registerUser,
}