import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/search_params.dart';
import 'package:plumbus/app/domain/errors/errors.dart';

abstract class IProdutoRepository {
  Future<Result<List<ProdutoEntity>, Failure>> buscar(SearchParams params);
}
