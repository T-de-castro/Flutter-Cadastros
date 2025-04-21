import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:aplicativo/bdm1.dart';

class CadastroServicoPage extends StatefulWidget {
  @override
  State<CadastroServicoPage> createState() => _CadastroServicoPage();
}

class _CadastroServicoPage extends State<CadastroServicoPage> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precohoraController = MaskedTextController(
    mask: '00,00',
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          // Linha com o botão de voltar e título
          Container(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text('Novo Serviço', style: TextStyle(fontSize: 25)),
                SizedBox(width: 48), // Espaço vazio para alinhar à direita
              ],
            ),
          ),
          // Campo Descrição com borda lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: descricaoController,
              decoration: const InputDecoration(
                hintText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          SizedBox(height: 10),
          // Campo Preço por hora com borda lateral
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: precohoraController,
              decoration: const InputDecoration(
                hintText: 'Preço por hora',
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
              if (descricaoController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preencha a Descrição!')),
                );
                return;
              }

              if (precohoraController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preencha o Preço por hora!')),
                );
                return;
              }

              // Converte a vírgula para ponto e tenta parsear como double
              String precoTexto =
                  precohoraController.text
                      .replaceAll('R\$', '')
                      .replaceAll(',', '.')
                      .trim();

              double? precoConvertido = double.tryParse(precoTexto);
              if (precoConvertido == null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Preço inválido!')));
                return;
              }

              final servico = {
                'descricao': descricaoController.text,
                'precohora': precoConvertido, // valor numérico real!
              };

              await bdm1().inserirServico(servico);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Serviço salvo com sucesso!')),
              );

              descricaoController.clear();
              precohoraController.clear();

              Navigator.of(context).pushNamed('Listar/servicos');
            },
          ),
        ],
      ),
    );
  }
}
