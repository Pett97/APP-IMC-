import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      ;
      double IMC = weight / (height * height);

      _infoText = "IMC =(${IMC.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculadora IMC",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[900],
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh),
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 198, 199, 198),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person,
                    size: 120.0,
                    color: Colors.green[900],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "PESO EM KG",
                      hintText: "74.5",
                      labelStyle: TextStyle(color: Colors.green[900]),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                    controller: weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira seu Peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura em CM",
                        hintText: "Exemplo 186",
                        labelStyle: TextStyle(color: Colors.green[900])),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                    controller: heightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira sua altura";
                      }
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "IMC",
                        labelStyle: TextStyle(color: Colors.green[900])),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            calculate();
                          }
                        },
                        child: const Text('Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green[900], fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
