import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart'; // Importando a classe Menu
import 'package:aplicativo/bdm1.dart';
import 'package:aplicativo/Classes/Cliente.dart';

class ListarClientesPage extends StatelessWidget {
  // Função para listar os clientes
  Future<List<Cliente>> _listarClientes() async {
    return await bdm1().listarClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Clientes'),
      ),
      drawer: Menu(),
      body: FutureBuilder<List<Cliente>>(
        future: _listarClientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                // O conteúdo da lista de clientes
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Se não houver dados, exibe a mensagem de "Nenhum cliente encontrado!"
                        if (snapshot.data!.isEmpty)
                          Center(child: Text('Nenhum cliente encontrado!')),

                        // Exibindo a lista de clientes
                        ...snapshot.data!.map((cliente) {
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
                                      cliente.nome,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Endereço: ${cliente.endereco}'),
                                    Text('Telefone: ${cliente.telefone}'),
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
                      Navigator.of(context).pushNamed('Cadastrar/clientes');
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
