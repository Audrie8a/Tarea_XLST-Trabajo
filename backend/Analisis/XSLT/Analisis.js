const fs = require("fs");
const math = require("mathjs");
const { xsltProcess, xmlParse } = require("xslt-processor");

exports.Derivar = (xml) => {
  try {
    let xmlDerivada = getXSLT(xml);
    const searchRegExp = /_/gi;
    return {
      mensaje: "Derivado!",
      respuesta: xmlDerivada.replace(searchRegExp, " "),
    };
  } catch (error) {
    console.log(error);
    return { mensaje: "Error", respuesta: "Error al Derivar!" };
  }
};

function write_Files(nombre, dato) {
  fs.writeFile(__dirname + `\\${nombre}`, dato, function (err) {
    if (err) {
      console.log(err);
      throw err;
      // return "Error al Guardar archivo!";
    }
    console.log("success");

    return "Archivo guardado!";
  });
}

function read_Files(name) {
  try {
    return fs.readFileSync(__dirname + `\\${name}`, "utf-8");
  } catch (error) {
    throw error;
  }
}

function getXSLT(xml) {
  const xsl = read_Files("DerivadaXSLT.xsl");

  const outXmlString = xsltProcess(xmlParse(xml), xmlParse(xsl));
  console.log(outXmlString);
  write_Files("Resultado.html", outXmlString);
  return outXmlString;
}
