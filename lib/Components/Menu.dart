import 'package:flutter/material.dart';
import 'package:aplicativo/bdm1.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String nomeUsuario = 'Nome do Usuário';

  @override
  void initState() {
    super.initState();
    _carregarNomeUsuario();
  }

  Future<void> _carregarNomeUsuario() async {
    final nome = await bdm1().buscarUsuario();
    setState(() {
      nomeUsuario = nome ?? 'Nome do Usuário';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Row(
              children: [
                Icon(Icons.account_circle, color: Colors.white, size: 80),
                SizedBox(width: 20),
                Flexible(
                  child: Text(
                    nomeUsuario,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'Home');
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.person),
            title: Text('Cadastros'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Clientes'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Listar/clientes');
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Serviços'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Listar/servicos');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.inventory_2_rounded),
            title: Text('Vendas'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Ordem de Serviço'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Listar/OS');
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Pedido de Venda'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'Vendas/pedidodevenda');
                },
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text(
              'Apagar Banco de Dados',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              await bdm1().deletarBanco();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Banco de dados apagado!')),
              );
              Navigator.pop(context); // Fecha o drawer
            },
          ),
        ],
      ),
    );
  }
}
