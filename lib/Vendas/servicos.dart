import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class VendasServicoPage extends StatefulWidget {
  @override
    State<VendasServicoPage> createState() => _VendasServicoPage();

}

class _VendasServicoPage extends State<VendasServicoPage> {
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController servicoController = TextEditingController();
  final TextEditingController qtdeController = MaskedTextController(mask: '00,00');
  final TextEditingController precohoraController= MaskedTextController(mask: '00,00');
  final TextEditingController dataController = MaskedTextController(mask: '00/00/0000');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação

  double Total = 0.0;

  void CalculaTotal(){
    final double qtde = double.tryParse(qtdeController.text.replaceAll(',', '.')) ?? 0.0;
    final double precohora = double.tryParse(precohoraController.text.replaceAll(',', '.')) ?? 0.0;

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
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: precohoraController,
                  decoration: const InputDecoration(hintText: 'Preço por hora'),
                  onChanged: (value) => CalculaTotal(),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: dataController,
                  decoration: const InputDecoration(hintText: 'Data'),
                  keyboardType: TextInputType.number,
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