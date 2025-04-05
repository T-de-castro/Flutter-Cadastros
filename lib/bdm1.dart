import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Classes/Cliente.dart';
import 'Classes/Servico.dart';

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

  // 9. Buscar todos os clientes
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
}
