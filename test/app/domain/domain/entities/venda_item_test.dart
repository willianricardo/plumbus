import 'package:flutter_test/flutter_test.dart';
import 'package:plumbus/app/domain/entities/venda_entity.dart';

import '../builders/produto_builder.dart';
import '../builders/venda_builder.dart';
import '../builders/venda_item_builder.dart';

main() {
  late VendaEntity venda;

  final produto1 = ProdutoBuilder.withValues(
    valor: 10,
  );

  setUp(() {
    venda = VendaBuilder.withValues();
  });
  group('Descontos', () {
    test(
      'deve calcular o total de um item com desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 20.0);
        expect(valorDesconto, 4.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 16.0);
      },
    );

    test(
      'deve calcular o total de um item sem desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 20.0);
      },
    );
  });

  group('Acrescimos', () {
    test(
      'deve calcular o total dos acrescimos de uma venda com um item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 20.0);
        expect(valorAcrescimo, 4.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 24.0);
      },
    );

    test(
      'deve calcular o total de um item sem acrescimo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 20.0);
      },
    );
  });
  group('Totalizações', () {
    test(
      'deve calcular o valor total bruto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final valorTotalBruto = vendaItem.valorTotalBruto;

        // assert
        expect(valorTotalBruto, 20.0);
      },
    );

    test(
      'deve calcular o valor total liquido',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final valorTotalLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(valorTotalLiquido, 20.0);
      },
    );

    test(
      'deve calcular o percentual de desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;

        // assert
        expect(percentualDesconto, 20.0);
      },
    );

    test(
      'deve calcular o valor total de desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final valorTotalDesconto = vendaItem.valorDescontoTotal;

        // assert
        expect(valorTotalDesconto, 4.0);
      },
    );

    test(
      'deve calcular o percentual de acrescimo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final percentualAcrescimo = vendaItem.percentualAcrescimo;

        // assert
        expect(percentualAcrescimo, 20.0);
      },
    );

    test(
      'deve calcular o valor total de acrescimo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final valorTotalAcrescimo = vendaItem.valorAcrescimoTotal;

        // assert
        expect(valorTotalAcrescimo, 4.0);
      },
    );
  });

  group('setQuantidade', () {
    test(
      'deve incrementar a quantidade do item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 20.0);
      },
    );

    test(
      'deve zerar a quantidade quando for informado um valor negativo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(-1.0);

        // act
        final quantidade = vendaItem.quantidade;
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(quantidade, 0.0);
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 0.0);
        expect(valorLiquido, 0.0);
      },
    );

    test(
      'deve incrementar a quantidade do item com desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 20.0);
        expect(valorDesconto, 4.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 16.0);
      },
    );

    test(
      'deve incrementar a quantidade do item com acrescimo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 20.0);
        expect(valorAcrescimo, 4.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 24.0);
      },
    );
  });

  group('setValorDescontoUnitario', () {
    test(
      'deve adicionar o valor de desconto do item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 20.0);
        expect(valorDesconto, 4.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 16.0);
      },
    );
  });
  group('setPercentualDesconto', () {
    test(
      'deve adicionar o percentual de desconto do item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setPercentualDesconto(20.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 20.0);
        expect(valorDesconto, 4.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 16.0);
      },
    );
  });

  group('setValorAcrescimoUnitario', () {
    test(
      'deve adicionar o valor de acrescimo do item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 20.0);
        expect(valorAcrescimo, 4.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 24.0);
      },
    );
  });
  group('setPercentualAcrescimo', () {
    test(
      'deve adicionar o percentual de desconto do item',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setPercentualAcrescimo(20.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 20.0);
        expect(valorAcrescimo, 4.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 24.0);
      },
    );
  });

  group('setProduto', () {
    test(
      'deve alterar o adicionar o unitário do produto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 20.0);
      },
    );

    test(
      'deve zerar a quantidade quando for informado um valor negativo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(-1.0);

        // act
        final quantidade = vendaItem.quantidade;
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(quantidade, 0.0);
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 0.0);
        expect(valorLiquido, 0.0);
      },
    );

    test(
      'deve incrementar a quantidade do item com desconto',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 20.0);
        expect(valorDesconto, 4.0);
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 16.0);
      },
    );

    test(
      'deve incrementar a quantidade do item com acrescimo',
      () async {
        // arrange
        final vendaItem = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        // act
        final percentualDesconto = vendaItem.percentualDesconto;
        final valorDesconto = vendaItem.valorDescontoTotal;
        final percentualAcrescimo = vendaItem.percentualAcrescimo;
        final valorAcrescimo = vendaItem.valorAcrescimoTotal;
        final valorTotal = vendaItem.valorTotalBruto;
        final valorLiquido = vendaItem.valorTotalLiquido;

        // assert
        expect(percentualDesconto, 0.0);
        expect(valorDesconto, 0.0);
        expect(percentualAcrescimo, 20.0);
        expect(valorAcrescimo, 4.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 24.0);
      },
    );
  });
}
