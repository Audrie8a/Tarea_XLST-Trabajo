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

  handleChangeEvent = (e) => {
    this.setState({
      ...this.state,
      data: e.target.value,
    });
  };

  handleGetData = async (e) => {
    e.preventDefault();
    //console.log(this.state.data);
    await this.fetchDerive();

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
            name="Derivar"
            mode={false}
            placeholder="write here"
            func={this.handleGetData}
            handleChange={this.handleChangeEvent}
          />
        </div>
        <div className="col-md">
          <Editor
            name="Limpiar"
            mode={true}
            placeholder=""
            func={this.handleLimpiar}
            textValue={this.state.answer}
          />
        </div>
      </div>
    );
  }
}

export default Principal;
