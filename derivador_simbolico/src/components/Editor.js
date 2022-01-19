import React from "react";

const Editor = ({ name, func, handleChange, mode, placeholder, textValue }) => {
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
              <input
                type="submit"
                className="btn btn-success btn-block"
                name={"btn_" + name}
                value={name}
              />
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Editor;
