import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart'; // Importando a classe Menu
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:aplicativo/bdm1.dart';

class CadastroClientePage extends StatefulWidget {
  @override
  State<CadastroClientePage> createState() => _CadastroClientePage();
}

class _CadastroClientePage extends State<CadastroClientePage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController telefoneController = MaskedTextController(
    mask: '(00) 00000-0000',
  );

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Adicionando chave para validação

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
          // Linha com o botão de voltar e título
          Container(
            padding: EdgeInsets.all(30), //Padding para todas as direções
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text('Novo Cliente', style: TextStyle(fontSize: 25)),
                SizedBox(width: 48), // Espaço vazio para alinhar à direita
              ],
            ),
          ),
          // Campo Nome com borda lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                hintText: 'Nome',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          SizedBox(height: 10),
          // Campo Endereço com borda lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: enderecoController,
              decoration: const InputDecoration(
                hintText: 'Endereço',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          SizedBox(height: 10),
          // Campo Telefone com borda lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: telefoneController,
              decoration: const InputDecoration(
                hintText: 'Telefone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 10),
          // Botão Incluir
          ElevatedButton(
            child: Text('Incluir'),
            onPressed: () async {
              // Validar os campos vazios
              if (nomeController.text.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Preencha o nome!')));
                return;
              }
              if (enderecoController.text.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Preencha o Endereço!')));
                return;
              }

              if (telefoneController.text.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Preencha o Telefone!')));
                return;
              }

              // Criar a variável que manda os dados para a função
              final cliente = {
                'nome': nomeController.text,
                'endereco': enderecoController.text,
                'telefone': telefoneController.text,
              };

              // Chama a função para cadastrar no Banco
              await bdm1().inserirCliente(cliente);

              // Mensagem de sucesso
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cliente salvo com sucesso!')),
              );

              // Limpar os campos do cadastro
              nomeController.clear();
              enderecoController.clear();
              telefoneController.clear();

              // Voltar para a tela de lista de clientes
              Navigator.of(context).pushNamed('Listar/clientes');
            },
          ),
        ],
      ),
    );
  }
}
