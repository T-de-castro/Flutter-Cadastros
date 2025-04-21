import 'package:aplicativo/Cadastros/clientes.dart';
import 'package:aplicativo/Components/Menu.dart';
import 'package:flutter/material.dart';
import 'Listar/clientes.dart';
import 'package:aplicativo/Cadastros/servicos.dart';
import 'package:aplicativo/Listar/servicos.dart';
import 'package:aplicativo/Vendas/pedidodevenda.dart';
import 'package:aplicativo/bdm1.dart';
import 'package:aplicativo/Cadastros/OS.dart';
import 'package:aplicativo/Listar/OS.dart';

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
        'Cadastrar/clientes': (context) => CadastroClientePage(),
        'Listar/servicos': (context) => ListarServicosPage(),
        'Cadastrar/servicos': (context) => CadastroServicoPage(),
        'Vendas/OS': (context) => VendasOSPage(),
        'Listar/OS': (context) => ListarOSPage(),
        'Vendas/pedidodevenda': (context) => PedidodeVendaPage(),
      },
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 106, 127, 245),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nomeUsuario = '';

  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }

  Future<void> _carregarNomeSalvo() async {
    final nome = await bdm1().buscarUsuario();
    setState(() {
      nomeUsuario = nome ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
      ),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bem-Vindo', style: TextStyle(fontSize: 25)),
                TextField(
                  decoration: InputDecoration(labelText: 'Digite seu nome'),
                  controller: TextEditingController(text: nomeUsuario),
                  onChanged: (valor) {
                    nomeUsuario = valor;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.save, color: Colors.white),
            label: Text('Salvar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () async {
              await bdm1().inserirUsuario(nomeUsuario);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Nome salvo com sucesso!')),
              );
              setState(() {}); // Atualiza se necessário
            },
          ),
        ],
      ),
    );
  }
}
