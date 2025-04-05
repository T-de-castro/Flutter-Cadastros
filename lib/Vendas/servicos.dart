import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu

class VendasServicoPage extends StatefulWidget {
  @override
    State<VendasServicoPage> createState() => _VendasServicoPage();

}

class _VendasServicoPage extends State<VendasServicoPage> {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController servicoController = TextEditingController();
  final TextEditingController qtdeController = TextEditingController();
  final TextEditingController precohoraController= TextEditingController();
  final TextEditingController dataController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação

  double Total = 0.0;

  void CalculaTotal(){
    final double qtde = double.tryParse(qtdeController.text) ?? 0.0;
    final double precohora = double.tryParse(precohoraController.text) ?? 0.0;

    setState(() {
      Total = qtde * precohora;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Venda de Serviços'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30), //Padding para todas as direções
            child: Column(
              children: [
                Text(
                  'Novo Serviço', 
                  style: TextStyle(fontSize: 25)
                ),
                TextFormField(
                  controller: clienteController,
                  decoration: const InputDecoration(hintText: 'Cliente'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: servicoController,
                  decoration: const InputDecoration(hintText: 'Serviço'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: qtdeController,
                  decoration: const InputDecoration(hintText: 'Quantidade'),
                  onChanged: (value) => CalculaTotal(),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: precohoraController,
                  decoration: const InputDecoration(hintText: 'Preço por hora'),
                  onChanged: (value) => CalculaTotal(),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: dataController,
                  decoration: const InputDecoration(hintText: 'Data'),
                ),
                SizedBox(height: 10),

                Text(
                  'Total: ${Total.toStringAsFixed(2)}',
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