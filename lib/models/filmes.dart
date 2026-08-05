class Filme {
  final int? id;
  final String titulo;
  final String categoria;
  final String descricao;
  final String? imagem;

  Filme(
      {this.id,
      required this.titulo,
      required this.categoria,
      required this.descricao,
      this.imagem});

  Filme.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        titulo = res["titulo"],
        categoria = res["categoria"],
        descricao = res["descricao"],
        imagem = res["imagem"];
        
    Map<String, Object?> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'categoria': categoria,
      'descricao': descricao,
      'imagem': imagem
    };
  }
} 