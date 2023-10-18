import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _info = "Informe seus dados.";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _resetFields() {
    setState(() {
      pesoController.text = '';
      alturaController.text = '';
      _info = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double? peso = double.tryParse(pesoController.text);
      double? altura = double.tryParse(alturaController.text) / 100;

      if (peso != null && altura != null) {
        double imc = peso / (altura * altura);
        print(imc);

        if (imc < 18.6) {
          _info = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 18.6 && imc < 24.9) {
          _info = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 24.9 && imc < 29.9) {
          _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 29.9 && imc < 34.9) {
          _info = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 34.9 && imc < 39.9) {
          _info = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
        } else if (imc >= 40) {
          _info = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcula IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Insira seu Peso!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (CM)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Insira sua Altura!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _calcular();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}

