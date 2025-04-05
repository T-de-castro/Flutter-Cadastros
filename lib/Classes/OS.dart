class OS {
  final int? id;
  final int idCliente;
  final int idServico;
  final double quantidade;
  final double precoservico;
  final DateTime data;
  final String? nomeCliente;
  final String? nomeServico;

  double get total => quantidade * precoservico;

  OS({
    this.id,
    required this.idCliente,
    required this.idServico,
    required this.quantidade,
    required this.precoservico,
    required this.data,
    this.nomeCliente,
    this.nomeServico,
  });

  factory OS.fromMap(Map<String, dynamic> map) {
    return OS(
      id: map['id'],
      idCliente: map['idCliente'],
      idServico: map['idServico'],
      quantidade: (map['quantidade'] as num).toDouble(),
      precoservico: (map['precoservico'] as num).toDouble(),
      data: DateTime.parse(map['data']),
      nomeCliente: map['nomeCliente'],
      nomeServico: map['nomeServico'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idCliente': idCliente,
      'idServico': idServico,
      'quantidade': quantidade,
      'precoservico': precoservico,
      'data': data.toIso8601String(),
    };
  }
}
