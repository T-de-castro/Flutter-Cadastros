import 'package:aplicativo/Classes/Cliente.dart';
import 'package:aplicativo/Classes/Servico.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:aplicativo/bdm1.dart';
import 'package:aplicativo/Classes/OS.dart';

class VendasOSPage extends StatefulWidget {
  @override
  State<VendasOSPage> createState() => _VendasOSPage();
}

class _VendasOSPage extends State<VendasOSPage> {
  final TextEditingController quantidadeController = MaskedTextController(
    mask: '00,00',
  );
  final TextEditingController precoservicoController = MaskedTextController(
    mask: '00,00',
  );
  final TextEditingController dataController = MaskedTextController(
    mask: '00/00/0000',
  );
  final TextEditingController totalController = TextEditingController();

  void _atualizarTotal() {
    final quantidadeText = quantidadeController.text.replaceAll(',', '.');
    final precoText = precoservicoController.text.replaceAll(',', '.');

    final quantidade = double.tryParse(quantidadeText);
    final preco = double.tryParse(precoText);

    if (quantidade != null && preco != null) {
      final total = quantidade * preco;
      totalController.text = total.toStringAsFixed(2).replaceAll('.', ',');
    } else {
      totalController.text = '';
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Cliente> _clientes = [];
  Cliente? _clienteSelecionado;

  List<Servico> _servicos = [];
  Servico? _servicoSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarClientes();
    _carregarServicos();
  }

  Future<void> _carregarClientes() async {
    final clientes = await bdm1().listarClientes();
    setState(() {
      _clientes = clientes;
    });
  }

  Future<void> _carregarServicos() async {
    final servicos = await bdm1().listarServicos();
    setState(() {
      _servicos = servicos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Cadastro de Ordens de Serviço'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text('Nova OS', style: TextStyle(fontSize: 25)),
                DropdownButtonFormField<Cliente>(
                  decoration: InputDecoration(hintText: 'Selecione o Cliente'),
                  value: _clienteSelecionado,
                  onChanged: (Cliente? novoCliente) {
                    setState(() {
                      _clienteSelecionado = novoCliente;
                    });
                  },
                  items:
                      _clientes.map((cliente) {
                        return DropdownMenuItem<Cliente>(
                          value: cliente,
                          child: Text('${cliente.nome}'),
                        );
                      }).toList(),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<Servico>(
                  decoration: InputDecoration(hintText: 'Selecione o Serviço'),
                  value: _servicoSelecionado,
                  onChanged: (Servico? novoServico) {
                    setState(() {
                      _servicoSelecionado = novoServico;

                      if (novoServico != null) {
                        precoservicoController.text = novoServico.precohora
                            .toStringAsFixed(2)
                            .replaceAll('.', ',');

                        // Atualiza o total automaticamente se quiser
                        _atualizarTotal();
                      }
                    });
                  },
                  items:
                      _servicos.map((servico) {
                        return DropdownMenuItem<Servico>(
                          value: servico,
                          child: Text('${servico.descricao}'),
                        );
                      }).toList(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: quantidadeController,
                  decoration: const InputDecoration(hintText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _atualizarTotal(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: precoservicoController,
                  decoration: const InputDecoration(
                    hintText: 'Preço do Serviço',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _atualizarTotal(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: dataController,
                  decoration: const InputDecoration(hintText: 'Data'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: totalController,
                  decoration: const InputDecoration(
                    hintText: 'Total',
                    filled: true,
                    fillColor: Color(
                      0xFFF0F0F0,
                    ), // cor de fundo para parecer desabilitado
                  ),
                  readOnly: true,
                  enableInteractiveSelection: false, // impede seleção de texto
                ),
                ElevatedButton(
                  child: Text('Incluir'),
                  onPressed: () async {
                    if (_clienteSelecionado == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selecione um cliente!')),
                      );
                      return;
                    }

                    if (_servicoSelecionado == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selecione um serviço!')),
                      );
                      return;
                    }

                    // Converte a vírgula para ponto e tenta parsear como double
                    String quantidadeText =
                        quantidadeController.text
                            .replaceAll('R\$', '')
                            .replaceAll(',', '.')
                            .trim();

                    double? quantidadeConvertido = double.tryParse(
                      quantidadeText,
                    );
                    if (quantidadeConvertido == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Quantidade inválida!')),
                      );
                      return;
                    }

                    String precoservicoText =
                        precoservicoController.text
                            .replaceAll('R\$', '')
                            .replaceAll(',', '.')
                            .trim();

                    double? precoservicoConvertido = double.tryParse(
                      precoservicoText,
                    );

                    if (precoservicoConvertido == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Preço inválido!')),
                      );
                      return;
                    }

                    final novaOS = OS(
                      idCliente: _clienteSelecionado!.id!,
                      idServico: _servicoSelecionado!.id!,
                      quantidade: quantidadeConvertido,
                      precoservico: precoservicoConvertido,
                      data:
                          DateTime.now(), // ou parse de dataController se quiser usar
                    );

                    await bdm1().inserirOS(novaOS.toMap());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OS salva com sucesso!')),
                    );

                    quantidadeController.clear();
                    precoservicoController.clear();
                    dataController.clear();
                    totalController.clear();

                    Navigator.of(context).pushNamed('Listar/OS');
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
