import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget> [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 69, 56),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(width: 20,),
                Text('Nome do Usuário')
              ],
            )
            ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'Home');
            }
          ),
          ExpansionTile(
            leading: Icon(Icons.person),
            title: Text('Cadastros'),
            children: <Widget> [
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Clientes'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Listar/clientes');
                }
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Serviços'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Listar/servicos');
                }
              )
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.inventory_2_rounded),
            title: Text('Vendas'),
            children: <Widget> [
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Ordem de Serviço'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Vendas/servicos');
                }
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Pedido de Venda'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Vendas/pedidodevenda');
                }
              )
            ],
          ),

        ]
      ),
    );
  }
}