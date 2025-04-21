import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:aplicativo/Classes/OS.dart';
import 'package:aplicativo/bdm1.dart';

class ListarOSPage extends StatefulWidget {
  @override
  _ListarOSPageState createState() => _ListarOSPageState();
}

class _ListarOSPageState extends State<ListarOSPage> {
  List<OS> _listaOS = [];

  @override
  void initState() {
    super.initState();
    _carregarOS();
  }

  Future<void> _carregarOS() async {
    final os = await bdm1().listarOS();
    setState(() {
      _listaOS = os;
    });
  }

  String formatarData(DateTime data) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    return '${doisDigitos(data.day)}/${doisDigitos(data.month)}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Ordem de Serviço'),
      ),
      drawer: Menu(),
      body:
          _listaOS.isEmpty
              ? Center(child: Text('Nenhuma Ordem encontrada!'))
              : SingleChildScrollView(
                child: Column(
                  children:
                      _listaOS.map((os) {
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
                                  // Dados da OS
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Número da OS: ${os.id}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Cliente: ${os.nomeCliente ?? os.idCliente.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Serviço: ${os.nomeServico ?? os.idServico.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Quantidade: ${os.quantidade.toStringAsFixed(2)}',
                                        ),
                                        Text(
                                          'Preço por Hora: R\$ ${os.precoservico.toStringAsFixed(2)}',
                                        ),
                                        Text('Data: ${formatarData(os.data)}'),
                                        Text(
                                          'Total: R\$ ${os.total.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Botões
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
                                                  title: Text('Excluir OS'),
                                                  content: Text(
                                                    'Deseja realmente excluir esta OS?',
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
                                            await bdm1().deletarOS(os.id!);
                                            _carregarOS();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'OS excluída com sucesso!',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushNamed('Vendas/OS').then((_) => _carregarOS());
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
