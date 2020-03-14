import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados";

  void _reiniciarCampos(){
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calcularIMC(){

    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      var imc = peso / (altura * altura);

      if (imc < 18.6)
        _info = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      else if (imc >= 18.6 && imc < 24.9)
        _info = "Peso ideal (${imc.toStringAsPrecision(2)})";
      else if (imc >= 24.9 && imc < 29.9)
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      else if (imc >= 29.9 && imc < 34.9)
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      else if (imc >= 34.9 && imc < 39.9)
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      else if (imc >= 40)
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,

        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reiniciarCampos,
          ),
        ],
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.blue,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: pesoController,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                validator: (value) {
                  if(value.isEmpty)
                    return "Insira seu peso";
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: alturaController,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.blue)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25),
                validator: (value) {
                  if(value.isEmpty)
                    return "Insira sua altura";
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        _calcularIMC();
                    },
                    child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.blue,
                  ),
                ),
              ),
              Text("$_info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              )

            ],
          ),
        )
      )
    );
  }
}