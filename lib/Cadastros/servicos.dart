import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu

class CadastroServicoPage extends StatefulWidget {
  @override
    State<CadastroServicoPage> createState() => _CadastroServicoPage();

}

class _CadastroServicoPage extends State<CadastroServicoPage> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precohoraController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Cadastro de Serviços'),
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
                  controller: descricaoController,
                  decoration: const InputDecoration(hintText: 'Descricao'),
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