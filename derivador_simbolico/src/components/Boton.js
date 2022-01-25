import React from "react";

const Boton = ({ name, estilo, func }) => {
  return (
    <input
      type="submit"
      className={estilo}
      // className="btn btn-success btn-block"
      name={"btn_" + name}
      value={name}
      onClick={func}
    />
  );
};

export default Boton;
