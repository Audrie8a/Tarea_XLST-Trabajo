const xml2js = require("xml2js");

var operadores = [
  "plus",
  "substraction",
  "subs",
  "times",
  "division",
  "div",
  "power",
  "pow",
];

var funciones = ["log", "sin", "cos", "tan", "sin", "cot", "sec", "cosec"];

//Obtiene el arbol de etiquetas
exports.TreeXml = (Entrada) => {
  try {
    //Convertir xml a Json
    xml2js.parseString(Entrada, (err, result) => {
      if (err) {
        throw err;
      }

      const jsonObj = JSON.stringify(result, null, 4);
      // console.log(jsonObj);
      const json = JSON.parse(jsonObj);
      const expresion = StructTree(json, "Padre-> ", 1, "", "", "", 0);
      console.log(expresion);
    });

    return { msm: "Derivado!", respuesta: "Derivado!" };
  } catch (error) {
    console.log(error);
    return {
      msm: "Error al derivar, Sintaxis xml erronea!",
      respuesta: "No se logró derivar!",
    };
  }
};

function StructTree(json, etq, numTabs, padre, hijoIzq, hijoDer) {
  for (var key in json) {
    if (key != "0") {
      console.log(etq + key);
      for (op in operadores) {
        if (key == operadores[op]) {
          padre = key;
          break;
        }
      }
    }

    if (json[key] == "[object Object]") {
      let auxStr = JSON.stringify(json[key]);
      let aux = JSON.parse(auxStr);
      let contador = numTabs;
      let tabs = "";
      while (contador != 0) {
        tabs += "\t";
        contador--;
      }

      StructTree(aux, tabs + "hijo -> ", numTabs + 1, padre, hijoIzq, hijoDer);
    } else {
      let contador = numTabs;
      let tabs = "";
      while (contador != 0) {
        tabs += "\t";
        contador--;
      }
      console.log(tabs + "\tvalor -> " + json[key]);
    }
  }
}
