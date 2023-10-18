import 'package:flutter/material.dart';
import 'imc_data.dart'; // Importe a classe IMCData

class IMCListScreen extends StatefulWidget {
  @override
  _IMCListScreenState createState() => _IMCListScreenState();
}

class _IMCListScreenState extends State<IMCListScreen> {
  @override
  Widget build(BuildContext context) {
    // Recupere a lista de dados de IMC do Hive aqui

    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico de IMC"),
      ),
      body: Center(
        // Exiba a lista de IMCs gravados
        child: Text("Aqui você exibirá a lista de IMCs gravados."),
      ),
    );
  }
}

