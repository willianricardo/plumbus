class ProdutoEntity {
  final String id;
  final bool ativo;
  final String descricao;
  final double valor;

  const ProdutoEntity({
    required this.id,
    required this.ativo,
    required this.descricao,
    required this.valor,
  });
}
