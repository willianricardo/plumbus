import 'package:plumbus/app/domain/entities/venda_item_entity.dart';

class VendaEntity {
  final String id;
  final bool ativo;
  final int empresa;
  late String clienteId;
  final List<VendaItemEntity> _itens = [];

  VendaEntity({
    required this.id,
    required this.ativo,
    required this.empresa,
  });

  List<VendaItemEntity> get itens => _itens.toList();

  List<VendaItemEntity> get itensAtivos =>
      _itens.where((item) => item.ativo).toList();

  List<VendaItemEntity> get itensInativos =>
      _itens.where((item) => !item.ativo).toList();

  void addItem(VendaItemEntity item) {
    if (!possuiItem(item)) {
      _itens.add(item);
    }
  }

  bool possuiItem(VendaItemEntity item) =>
      _itens.any((element) => element.produto.id == item.produto.id);

  double getValorTotalBruto() {
    return itensAtivos
        .map((item) => item.valorTotalBruto)
        .reduce((value, element) => value + element);
  }

  double getValorTotalLiquido() {
    return itensAtivos
        .map((item) => item.valorTotalLiquido)
        .reduce((value, element) => value + element);
  }

  double getPercentualDesconto() {
    return itensAtivos
            .map((item) => item.percentualDesconto)
            .reduce((value, element) => value + element) /
        itensAtivos.length;
  }

  double getValorDesconto() {
    return itensAtivos
        .map((item) => item.valorDescontoTotal)
        .reduce((value, element) => value + element);
  }

  double getPercentualAcrescimo() {
    return itensAtivos
            .map((item) => item.percentualAcrescimo)
            .reduce((value, element) => value + element) /
        itensAtivos.length;
  }

  double getValorAcrescimo() {
    return itensAtivos
        .map((item) => item.valorAcrescimoTotal)
        .reduce((value, element) => value + element);
  }
}
