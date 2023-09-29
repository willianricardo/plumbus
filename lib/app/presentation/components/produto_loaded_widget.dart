import 'package:flutter/material.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/presentation/components/produto_item.dart';

class ProdutoLoadedWidget extends StatelessWidget {
  final List<ProdutoEntity> produtos;

  const ProdutoLoadedWidget({
    super.key,
    required this.produtos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        debugPrint(produtos.length.toString());
        return ProdutoItem(produto: produtos[index]);
      },
    );
  }
}
