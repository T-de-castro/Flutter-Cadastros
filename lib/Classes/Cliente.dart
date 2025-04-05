// lib/models/cliente.dart

class Cliente {
  final int id;
  final String nome;
  final String endereco;
  final String telefone;

  // Construtor
  Cliente({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
  });

  // Factory para criar um Cliente a partir de um Map (do banco de dados)
  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      endereco: map['endereco'],
      telefone: map['telefone'],
    );
  }

  // Método para converter um Cliente para um Map (para inserir no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
    };
  }
}