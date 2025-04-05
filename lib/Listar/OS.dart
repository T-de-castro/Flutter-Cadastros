import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart'; // Importando a classe Menu
import 'package:aplicativo/Classes/OS.dart';
import 'package:aplicativo/bdm1.dart';

class ListarOSPage extends StatelessWidget {
  Future<List<OS>> _listarOS() async {
    return await bdm1().listarOS();
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
      body: FutureBuilder<List<OS>>(
        future: _listarOS(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (snapshot.data!.isEmpty)
                          Center(child: Text('Nenhuma Ordem encontrada!')),
                        for (var os in snapshot.data!)
                          Container(
                            width: 400,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID OS: ${os.id}',
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
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('Vendas/OS');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(Icons.add, size: 30),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
