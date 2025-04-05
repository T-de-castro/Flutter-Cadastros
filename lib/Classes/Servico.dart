// lib/models/servico.dart

class Servico {
  final int id;
  final String descricao;
  final double precohora;

  // Construtor
  Servico({required this.id, required this.descricao, required this.precohora});

  // Factory para criar um Servico a partir de um Map (do banco de dados)
  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'],
      descricao: map['descricao'],
      precohora: (map['precohora'] as num).toDouble(), // mais seguro
    );
  }

  // Método para converter um Servico para um Map (para inserir no banco de dados)
  Map<String, dynamic> toMap() {
    return {'id': id, 'descricao': descricao, 'precohora': precohora};
  }
}
