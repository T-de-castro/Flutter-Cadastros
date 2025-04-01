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
              color: Colors.red,
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
            title: Text('Clientes'),
            children: <Widget> [
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Lista de Clientes'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Listar/clientes');
                }
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Cadastro de Clientes'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Cadastrar/clientes');
                }
              )
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.inventory_2_rounded),
            title: Text('Produtos'),
            children: <Widget> [
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Lista de Produtos'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Listar/produtos');
                }
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Cadastro de Produtos'),
                onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'Cadastrar/produtos');
                }
              )
            ],
          ),

        ]
      ),
    );
  }
}