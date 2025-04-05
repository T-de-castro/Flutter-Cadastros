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
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text('Novo Serviço', style: TextStyle(fontSize: 25)),
                TextFormField(
                  controller: descricaoController,
                  decoration: const InputDecoration(hintText: 'Descrição'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: precohoraController,
                  decoration: const InputDecoration(hintText: 'Preço por hora'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Preço inválido!')),
                      );
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
          ),
        ],
      ),
    );
  }
}
