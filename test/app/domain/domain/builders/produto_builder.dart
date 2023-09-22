import 'package:plumbus/app/domain/entities/produto_entity.dart';

class ProdutoBuilder {
  static ProdutoEntity withValues({
    String id = '1',
    double valor = 0,
    bool ativo = true,
    String descricao = 'test',
  }) {
    return ProdutoEntity(
      id: id,
      ativo: ativo,
      descricao: descricao,
      valor: valor,
    );
  }
}
