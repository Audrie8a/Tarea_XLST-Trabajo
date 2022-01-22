const fs = require("fs");
const math = require("mathjs");
const { xsltProcess, xmlParse } = require("xslt-processor");

const Arbol = require("./ArbolXml");

exports.Derivar = (xml) => {
  try {
    let xmlDerivada = getXSLT(xml);
    let tree_xslt = treeDerivada(xmlDerivada);
    let newEtq_XML = Arbol.NuevoXML(tree_xslt);
    return { mensaje: "Derivado!", respuesta: newEtq_XML };
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
  const xsl = read_Files("Derivada.xsl");

  const outXmlString = xsltProcess(xmlParse(xml), xmlParse(xsl));
  console.log(outXmlString);
  write_Files("Resultado_Derivada.html", outXmlString);
  return outXmlString;
}

function treeDerivada(expresion) {
  exp = null;
  for (element in expresion) {
    if (expresion[element].toLowerCase() != expresion[element].toUpperCase()) {
      exp = [expresion, expresion[element]];
      break;
    }
  }
  return math.derivative(exp[0], exp[1]);
}
