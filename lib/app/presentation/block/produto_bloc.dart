import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/search_params.dart';
import 'package:plumbus/app/domain/errors/errors.dart';
import 'package:plumbus/app/domain/repositories/produto_repository_interface.dart';
import 'package:plumbus/core/dependency_injection/dependency_injector.dart';

class ProdutoBloc extends Cubit<ProdutoState> {
  ProdutoBloc() : super(const InitialState());

  void onSearch() async {
    emit(const LoadingState());

    final params = SearchParams(
      where: ' 1 = 1 ',
      order: ' a.prodescricao ',
      first: 5000,
      skip: 0,
    );

    final repository = DependencyInjector.get<IProdutoRepository>();

    var result = await repository.buscar(params);

    result.when((produtos) {
      emit(SuccessState(produtos));
    }, (error) {
      emit(FailureState(error));
    });
  }
}

sealed class ProdutoState {}

class InitialState implements ProdutoState {
  const InitialState();
}

class LoadingState implements ProdutoState {
  const LoadingState();
}

class SuccessState implements ProdutoState {
  final List<ProdutoEntity> produtos;

  const SuccessState(this.produtos);
}

class FailureState implements ProdutoState {
  final Failure error;

  const FailureState(this.error);
}
