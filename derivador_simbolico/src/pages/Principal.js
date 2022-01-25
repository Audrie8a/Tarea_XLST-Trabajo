import React from "react";
import Editor from "../components/Editor";
import axios from "axios";

class Principal extends React.Component {
  state = {
    data: "",
    answer: "",
  };

  //Envía los datos recibidos del Editor de entrada.
  fetchDerive = async () => {
    await axios
      .post("http://localhost:5000/derive", { data: this.state.data })
      .then((response) => {
        const { data } = response;
        let jsonObj = JSON.stringify(data);
        let { msm, respuesta } = JSON.parse(jsonObj);
        this.setState({
          ...this.state.answer,
          answer: respuesta,
        });
        //alert(msm);
      })
      .catch((error) => {
        console.log(error.message);
        //alert("Ocurrió un error al Derivar!");
      });
  };

  fetchDeriveXSLT = async () => {
    await axios
      .post("http://localhost:5000/deriveXSLT", { data: this.state.data })
      .then((response) => {
        const { data } = response;
        let jsonObj = JSON.stringify(data);
        let { msm, respuesta } = JSON.parse(jsonObj);
        this.setState({
          ...this.state.answer,
          answer: respuesta,
        });
        //alert(msm);
      })
      .catch((error) => {
        console.log(error.message);
        //alert("Ocurrió un error al Derivar!");
      });
  };
  handleChangeEvent = (e) => {
    this.setState({
      ...this.state,
      data: e.target.value,
    });
  };

  handleGetDataNode = async (e) => {
    e.preventDefault();
    await this.fetchDerive();
    console.log(this.state.answer);
  };

  handleGetDataXSLT = async (e) => {
    e.preventDefault();
    await this.fetchDeriveXSLT();
    console.log(this.state.answer);
  };

  handleLimpiar = (e) => {
    e.preventDefault();

    this.setState({
      ...this.state.answer,
      answer: "",
    });
  };
  render() {
    return (
      <div className="row">
        <div className="col-md">
          <Editor
            lstBotones={[
              [
                "Derivar XSLT",
                "btn btn-success btn-block",
                this.handleGetDataXSLT,
              ],
              [
                "Derivar Node",
                "btn btn-success btn-block",
                this.handleGetDataNode,
              ],
            ]}
            mode={false}
            placeholder="write here"
            handleChange={this.handleChangeEvent}
          />
        </div>
        <div className="col-md">
          <Editor
            lstBotones={[
              ["Limpiar", "btn btn-success btn-block", this.handleLimpiar],
            ]}
            mode={true}
            placeholder=""
            textValue={this.state.answer}
          />
        </div>
      </div>
    );
  }
}

export default Principal;
