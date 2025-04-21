import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:aplicativo/Classes/Servico.dart';
import 'package:aplicativo/bdm1.dart';

class ListarServicosPage extends StatefulWidget {
  @override
  _ListarServicosPageState createState() => _ListarServicosPageState();
}

class _ListarServicosPageState extends State<ListarServicosPage> {
  List<Servico> _listaServicos = [];

  @override
  void initState() {
    super.initState();
    _carregarServicos();
  }

  Future<void> _carregarServicos() async {
    final servicos = await bdm1().listarServicos();
    setState(() {
      _listaServicos = servicos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Serviços'),
      ),
      drawer: Menu(),
      body:
          _listaServicos.isEmpty
              ? Center(child: Text('Nenhum serviço encontrado!'))
              : SingleChildScrollView(
                child: Column(
                  children:
                      _listaServicos.map((servico) {
                        return Container(
                          width: 400,
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Dados do serviço
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          servico.descricao,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Preço por Hora: R\$ ${servico.precohora.toStringAsFixed(2)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Botão para Excluir
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          final confirm = await showDialog<
                                            bool
                                          >(
                                            context: context,
                                            builder:
                                                (ctx) => AlertDialog(
                                                  title: Text(
                                                    'Excluir Serviço',
                                                  ),
                                                  content: Text(
                                                    'Deseja realmente excluir este serviço?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.of(
                                                            ctx,
                                                          ).pop(false),
                                                      child: Text('Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.of(
                                                            ctx,
                                                          ).pop(true),
                                                      child: Text('Excluir'),
                                                    ),
                                                  ],
                                                ),
                                          );

                                          if (confirm == true) {
                                            await bdm1().deletarServico(
                                              servico.id!,
                                            );
                                            _carregarServicos();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Serviço excluído com sucesso!',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
      // Botão flutuante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushNamed('Cadastrar/servicos').then((_) => _carregarServicos());
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
