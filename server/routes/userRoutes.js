const express = require("express");
const route = express.Router();
const {registerUser} = require("../controllers/userController.js");

route.route("/register").post(registerUser);

module.exports = route;

