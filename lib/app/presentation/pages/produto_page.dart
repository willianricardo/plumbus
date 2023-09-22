import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/produto_bloc.dart';
import 'package:plumbus/app/presentation/components/produto_item.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  _onSearch() async {
    context.read<ProdutoBloc>().onSearch();
  }

  Future<void> _tryAgain() async {
    context.read<ProdutoBloc>().onSearch();
  }

  _buildInitialState() {
    return Container();
  }

  _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildFailureState(message) {
    return Center(
      child: Column(
        children: [
          Text(message),
          TextButton(
            onPressed: () {
              _tryAgain();
            },
            child: Text(
              AppTranslations.translate('try_again'),
            ),
          ),
        ],
      ),
    );
  }

  _buildSuccessState(produtos) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        debugPrint(produtos.length.toString());
        return ProdutoItem(produto: produtos[index]);
      },
    );
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
        child: BlocBuilder<ProdutoBloc, ProdutoState>(
          builder: (context, state) {
            return switch (state) {
              InitialState() => _buildInitialState(),
              LoadingState() => _buildLoadingState(),
              SuccessState(produtos: final produtos) =>
                _buildSuccessState(produtos),
              FailureState(error: final error) =>
                _buildFailureState(error.message),
            };
          },
        ),
      ),
    );
  }
}
