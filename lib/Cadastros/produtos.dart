import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';  // Importando a classe Menu

class CadastroProdutoPage extends StatefulWidget {
  @override
    State<CadastroProdutoPage> createState() => _CadastroProdutoPage();

}

class _CadastroProdutoPage extends State<CadastroProdutoPage> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController qtdeController = TextEditingController();
  final TextEditingController precovendaController = TextEditingController();
  final TextEditingController precocompraController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Cadastro de Produtos'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30), //Padding para todas as direções
            child: Column(
              children: [
                Text(
                  'Novo Produto', 
                  style: TextStyle(fontSize: 25)
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(hintText: 'Descricao'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: qtdeController,
                  decoration: const InputDecoration(hintText: 'Quantidade'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: precovendaController,
                  decoration: const InputDecoration(hintText: 'Preço de Venda'),
                ),
                SizedBox(height: 10),

                TextFormField(
                  controller: precocompraController,
                  decoration: const InputDecoration(hintText: 'Preço de Custo'),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  child: Text('Incluir'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Listar/produtos');
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