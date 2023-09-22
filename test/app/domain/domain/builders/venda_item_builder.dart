import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/venda_item_entity.dart';

class VendaItemBuilder {
  static VendaItemEntity withValues({
    String id = '1',
    bool ativo = true,
    ProdutoEntity? produto,
    double quantidade = 1,
    double valorDescontoUnitario = 0,
    double valorAcrescimoUnitario = 0,
  }) {
    final vendaItem = VendaItemEntity(
      id: id,
      ativo: ativo,
    );

    if (produto != null) {
      vendaItem.setProduto(produto);
    }

    vendaItem.setQuantidade(quantidade);

    if (valorAcrescimoUnitario > 0) {
      vendaItem.setValorAcrescimoUnitario(valorAcrescimoUnitario);
    }

    if (valorDescontoUnitario > 0) {
      vendaItem.setValorDescontoUnitario(valorDescontoUnitario);
    }

    return vendaItem;
  }
}
