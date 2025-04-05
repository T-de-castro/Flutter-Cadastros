import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu

class PedidodeVendaPage extends StatefulWidget {
  @override
    State<PedidodeVendaPage> createState() => _PedidodeVendaPage();

}

class _PedidodeVendaPage extends State<PedidodeVendaPage> {
  final TextEditingController clienteController= TextEditingController();
  final TextEditingController precohoraController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Pedido de Venda'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30), //Padding para todas as direções
            child: Column(
              children: [
                Text(
                  'Em Desenvolvimento', 
                  style: TextStyle(fontSize: 25)
                ),
                TextFormField(
                  controller: clienteController,
                  decoration: const InputDecoration(hintText: 'Cliente'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: precohoraController,
                  decoration: const InputDecoration(hintText: 'Preço por Hora'),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  child: Text('Incluir'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Listar/servicos');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}