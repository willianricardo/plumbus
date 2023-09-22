import 'package:flutter/material.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/search_params.dart';
import 'package:plumbus/app/domain/repositories/produto_repository_interface.dart';
import 'package:plumbus/app/presentation/components/produto_item.dart';
import 'package:plumbus/core/dependency_injection/dependency_injector.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  List<ProdutoEntity> _produtos = [];

  _onSearch() async {
    IProdutoRepository repository =
        DependencyInjector.get<IProdutoRepository>();

    final params = SearchParams(
      where: ' 1 = 1 ',
      order: ' a.prodescricao ',
      first: 5000,
      skip: 0,
    );

    final result = await repository.buscar(params);

    if (result.isSuccess()) {
      setState(() {
        _produtos = result.tryGetSuccess()!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: _onSearch,
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _produtos.length,
          itemBuilder: (context, index) {
            debugPrint(_produtos.length.toString());
            return ProdutoItem(produto: _produtos[index]);
          },
        ),
      ),
    );
  }
}
