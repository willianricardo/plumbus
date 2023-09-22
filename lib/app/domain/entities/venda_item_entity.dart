import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/venda_entity.dart';

class VendaItemEntity {
  final String id;
  final bool ativo;
  late final int empresa;
  late final String vendaId;
  late final VendaEntity venda;
  late final String produtoId;
  late final ProdutoEntity produto;
  double _quantidade = 1;
  double _valorUnitarioLiquido = 0;
  double _valorUnitarioBruto = 0;
  double _valorDescontoUnitario = 0;
  double _valorAcrescimoUnitario = 0;

  VendaItemEntity({
    required this.id,
    required this.ativo,
  });

  void setVenda(VendaEntity venda) {
    this.venda = venda;
    empresa = venda.empresa;
    vendaId = venda.id;
  }

  void setProduto(ProdutoEntity produto) {
    _valorUnitarioBruto = produto.valor;
    _valorUnitarioLiquido = produto.valor;

    this.produto = produto;
    produtoId = produto.id;
  }

  void setQuantidade(double quantidade) {
    if (quantidade < 0) {
      _quantidade = 0.0;

      return;
    }

    _quantidade = quantidade;
  }

  void setValorDescontoUnitario(double valorDescontoUnitario) {
    _valorDescontoUnitario = valorDescontoUnitario;
    _valorUnitarioLiquido = _valorUnitarioBruto - _valorDescontoUnitario;
    _valorAcrescimoUnitario = 0.0;
  }

  void setPercentualDesconto(double percentualDesconto) {
    _valorDescontoUnitario = (_valorUnitarioBruto * percentualDesconto) / 100;
    _valorUnitarioLiquido = _valorUnitarioBruto - _valorDescontoUnitario;
    _valorAcrescimoUnitario = 0.0;
  }

  void setValorAcrescimoUnitario(double valorAcrescimoUnitario) {
    _valorAcrescimoUnitario = valorAcrescimoUnitario;
    _valorUnitarioLiquido = _valorUnitarioBruto + _valorAcrescimoUnitario;
    _valorDescontoUnitario = 0.0;
  }

  void setPercentualAcrescimo(double percentualAcrescimo) {
    _valorAcrescimoUnitario = (_valorUnitarioBruto * percentualAcrescimo) / 100;
    _valorUnitarioLiquido = _valorUnitarioBruto + _valorAcrescimoUnitario;
    _valorDescontoUnitario = 0.0;
  }

  double get quantidade {
    return _quantidade;
  }

  double get valorTotalBruto {
    return _quantidade * _valorUnitarioBruto;
  }

  double get valorTotalLiquido {
    return _quantidade * _valorUnitarioLiquido;
  }

  double get percentualDesconto {
    return (_valorDescontoUnitario / _valorUnitarioBruto) * 100;
  }

  double get valorDescontoTotal {
    return _quantidade * _valorDescontoUnitario;
  }

  double get percentualAcrescimo {
    return (_valorAcrescimoUnitario / _valorUnitarioBruto) * 100;
  }

  double get valorAcrescimoTotal {
    return _quantidade * _valorAcrescimoUnitario;
  }
}
