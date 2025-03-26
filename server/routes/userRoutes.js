const express = require("express");
const route = express.Router();
const { registerUser, loginUser, currentUser } = require("../controllers/userController.js");
const authHandler = require("../middlewares/authHandler.js");

route.route("/login").post(loginUser);
route.route("/register").post(registerUser);
route.route("/current").get(authHandler, currentUser);

module.exports = route;

