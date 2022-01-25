import React from "react";
import Boton from "./Boton";
import "./styles/Editor.css";

const BotonsList = ({ botones }) => (
  <div>
    {/* ngFor Recorre el state */}
    {botones.map((btn) => {
      return (
        <div className="ListadoBtn">
          <Boton key={btn[0]} name={btn[0]} estilo={btn[1]} func={btn[2]} />
        </div>
      );
    })}
  </div>
);

export default BotonsList;
