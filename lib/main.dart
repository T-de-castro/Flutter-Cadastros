import 'package:aplicativo/Cadastros/clientes.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:flutter/material.dart';
import 'Listar/clientes.dart';
import 'package:aplicativo/Cadastros/produtos.dart';
import 'package:aplicativo/Listar/produtos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        'Listar/clientes': (context) => ListarClientesPage(),
        'Home': (context) => MyHomePage(),
        'Cadastrar/clientes': (context) =>CadastroClientePage(),
        'Listar/produtos': (context) => ListarProdutosPage(),
        'Cadastrar/produtos': (context) =>CadastroProdutoPage(),

      },
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 0, 0),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget> [
          Container (
            padding: EdgeInsets.all(30),
            child: Text('Bem Vindo a tela Inicial!'),
          ) 
        ]
      ),
    );
  }
}


