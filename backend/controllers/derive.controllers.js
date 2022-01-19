const Analisis = require("../Analisis/ArbolXml");

exports.derive = async (req, res) => {
  try {
    const { data } = req.body;
    const resAnalisis = Analisis.TreeXml(data);
    res.status(200).send(resAnalisis);
  } catch (error) {
    console.log("Error al derivar!");
    res.status(500).send(JSON({ mensaje: "Error al derivar!", error: error }));
  }
};
