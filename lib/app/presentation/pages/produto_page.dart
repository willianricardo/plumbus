import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/auth_bloc.dart';
import 'package:plumbus/app/presentation/block/produto_bloc.dart';
import 'package:plumbus/app/presentation/components/produto_loaded_widget.dart';
import 'package:plumbus/core/components/initial_widget.dart';
import 'package:plumbus/core/components/loading_widget.dart';
import 'package:plumbus/core/components/try_again_widget.dart';

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

class _ProdutoViewState extends State<ProdutoView> {
  _logout() async {
    context.read<AuthBloc>().onLoggedOut();
  }

  _onSearch() async {
    context.read<ProdutoBloc>().onSearch();
  }

  _onTryAgain() {
    context.read<ProdutoBloc>().onSearch();
  }

  @override
  void initState() {
    super.initState();

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
              InitialState() => const InitialWidget(),
              LoadingState() => const LoadingWidget(),
              SuccessState(produtos: final produtos) => ProdutoLoadedWidget(
                  produtos: produtos,
                ),
              FailureState(error: final error) => TryAgainWidget(
                  message: error.message,
                  onTryAgain: _onTryAgain,
                ),
            };
          },
        ),
      ),
    );
  }
}
