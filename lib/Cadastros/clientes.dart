import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CadastroClientePage extends StatefulWidget {
  @override
    State<CadastroClientePage> createState() => _CadastroClientePage();

}

class _CadastroClientePage extends State<CadastroClientePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController telefoneController = MaskedTextController(mask: '(00) 00000-0000');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Cadastro de Clientes'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30), //Padding para todas as direções
            child: Column(
              children: [
                Text(
                  'Novo Cliente', 
                  style: TextStyle(fontSize: 25)
                ),
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(hintText: 'Nome'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(hintText: 'Endereco'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: telefoneController,
                  decoration: const InputDecoration(hintText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  child: Text('Incluir'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Listar/clientes');
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