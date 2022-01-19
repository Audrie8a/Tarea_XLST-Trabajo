var express = require("express");
const morgan = require("morgan");
const bodyParser = require("body-parser");

const deriveRoute = require("./routes/derive.routes");

var app = express();
const cors = require("cors");
const port = 5000;

app.use(morgan("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

//Rutas
app.get("/", function (req, res) {
  res.send("Bienvenido");
});

app.use("", deriveRoute);

app.listen(port, function () {
  console.log("Listening on port", port);
});
