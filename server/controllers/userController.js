const asyncHandler = require("express-async-handler");
const User = require("../models/userModel.js");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

//@desc register new user
//@route POST /api/users/register
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

//@desc login user
//@route POST /api/users/login
//@access public
const loginUser = asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        res.status(400);
        throw new Error("All the field are mandatory");
    }

    const check = await User.findOne({ email: email });

    if (check && await bcrypt.compare(password, check.password)) {
        console.log("A new user has logged in!");

        const token = jwt.sign({
            user: {
                username: check.username,
                email: check.email,
            }
        }, process.env.JWT_STRING);

        res.status(200).json({
            token
        });

    } else {
        res.status(401);
        throw new Error("The credentials are not valid!");
    }


});

const currentUser = asyncHandler(async (req, res) => {
    console.log("New user info given successfully");

    const user = req.user;

    res.status(200).json({ user });
});

module.exports = {
    registerUser,
    loginUser,
    currentUser
}