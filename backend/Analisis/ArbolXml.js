const xml2js = require("xml2js");
const math = require("mathjs");
const { index } = require("mathjs");

let resultInOrder = [];
let treeXml_Lst = [];
let expresionsLst = [];
let resultInOrderDerive = [];
let operadores = [
  ["+", "plus"],
  ["-", "subs"],
  ["*", "times"],
  ["/", "div"],
  ["^", "power"],
];

//Obtiene el arbol de etiquetas y lo deriva
exports.TreeXml = (Entrada) => {
  try {
    if (Entrada != "") {
      //Convertir xml a Json
      xml2js.parseString(Entrada, (err, result) => {
        if (err) {
          throw err;
        }

        const jsonObj = JSON.stringify(result, null, 4);
        //console.log(jsonObj);
        const json = JSON.parse(jsonObj);
        //const expresion = StructTree(json, "Padre-> ", 1, 0);

        //console.log(expresion);
        // inOrderTree(json, 0);
        Tree_Expresion(json);
      });

      return { msm: "Derivado!", respuesta: "Derivado!" };
    }
    return {
      msm: "Error al derivar, Entrada Vacía!",
      respuesta: "No se ha Ingresado información!",
    };
  } catch (error) {
    console.log(error);
    return {
      msm: "Error al derivar, Sintaxis xml erronea!",
      respuesta: "No se logró derivar!",
    };
  }
};

//Maneja el flujo de la derivada de la función obtenida del xml
function Tree_Expresion(xmlJson) {
  treeXml_Lst = [];
  let expresion = {
    value: "",
    izquierda: null,
    derecha: null,
  };
  if (xmlJson["functions"] != undefined) {
    for (var jsonKey in xmlJson["functions"]["f"]) {
      let json = xmlJson["functions"]["f"][jsonKey];
      expresion = StructTree(json, "");
      treeXml_Lst.push(expresion);
    }
  } else {
    let json = xmlJson["f"];
    expresion = StructTree(json, "");
    treeXml_Lst.push(expresion);
  }
  expresionsLst = [];
  treeXml_Lst.forEach((exp) => {
    resultInOrder = [];

    inOrderXML(exp);
    let derivada = deriveExp(exp_to_string(resultInOrder));
    structDeriveTree(derivada);
    expresionsLst.push(derivada, "");
  });
  console.log(expresionsLst);
}

// Genera Arbol de la nueva derivada
function structDeriveTree(derivada, padre) {
  for (node in derivada) {
    padre = derivada["op"];
    structDeriveTree(derivada["args"], padre);
  }
}
// Deriva Expresiones
function deriveExp(exp) {
  console.log(exp);
  return math.derivative(exp[0], exp[1]);
}

// Genera un árbol con los datos del archivo xml
function StructTree(json, padre) {
  for (let index = 0; index < Object.keys(json).length; index++) {
    let keys = Object.keys(json);
    let key = keys[index];
    let newPadre = key;
    let izq = null;
    let der = null;
    let hijo = null;
    if (typeof json == "object") {
      hijo = json[key];
    } else {
      hijo = json;
    }

    //Izquierda
    if (typeof hijo == "object") {
      if (hijo.hasOwnProperty("0")) {
        izq = StructTree(hijo[0], newPadre);
      } else {
        izq = StructTree(hijo, newPadre);
      }
    } else {
      // console.log(hijo);
      // console.log(padre);
      return {
        value: padre,
        izquierda: {
          value: hijo,
          izquierda: null,
          derecha: null,
        },
        derecha: null,
      };
    }

    key = keys[index + 1];
    if (typeof json == "object") {
      hijo = json[key];
    } else {
      hijo = json;
    }
    newPadre = key;
    //Derecha
    if (hijo != undefined) {
      if (typeof hijo == "object") {
        if (hijo.hasOwnProperty("0")) {
          der = StructTree(hijo[0], newPadre);
        } else {
          der = StructTree(hijo, newPadre);
        }
      } else {
        // console.log(hijo);
        // console.log(padre);
        return {
          value: padre,
          izquierda: {
            value: hijo,
            izquierda: null,
            derecha: null,
          },
          derecha: null,
        };
      }
    }

    return {
      value: padre,
      izquierda: izq,
      derecha: der,
    };
  }
}

// Guarda los datos del árbolXML en recorrido "in Order"
function inOrderXML(node) {
  if (node) {
    inOrderXML(node.izquierda);
    resultInOrder.push(node.value);
    inOrderXML(node.derecha);
  }
}

// Convierte el resultado de la lectura del árbon en una expresión
function exp_to_string(exp) {
  let expresion = "";
  let variable = "";
  for (let index = 0; index < exp.length; index++) {
    if (exp[index] != "const" && exp[index] != "var") {
      switch (exp[index]) {
        case "plus":
          expresion += "+";
          break;
        case "substraction":
          expresion += "-";
          break;
        case "subs":
          expresion += "-";
          break;
        case "times":
          expresion += "*";
          break;
        case "division":
          expresion += "/";
          break;
        case "div":
          expresion += "/";
          break;
        case "power":
          expresion += "^";
          break;
        case "pow":
          break;
        default:
          expresion += exp[index];
          break;
      }
    } else if (exp[index] == "var") {
      variable = exp[index - 1];
    }
  }
  return [expresion, variable];
}

//Obtiene las etiquetas del Nuevo XML
function Nuevas_etqXML_InOrden(nodo) {
  if (nodo) {
    if (nodo.hasOwnProperty("args")) {
      Nuevas_etqXML(nodo["args"][0]);
    }

    if (nodo.hasOwnProperty("op")) {
      resultInOrderDerive.push(nodo["op"]);
    } else if (nodo.hasOwnProperty("name")) {
      resultInOrderDerive.push(nodo["name"]);
    } else if (nodo.hasOwnProperty("value")) {
      resultInOrderDerive.push(nodo["value"]);
    }

    if (nodo.hasOwnProperty("args")) {
      Nuevas_etqXML(nodo["args"][1]);
    }
  }
}

function Nuevas_etqXML(nodo, contador) {
  if (nodo) {
    let tabs = "";
    let aux = contador + 1;
    let simbolo = "";
    while (aux != 0) {
      tabs += "\t";
      aux--;
    }
    if (nodo.hasOwnProperty("op")) {
      switch (nodo["op"]) {
        case "+":
          simbolo = "plus";
          break;
        case "-":
          simbolo = "subs";
          break;
        case "/":
          simbolo = "div";
          break;
        case "*":
          simbolo = "times";
          break;
        case "^":
          simbolo = "power";
          break;
        default:
          break;
      }
      resultInOrderDerive.push(tabs + "<" + simbolo + ">\n");
      console.log("<", simbolo, ">");
    } else if (nodo.hasOwnProperty("name")) {
      resultInOrderDerive.push(tabs + "<var>" + nodo["name"] + "</var>\n");
      console.log(tabs + "<var>" + nodo["name"] + "</var>");
      return;
    } else if (nodo.hasOwnProperty("value")) {
      resultInOrderDerive.push(tabs + "<const>" + nodo["value"] + "</const>\n");
      console.log(tabs + "<const>" + nodo["value"] + "</const>\n");
      return;
    }

    if (nodo.hasOwnProperty("args")) {
      for (etq in nodo["args"]) {
        Nuevas_etqXML(nodo["args"][etq], contador + 1);
      }
    }

    if (nodo.hasOwnProperty("op")) {
      resultInOrderDerive.push(tabs + "</" + simbolo + ">\n");
      console.log(tabs + "</", simbolo, ">");
    }
  }
}

exports.NuevoXML = (nodo) => {
  // Nuevas_etqXML_InOrden(nodo);
  // console.log("EtiquetasOrden: -------", resultInOrderDerive);
  resultInOrderDerive = [];
  Nuevas_etqXML(nodo, 0);
  console.log("Etiquetas: -------", resultInOrderDerive);
  let xml = construirXML();
  return xml;
};

function construirXML() {
  let xml = "";
  for (tag in resultInOrderDerive) {
    xml += resultInOrderDerive[tag];
  }

  return "<f>\n" + xml + "</f>";
}
