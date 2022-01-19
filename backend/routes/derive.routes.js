const express = require("express");
const router = express.Router();
const deriveController = require("../controllers/derive.controllers");
router.post("/derive", deriveController.derive);

module.exports = router;
