import 'package:flutter/material.dart';
import 'package:aplicativo/Components/Menu.dart'; // Importando a classe Menu
import 'package:aplicativo/bdm1.dart';
import 'package:aplicativo/Classes/Cliente.dart';

class ListarClientesPage extends StatelessWidget {
  // Função para listar os clientes
  Future<List<Cliente>> _listarClientes() async {
    return await bdm1().listarClientes();
  }

  // Função para excluir um cliente
  void _excluirCliente(BuildContext context, int clienteId) async {
    // Exibe um dialog de confirmação antes de excluir
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja excluir este cliente?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Deletar o cliente
                await bdm1().deletarCliente(clienteId);

                // Fechar o diálogo
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cliente excluído com sucesso!')),
                );

                // Recarregar a lista de clientes
                (context as Element).markNeedsBuild();
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
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
            // Usar ListView para garantir rolagem e melhor controle de layout
            return snapshot.data!.isEmpty
                ? Center(child: Text('Nenhum cliente encontrado!'))
                : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var cliente = snapshot.data![index];
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Este Row coloca o texto à esquerda e o IconButton à direita
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween, // Espaça entre os itens
                                children: [
                                  // Nome do cliente
                                  Text(
                                    cliente.nome,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Botão de excluir à direita
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _excluirCliente(context, cliente.id);
                                    },
                                  ),
                                ],
                              ),
                              // Restante dos detalhes do cliente
                              Text('Endereço: ${cliente.endereco}'),
                              Text('Telefone: ${cliente.telefone}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
          }
        },
      ),
      // Botão flutuante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('Cadastrar/clientes');
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
