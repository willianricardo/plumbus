import 'package:flutter_test/flutter_test.dart';
import 'package:plumbus/app/domain/entities/venda_entity.dart';

import '../builders/produto_builder.dart';
import '../builders/venda_builder.dart';
import '../builders/venda_item_builder.dart';

main() {
  late VendaEntity venda;

  final produto1 = ProdutoBuilder.withValues(
    id: '1',
    valor: 10.0,
  );

  final produto2 = ProdutoBuilder.withValues(
    id: '2',
    valor: 12.0,
  );

  final produto3 = ProdutoBuilder.withValues(
    id: '3',
    valor: 14.0,
  );

  setUp(() {
    venda = VendaBuilder.withValues();
  });

  group('Descontos', () {
    test(
      'deve calcular o total dos descontos de uma venda com um item',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        venda.addItem(vendaItem1);

        // act
        final percentualDesconto = venda.getPercentualDesconto();
        final valorDesconto = venda.getValorDesconto();
        final percentualAcrescimo = venda.getPercentualAcrescimo();
        final valorAcrescimo = venda.getValorAcrescimo();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

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
      'deve calcular o total dos descontos de uma venda com mais de um item',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorDescontoUnitario(2.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(3.0)
          ..setValorDescontoUnitario(3.0);

        venda
          ..addItem(vendaItem1)
          ..addItem(vendaItem2);

        // act
        final percentualDesconto = venda.getPercentualDesconto();
        final valorDesconto = venda.getValorDesconto();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

        // assert
        expect(percentualDesconto, 22.5);
        expect(valorDesconto, 13.0);
        expect(valorTotal, 56.0);
        expect(valorLiquido, 43.0);
      },
    );

    test(
      'deve calcular o total dos descontos de uma venda com itens sem desconto',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        venda.addItem(vendaItem1);

        // act
        final percentualDesconto = venda.getPercentualDesconto();
        final valorDesconto = venda.getValorDesconto();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

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
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        venda.addItem(vendaItem1);

        // act
        final percentualDesconto = venda.getPercentualDesconto();
        final valorDesconto = venda.getValorDesconto();
        final percentualAcrescimo = venda.getPercentualAcrescimo();
        final valorAcrescimo = venda.getValorAcrescimo();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

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
      'deve calcular o total dos acrescimos de uma venda com mais de um item',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0)
          ..setValorAcrescimoUnitario(2.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(3.0)
          ..setValorAcrescimoUnitario(3.0);

        venda
          ..addItem(vendaItem1)
          ..addItem(vendaItem2);

        // act
        final percentualAcrescimo = venda.getPercentualAcrescimo();
        final valorAcrescimo = venda.getValorAcrescimo();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

        // assert
        expect(percentualAcrescimo, 22.5);
        expect(valorAcrescimo, 13.0);
        expect(valorTotal, 56.0);
        expect(valorLiquido, 69.0);
      },
    );

    test(
      'deve calcular o total dos acrescimos de uma venda com itens sem acrescimo',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        venda.addItem(vendaItem1);

        // act
        final percentualAcrescimo = venda.getPercentualAcrescimo();
        final valorAcrescimo = venda.getValorAcrescimo();
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

        // assert
        expect(percentualAcrescimo, 0.0);
        expect(valorAcrescimo, 0.0);
        expect(valorTotal, 20.0);
        expect(valorLiquido, 20.0);
      },
    );
  });

  group('Itens', () {
    test(
      'não deve considerar na totalização um item inativo',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(1.0);

        final vendaItem3 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto3)
          ..setQuantidade(1.0);

        venda.addItem(vendaItem1);
        venda.addItem(vendaItem2);
        venda.addItem(vendaItem3);

        // act
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

        // assert
        expect(venda.itens.length, 3);
        expect(venda.itensAtivos.length, 2);
        expect(venda.itensInativos.length, 1);
        expect(valorTotal, 22.0);
        expect(valorLiquido, 22.0);
      },
    );

    test(
      'não deve adicionar um item duplicado',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(2.0);

        venda.addItem(vendaItem1);
        venda.addItem(vendaItem2);

        // act
        final valorTotal = venda.getValorTotalBruto();
        final valorLiquido = venda.getValorTotalLiquido();

        // assert
        expect(venda.itens.length, 1);
        expect(valorTotal, 10.0);
        expect(valorLiquido, 10.0);
      },
    );

    test(
      'deve retornar todos os itens da venda',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(1.0);

        final vendaItem3 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto3)
          ..setQuantidade(1.0);

        venda.addItem(vendaItem1);
        venda.addItem(vendaItem2);
        venda.addItem(vendaItem3);

        // act
        final itens = venda.itens;
        final itensAtivos = venda.itensAtivos;
        final itensInativos = venda.itensInativos;
        final totalItens = itensAtivos.length + itensInativos.length;

        // assert
        expect(itens.length, 3);
        expect(itens.length, totalItens);
        expect(itensAtivos.length, 1);
        expect(itensInativos.length, 2);
      },
    );

    test(
      'deve retornar apenas itens inativos',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(1.0);

        final vendaItem3 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto3)
          ..setQuantidade(1.0);

        venda.addItem(vendaItem1);
        venda.addItem(vendaItem2);
        venda.addItem(vendaItem3);

        // act
        final itensInativos = venda.itensInativos;
        final todosInativos = itensInativos.every((element) => !element.ativo);

        // assert
        expect(itensInativos.length, 2);
        expect(todosInativos, isTrue);
      },
    );

    test(
      'deve retornar apenas itens ativos',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(1.0);

        final vendaItem3 = VendaItemBuilder.withValues(ativo: false)
          ..setVenda(venda)
          ..setProduto(produto3)
          ..setQuantidade(1.0);

        venda.addItem(vendaItem1);
        venda.addItem(vendaItem2);
        venda.addItem(vendaItem3);

        // act
        final itensAtivos = venda.itensAtivos;
        final todosAtivos = itensAtivos.every((element) => element.ativo);

        // assert
        expect(itensAtivos.length, 2);
        expect(todosAtivos, isTrue);
      },
    );

    test(
      'deve verificar se item já foi inserido na venda',
      () async {
        // arrange
        final vendaItem1 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem2 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto1)
          ..setQuantidade(1.0);

        final vendaItem3 = VendaItemBuilder.withValues()
          ..setVenda(venda)
          ..setProduto(produto2)
          ..setQuantidade(1.0);

        venda.addItem(vendaItem1);

        // act
        final possuiItemJaIncluso = venda.possuiItem(vendaItem2);
        final possuiItemNaoIncluso = venda.possuiItem(vendaItem3);

        // assert
        expect(possuiItemJaIncluso, isTrue);
        expect(possuiItemNaoIncluso, isFalse);
      },
    );
  });
}
