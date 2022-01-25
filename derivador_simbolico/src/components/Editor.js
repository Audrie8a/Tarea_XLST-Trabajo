import React from "react";
import BotonsList from "../components/BotonsList";

const Editor = ({
  lstBotones,
  func,
  handleChange,
  mode,
  placeholder,
  textValue,
}) => {
  return (
    <div className="container p-4">
      <div className="row">
        <div className="col-md-10">
          <div className="card card-body">
            <form onSubmit={func}>
              <div className="form-group">
                <textarea
                  name="description"
                  rows="24"
                  className="form-control"
                  placeholder={placeholder}
                  onChange={handleChange}
                  readOnly={mode}
                  value={textValue}
                ></textarea>
              </div>
              <br />
              <BotonsList botones={lstBotones} />
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Editor;
