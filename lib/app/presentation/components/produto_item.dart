import 'package:flutter/material.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';

class ProdutoItem extends StatelessWidget {
  final ProdutoEntity produto;

  const ProdutoItem({
    Key? key,
    required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Código: ${produto.id}',
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          Text(
            produto.descricao,
          ),
        ],
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          'assets/images/produto_100px.png',
        ),
      ),
      subtitle: const Text(
        'Estoque: 0,00 UN',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      trailing: Text(
        '${produto.valor}',
      ),
    );
  }
}
