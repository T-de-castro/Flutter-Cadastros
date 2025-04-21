import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Classes/Cliente.dart';
import 'Classes/Servico.dart';
import 'Classes/OS.dart';

class bdm1 {
  static Database? _bd;

  // 1. Getter para acessar ou criar o banco
  Future<Database> get database async {
    if (_bd != null) return _bd!;
    _bd = await _initDB(); // Se ainda não existe, cria
    return _bd!;
  }

  // 2. Define o nome e a estrutura do banco
  Future<Database> _initDB() async {
    // Define o caminho do banco, e o nome do arquivo como "bancom1.db"
    String path = join(await getDatabasesPath(), 'bancom1.db');

    // Abre o banco e cria a tabela se não existir
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // 3. Cria as tabelas ao iniciar o banco
  Future<void> _onCreate(Database bd, int version) async {
    // Certifique-se de que a tabela cliente está correta
    await bd.execute('''
      CREATE TABLE cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        endereco TEXT NOT NULL,
        telefone TEXT NOT NULL
      )
    ''');
    await bd.execute('''
      CREATE TABLE servico (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT NOT NULL,
        precohora DECIMAL NOT NULL
      )
    ''');

    await bd.execute('''
      CREATE TABLE OS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quantidade DECIMAL NOT NULL,
        precoservico DECIMAL NOT NULL,
        data TEXT NOT NULL DEFAULT (CURRENT_DATE),
        idCliente int NOT NULL,
        idServico int NOT NULL
      )
    ''');

    await bd.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT
      )
    ''');
  }

  //USUÁRIO
  Future<void> inserirUsuario(String nome) async {
    final db = await database;

    // Verifica se já existe algum usuário salvo
    final resultado = await db.query('usuario');

    if (resultado.isEmpty) {
      // Se não existe, insere
      await db.insert('usuario', {'nome': nome});
    } else {
      // Se já existe, atualiza o primeiro registro
      await db.update(
        'usuario',
        {'nome': nome},
        where: 'id = ?',
        whereArgs: [resultado.first['id']],
      );
    }
  }

  Future<String?> buscarUsuario() async {
    final db = await database;

    final resultado = await db.query('usuario', limit: 1);
    if (resultado.isNotEmpty) {
      return resultado.first['nome'] as String?;
    } else {
      return null;
    }
  }

  //CLIENTES
  // 4. Inserir um dado na tabela
  Future<void> inserirCliente(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.insert('cliente', dados);
  }

  // 5. Buscar todos os clientes
  Future<List<Cliente>> listarClientes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cliente');

    return List.generate(maps.length, (i) {
      return Cliente.fromMap(
        maps[i],
      ); // Usando o método fromMap para criar um Cliente
    });
  }

  // 6. Atualizar um cliente
  Future<void> atualizarCliente(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.update(
      'cliente',
      dados,
      where: 'id = ?',
      whereArgs: [dados['id']],
    );
  }

  // 7. Deletar um cliente
  Future<void> deletarCliente(int id) async {
    final bd = await database;
    await bd.delete('cliente', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deletarBanco() async {
    String path = join(await getDatabasesPath(), 'bancom1.db');
    await deleteDatabase(path);
    print('Banco deletado!');
  }

  //SERVICOS

  // 8. Inserir um dado na tabela
  Future<void> inserirServico(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.insert('servico', dados);
  }

  // 9. Buscar todos os Serviços
  Future<List<Servico>> listarServicos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('servico');

    return List.generate(maps.length, (i) {
      return Servico.fromMap(
        maps[i],
      ); // Usando o método fromMap para criar um servico
    });
  }

  // 10. Atualizar um servico
  Future<void> atualizarServico(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.update(
      'servico',
      dados,
      where: 'id = ?',
      whereArgs: [dados['id']],
    );
  }

  // 11. Deletar um servico
  Future<void> deletarServico(int id) async {
    final bd = await database;
    await bd.delete('servico', where: 'id = ?', whereArgs: [id]);
  }

  //ORDEM DE SERVIÇO

  // 12. Inserir um dado na tabela
  Future<void> inserirOS(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.insert('OS', dados);
  }

  // 13. Buscar todas as Os
  Future<List<OS>> listarOS() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      OS.id, 
      OS.idCliente, 
      OS.idServico, 
      OS.quantidade, 
      OS.precoservico, 
      OS.data,
      c.nome AS nomeCliente,
      s.descricao AS nomeServico
    FROM OS
    JOIN cliente c ON OS.idCliente = c.id
    JOIN servico s ON OS.idServico = s.id
  ''');

    return List.generate(maps.length, (i) {
      return OS.fromMap(maps[i]);
    });
  }

  // 14. Atualizar uma Os
  Future<void> atualizarOS(Map<String, dynamic> dados) async {
    final bd = await database;
    await bd.update('OS', dados, where: 'id = ?', whereArgs: [dados['id']]);
  }

  // 15. Deletar uma Os
  Future<void> deletarOS(int id) async {
    final bd = await database;
    await bd.delete('OS', where: 'id = ?', whereArgs: [id]);
  }
}
