import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart'; // Importando a classe Menu
import 'package:aplicativo/Classes/Servico.dart';
import 'package:aplicativo/bdm1.dart';

class ListarServicosPage extends StatelessWidget {
  Future<List<Servico>> _listarServicos() async {
    return await bdm1().listarServicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Serviços'),
      ),
      drawer: Menu(),
      body: FutureBuilder<List<Servico>>(
        future: _listarServicos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                // O conteúdo da lista de serviços
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Se não houver dados, exibe a mensagem de "Nenhum serviço encontrado!"
                        if (snapshot.data!.isEmpty)
                          Center(child: Text('Nenhum serviço encontrado!')),

                        // Exibindo a lista de serviços
                        ...snapshot.data!.map((servico) {
                          return Container(
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
                                      servico.descricao,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Preço por Hora: R\$ ${servico.precohora.toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),

                // O botão fixo na parte inferior
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('Cadastrar/servicos');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Botão com borda circular
                      padding: EdgeInsets.all(
                        20,
                      ), // Espaçamento interno para aumentar o botão
                    ),
                    child: Icon(
                      Icons.add, // Ícone de adição
                      size: 30, // Ajuste o tamanho do ícone conforme necessário
                    ),
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
