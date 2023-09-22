import 'dart:convert';

import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/data/models/api/produto_model.dart';
import 'package:plumbus/app/domain/entities/produto_entity.dart';
import 'package:plumbus/app/domain/entities/search_params.dart';
import 'package:plumbus/app/domain/errors/errors.dart';
import 'package:plumbus/app/domain/repositories/produto_repository_interface.dart';
import 'package:plumbus/core/adapters/http/client_adapter_interface.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class ProdutoRepository implements IProdutoRepository {
  final IClientAdapter http;

  ProdutoRepository(this.http);

  @override
  Future<Result<List<ProdutoEntity>, Failure>> buscar(
    SearchParams params,
  ) async {
    try {
      final response = await http.post(
        '/"ProdutoSelect"',
        body: json.encode({
          'where': params.where,
          'firstSkip': ' first ${params.first} skip ${params.skip} ',
          'order': params.order,
        }),
      );

      if (response.statusCode == 200) {
        final list = (json.decode(response.body) as List)
            .map((e) => ProdutoModel.fromMap(e))
            .toList();

        return Success(list);
      } else {
        return Error(
          ServerFailure(
            AppTranslations.translate('connection_error'),
          ),
        );
      }
    } catch (e) {
      return Error(
        ServerFailure(
          AppTranslations.translate('connection_error'),
        ),
      );
    }
  }
}
