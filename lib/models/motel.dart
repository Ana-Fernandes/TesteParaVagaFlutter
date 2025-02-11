class Motel {
  final String nome;
  final double precoMinimo;
  final List<String> fotos;

  Motel({
    required this.nome,
    required this.precoMinimo,
    required this.fotos,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      nome: json['nome'] ?? 'Sem Nome',
      precoMinimo: (json['periodos'] != null && json['periodos'].isNotEmpty)
          ? (json['periodos'][0]['valor'] as num).toDouble()
          : 0.0,
      fotos: List<String>.from(json['fotos'] ?? []),
    );
  }
}
