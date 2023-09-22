import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/search_params.dart';
import 'package:plumbus/app/domain/errors/errors.dart';
import 'package:plumbus/app/domain/repositories/produto_repository_interface.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class ProdutoRepository implements IProdutoRepository {
  List<ProdutoEntity> produtos = [];

  @override
  Future<Result<List<ProdutoEntity>, Failure>> buscar(
    SearchParams params,
  ) async {
    try {
      produtos = [
        const ProdutoEntity(
          id: '1',
          ativo: true,
          descricao: 'Produto 1',
          valor: 10,
        ),
        const ProdutoEntity(
          id: '2',
          ativo: true,
          descricao: 'Produto 2',
          valor: 12,
        ),
        const ProdutoEntity(
          id: '3',
          ativo: true,
          descricao: 'Produto 3',
          valor: 10,
        ),
        const ProdutoEntity(
          id: '4',
          ativo: true,
          descricao: 'Produto 4',
          valor: 15,
        ),
      ];

      return Success(produtos);
    } catch (e) {
      return Error(
        ServerFailure(
          AppTranslations.translate('connection_error'),
        ),
      );
    }
  }
}
