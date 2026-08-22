//model da serie
class Serie {
  final int? id;
  final String titulo;
  final String categoria;
  final String descricao;

  Serie(
      {this.id,
      required this.titulo,
      required this.categoria,
      required this.descricao });
//transforma os dados do banco em objeto(serie)
  Serie.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        titulo = res["titulo"],
        categoria = res["categoria"],
        descricao = res["descricao"];
//transforma de novo para ser utilizado em operações
    Map<String, Object?> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'categoria': categoria,
      'descricao': descricao
    };
  }
} 