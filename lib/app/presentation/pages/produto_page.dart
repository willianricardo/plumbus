import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/presentation/block/auth_bloc.dart';
import 'package:plumbus/app/presentation/block/produto_bloc.dart';
import 'package:plumbus/app/presentation/components/produto_item.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({Key? key}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProdutoBloc>(
      create: (_) => ProdutoBloc(),
      child: const ProdutoView(),
    );
  }
}

class ProdutoView extends StatefulWidget {
  const ProdutoView({Key? key}) : super(key: key);

  @override
  State<ProdutoView> createState() => _ProdutoViewState();
}

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class FailureStateWidget extends StatelessWidget {
  final String message;

  const FailureStateWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          TextButton(
            onPressed: () {
              context.read<ProdutoBloc>().onSearch();
            },
            child: Text(
              AppTranslations.translate('try_again'),
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessStateWidget extends StatelessWidget {
  final List<ProdutoEntity> produtos;

  const SuccessStateWidget({
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

class _ProdutoViewState extends State<ProdutoView> {
  _logout() async {
    context.read<AuthBloc>().onLoggedOut();
  }

  _onSearch() async {
    context.read<ProdutoBloc>().onSearch();
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
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<ProdutoBloc, ProdutoState>(
          builder: (context, state) {
            return switch (state) {
              InitialState() => const InitialStateWidget(),
              LoadingState() => const LoadingStateWidget(),
              SuccessState(produtos: final produtos) =>
                SuccessStateWidget(produtos: produtos),
              FailureState(error: final error) =>
                FailureStateWidget(message: error.message),
            };
          },
        ),
      ),
    );
  }
}
