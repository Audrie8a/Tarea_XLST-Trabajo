//const Analisis = require("../Analisis/ArbolXml");
const Analisis = require("../Analisis/Analisis");
const AnalisisXSLT = require("../Analisis/XSLT/Analisis");

exports.derive = async (req, res) => {
  try {
    const { data } = req.body;
    //const resAnalisis = Analisis.TreeXml(data);
    const resAnalisis = Analisis.Derivar(data);
    res.status(200).send(resAnalisis);
  } catch (error) {
    console.log("Error al derivar!");
    res.status(500).send(JSON({ mensaje: "Error al derivar!", error: error }));
  }
};

exports.deriveXSLT = async (req, res) => {
  try {
    const { data } = req.body;
    const resAnalisis = AnalisisXSLT.Derivar(data);
    res.status(200).send(resAnalisis);
  } catch (error) {
    console.log("Error al derivar!");
    res.status(500).send(JSON({ mensaje: "Error al derivar!", error: error }));
  }
};

// exports.derive_Node
