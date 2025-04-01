import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu

class ListarClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Clientes'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // Centraliza os filhos no eixo vertical
              children: <Widget> [
                Text('Lista de Clientes'),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: Text('Novo'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Cadastrar/clientes');
                  },
                ),
              ]
            ),
          )
        ]
      )
        
    );
  }
}